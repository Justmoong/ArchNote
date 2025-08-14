//
// Created by Justmoong on 8/13/25.
//

#include "SvgIconItem.h"
#include <QPainter>
#include <QFileInfo>
#include <QGuiApplication>
#include <QQuickWindow>

SvgIconItem::SvgIconItem(QQuickItem* parent)
    : QQuickPaintedItem(parent)
{
    setAntialiasing(true);
    setRenderTarget(QQuickPaintedItem::FramebufferObject);
    ensureSvg();
}

SvgIconItem::~SvgIconItem() = default;

void SvgIconItem::ensureSvg()
{
    if (m_svg)
        return;
    m_svg = std::make_unique<KSvg::Svg>();

    // Plasma 테마 변경 등으로 SVG 재렌더가 필요할 때 자동 갱신
    connect(m_svg.get(), &KSvg::Svg::repaintNeeded, this, [this]
    {
        updateImplicitSize();
        update();
    });
}

void SvgIconItem::setSource(const QUrl& url)
{
    if (m_source == url)
        return;
    m_source = url;
    applySource();
    emit sourceChanged();
    update();
}

void SvgIconItem::setElementId(const QString& id)
{
    if (m_elementId == id)
        return;
    m_elementId = id;
    // 다중 요소 사용 여부 힌트
    if (m_svg)
        m_svg->setContainsMultipleImages(!m_elementId.isEmpty());
    emit elementIdChanged();
    updateImplicitSize();
    update();
}

void SvgIconItem::setSmooth(bool s)
{
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

void SvgIconItem::applySource()
{
    ensureSvg();
    if (!m_svg)
        return;

    const QString local = m_source.isEmpty()
                              ? QString()
                              : (m_source.isLocalFile() ? m_source.toLocalFile() : m_source.toString()); // qrc:/ 포함

    // 이미지 경로 지정
    m_svg->setImagePath(local);
    m_svg->setContainsMultipleImages(!m_elementId.isEmpty());
    updateImplicitSize();
}

QRectF SvgIconItem::elementBounds() const
{
    if (!m_svg)
        return {};

    if (!m_elementId.isEmpty())
    {
        if (!m_svg->hasElement(m_elementId))
            return {};
        const QSizeF s = m_svg->elementSize(m_elementId);
        return QRectF(QPointF(0.0, 0.0), s);
    }

    // 요소 ID가 없으면 전체 문서 크기
    const QSizeF s = m_svg->size();
    if (s.isEmpty())
        return {};
    return QRectF(QPointF(0.0, 0.0), s);
}

void SvgIconItem::updateImplicitSize()
{
    const QRectF b = elementBounds();
    if (b.isValid() && b.width() > 0 && b.height() > 0)
    {
        setImplicitWidth(b.width());
        setImplicitHeight(b.height());
    }
    else
    {
        setImplicitWidth(24);
        setImplicitHeight(24);
    }
}

void SvgIconItem::paint(QPainter* painter)
{
    if (!m_svg)
        return;

    painter->setRenderHint(QPainter::Antialiasing, m_smooth);
    painter->setRenderHint(QPainter::SmoothPixmapTransform, m_smooth);

    const QRectF target(0, 0, width(), height());
    const qreal effectiveDpr = (m_dpr > 0.0)
                                   ? m_dpr
                                   : (window() ? window()->devicePixelRatio() : qApp->devicePixelRatio());

    // 선택 사항: KSvg::Svg가 지원하는 경우에만 사용
    // m_svg->setDevicePixelRatio(effectiveDpr);

    if (!m_elementId.isEmpty() && m_svg->hasElement(m_elementId))
    {
        // 인자 순서: (painter, rect, elementId)
        m_svg->paint(painter, target, m_elementId);
    } else {
        m_svg->paint(painter, target);
    }
}