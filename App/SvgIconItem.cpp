#include "SvgIconItem.h"

#include <QPainter>
#include <QFile>
#include <QQuickWindow>
#include <QLoggingCategory>
#include <QDebug>

static QString toLocalOrQrcPath(const QUrl& url)
{
    // qrc:/icons/foo.svg -> :/icons/foo.svg
    if (url.scheme() == QLatin1String("qrc")) {
        return QLatin1Char(':') + url.path(); // path()는 /icons/foo.svg 형태
    }
    if (url.isLocalFile()) {
        return url.toLocalFile();
    }
    // 이미 :/ 로 시작하는 리소스나, 단순 상대 경로 대응
    const QString s = url.toString();
    if (s.startsWith(QLatin1String(":/")))
        return s;
    return s;
}

SvgIconItem::SvgIconItem(QQuickItem* parent)
    : QQuickPaintedItem(parent)
{
    setFlag(ItemHasContents, true);
    setAcceptedMouseButtons(Qt::NoButton);
    setAntialiasing(m_smooth);
    // RHI(예: Metal)에서도 안전하게 동작
    setRenderTarget(QQuickPaintedItem::FramebufferObject);
}

SvgIconItem::~SvgIconItem() = default;

void SvgIconItem::ensureSvg()
{
    if (!m_svg) {
        m_svg = std::make_unique<QSvgRenderer>();
    }
}

void SvgIconItem::applySource()
{
    ensureSvg();

    if (m_source.isEmpty()) {
        m_svg->load(QByteArray{});
        update();
        return;
    }

    const QString path = toLocalOrQrcPath(m_source);
    QFile f(path);
    if (!f.open(QIODevice::ReadOnly)) {
        qWarning() << "[SvgIconItem] Failed to open" << path;
        m_svg->load(QByteArray{});
        updateImplicitSize();
        update();
        return;
    }

    const QByteArray data = f.readAll();
    if (!m_svg->load(data) || !m_svg->isValid()) {
        qWarning() << "[SvgIconItem] Invalid SVG:" << path;
    }
    updateImplicitSize();
    update();
}

void SvgIconItem::setSource(const QUrl& url)
{
    if (url == m_source)
        return;
    m_source = url;
    applySource();
    emit sourceChanged();
}

void SvgIconItem::setElementId(const QString& id)
{
    if (id == m_elementId)
        return;
    m_elementId = id;
    updateImplicitSize();
    update();
    emit elementIdChanged();
}

void SvgIconItem::setSmooth(bool s)
{
    if (s == m_smooth)
        return;
    m_smooth = s;
    setAntialiasing(m_smooth);
    update();
    emit smoothChanged();
}

void SvgIconItem::setDevicePixelRatio(qreal dpr)
{
    if (qFuzzyCompare(dpr, m_dpr))
        return;
    m_dpr = dpr;
    // 일반적으로 QQuickPaintedItem가 DPR을 처리하므로 추가 스케일은 불필요
    update();
    emit devicePixelRatioChanged();
}

static QRectF viewRectForRenderer(QSvgRenderer* r)
{
    if (!r || !r->isValid())
        return {};

    QRectF vb = r->viewBoxF();
    if (!vb.isEmpty())
        return vb;

    // 일부 SVG는 viewBox 없이 width/height만 있을 수 있음
    const QSize sz = r->defaultSize();
    if (!sz.isEmpty())
        return QRectF(QPointF(0, 0), sz);

    return {};
}

QRectF SvgIconItem::elementBounds() const
{
    if (!m_svg || !m_svg->isValid())
        return {};

    if (!m_elementId.isEmpty() && m_svg->elementExists(m_elementId)) {
        const QRectF b = m_svg->boundsOnElement(m_elementId);
        if (!b.isEmpty())
            return b;
        // 요소 bounds가 비면 전체로 폴백
    }
    return viewRectForRenderer(m_svg.get());
}

void SvgIconItem::updateImplicitSize()
{
    QRectF b = elementBounds();
    QSizeF s = b.size();
    if (s.isEmpty()) {
        // 폴백: 24x24 아이콘
        s = QSizeF(24, 24);
    }
    setImplicitSize(s.width(), s.height());
}

void SvgIconItem::paint(QPainter* p)
{
    if (!m_svg || !m_svg->isValid())
        return;

    const qreal w = width();
    const qreal h = height();
    if (w <= 0 || h <= 0)
        return;

    const QRectF src = elementBounds();
    if (src.isEmpty())
        return;

    p->save();
    p->setRenderHint(QPainter::Antialiasing, m_smooth);

    // 비율 유지 스케일 + 중앙 정렬
    const qreal sx = w / src.width();
    const qreal sy = h / src.height();
    const qreal s = std::min(sx, sy);

    const qreal tx = (w - s * src.width()) * 0.5 - s * src.left();
    const qreal ty = (h - s * src.height()) * 0.5 - s * src.top();

    p->translate(tx, ty);
    p->scale(s, s);

    if (!m_elementId.isEmpty() && m_svg->elementExists(m_elementId)) {
        m_svg->render(p, m_elementId);
    } else {
        m_svg->render(p);
    }

    p->restore();
}