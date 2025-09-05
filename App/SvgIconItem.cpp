#include "SvgIconItem.h"
#include <QSvgRenderer>
#include <QPainter>
#include <QFile>
#include <QFileInfo>
#include <QResource>
#include <QDebug>

static QString toDevicePath(const QUrl& url)
{
    if (!url.isValid())
        return {};
    if (url.scheme() == QStringLiteral("qrc"))
        return QStringLiteral(":") + url.path(); // ":/..."
    if (url.isLocalFile())
        return url.toLocalFile();

    QString s = url.toString();
    if (s.startsWith(QStringLiteral(":/")))
        return s;
    if (s.startsWith(QStringLiteral(":")))
    {
        if (s.size() < 2 || s[1] != QChar('/'))
            s.insert(1, QChar('/'));
        return s;
    }
    // 상대 경로는 :/icons/ 기준으로 해석
    return QStringLiteral(":/icons/") + s;
}

SvgIconItem::SvgIconItem(QQuickItem* parent)
    : QQuickPaintedItem(parent)
{
    setAntialiasing(true);
    setRenderTarget(QQuickPaintedItem::FramebufferObject);
}

SvgIconItem::~SvgIconItem() = default;

void SvgIconItem::ensureSvg()
{
    if (!m_svg)
        m_svg = std::make_unique<QSvgRenderer>();
}

void SvgIconItem::applySource()
{
    const QString path = toDevicePath(m_source);
    if (path.isEmpty())
        return;

    ensureSvg();
    if (QFile::exists(path))
    {
        if (!m_svg->load(path))
        {
            qWarning() << "[SvgIconItem] Failed to load SVG from" << path;
        }
    }
    else
    {
        QFile f(path);
        if (!f.open(QIODevice::ReadOnly))
        {
            qWarning() << "[SvgIconItem] Failed to open" << path;
            return;
        }
        const QByteArray bytes = f.readAll();
        f.close();
        if (!m_svg->load(bytes))
        {
            qWarning() << "[SvgIconItem] Failed to parse SVG bytes from" << path;
            return;
        }
    }
    updateImplicitSize();
    update();
}

void SvgIconItem::setSource(const QUrl& url) {
    if (m_source == url)
        return;
    m_source = url;
    emit sourceChanged();
    applySource();
}

void SvgIconItem::setElementId(const QString& id) {
    if (m_elementId == id)
        return;
    m_elementId = id;
    emit elementIdChanged();
    updateImplicitSize();
    update();
}

void SvgIconItem::setSmooth(bool s) {
    if (m_smooth == s)
        return;
    m_smooth = s;
    emit smoothChanged();
    update();
}

void SvgIconItem::setDevicePixelRatio(qreal dpr)
{
    if (qFuzzyCompare(m_dpr, dpr))
        return;
    m_dpr = dpr;
    emit devicePixelRatioChanged();
    update();
}

void SvgIconItem::setFitMode(FitMode m)
{
    if (m_fitMode == m)
        return;
    m_fitMode = m;
    emit fitModeChanged();
    update();
}

QRectF SvgIconItem::elementBounds() const {
    if (!m_svg || !m_svg->isValid())
        return {};
    if (!m_elementId.isEmpty() && m_svg->elementExists(m_elementId)) {
        const QRectF b = m_svg->boundsOnElement(m_elementId);
        if (!b.isEmpty())
            return b;
    }
    const QSize sz = m_svg->defaultSize();
    if (!sz.isEmpty())
        return QRectF(QPointF(0, 0), sz);
    return QRectF(0, 0, width(), height());
}

void SvgIconItem::updateImplicitSize()
{
    const QRectF b = elementBounds();
    if (!b.isEmpty())
    {
        // 기본 아이콘 크기 힌트(24 또는 SVG 기본 크기)
        const qreal base = 24.0;
        const qreal scale = b.height() > 0 ? base / b.height() : 1.0;
        setImplicitWidth(b.width() * scale);
        setImplicitHeight(b.height() * scale);
    }
    else
    {
        setImplicitWidth(24);
        setImplicitHeight(24);
    }
}

#if QT_VERSION >= QT_VERSION_CHECK(6, 0, 0)
void SvgIconItem::geometryChange(const QRectF& n, const QRectF& o)
{
    QQuickPaintedItem::geometryChange(n, o);
    // 필요 시, 기존에 geometryChanged에서 하던 처리 로직을 그대로 유지
}
#else
void SvgIconItem::geometryChanged(const QRectF& n, const QRectF& o)
{
    QQuickPaintedItem::geometryChanged(n, o);
    // 필요 시, 기존 처리 로직 유지
}
#endif


void SvgIconItem::paint(QPainter* p) {
    if (!m_svg || !m_svg->isValid())
        return;

    p->setRenderHint(QPainter::Antialiasing, m_smooth);
    p->setRenderHint(QPainter::SmoothPixmapTransform, m_smooth);

    const QRectF srcBounds = elementBounds();
    if (srcBounds.isEmpty())
        return;

    const QRectF dstRect(0, 0, width(), height());
    if (dstRect.isEmpty())
        return;

    // 소스->대상 변환 계산
    const qreal sx = dstRect.width() / srcBounds.width();
    const qreal sy = dstRect.height() / srcBounds.height();

    qreal scaleX = sx;
    qreal scaleY = sy;
    QPointF topLeft = dstRect.topLeft();

    switch (m_fitMode)
    {
    case PreserveAspectFit:
        {
            const qreal s = qMin(sx, sy);
            const QSizeF scaled(srcBounds.size() * s);
            const QPointF offset((dstRect.width() - scaled.width()) / 2.0,
                                 (dstRect.height() - scaled.height()) / 2.0);
            scaleX = scaleY = s;
            topLeft += offset;
            break;
        }
    case PreserveAspectCrop:
        {
            const qreal s = qMax(sx, sy);
            const QSizeF scaled(srcBounds.size() * s);
            const QPointF offset((dstRect.width() - scaled.width()) / 2.0,
                                 (dstRect.height() - scaled.height()) / 2.0);
            scaleX = scaleY = s;
            topLeft += offset;
            break;
        }
    case Stretch:
        // sx, sy 그대로 사용
        break;
    case None:
        // 스케일링 없이 좌상단 정렬
        scaleX = scaleY = 1.0;
        break;
    }

    p->save();
    // 대상 프레임 기준 이동
    p->translate(topLeft);
    // 스케일 적용
    p->scale(scaleX, scaleY);
    // SVG의 원점 보정
    p->translate(-srcBounds.topLeft());

    if (!m_elementId.isEmpty() && m_svg->elementExists(m_elementId)) {
        m_svg->render(p, m_elementId, srcBounds);
    } else {
        m_svg->render(p, srcBounds);
    }

    p->restore();
}