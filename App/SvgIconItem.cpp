//
// Created by Justmoong on 8/13/25.
//

// SvgIconItem.cpp (C++)
#include "SvgIconItem.h"
#include <KSvg/Renderer>
#include <QPainter>
#include <QFileInfo>
#include <QGuiApplication>
#include <QWindow>

SvgIconItem::SvgIconItem(QQuickItem* parent)
    : QQuickPaintedItem(parent)
{
    setAntialiasing(true);
    setRenderTarget(QQuickPaintedItem::FramebufferObject);
}

SvgIconItem::~SvgIconItem() = default;

void SvgIconItem::setSource(const QUrl& url)
{
    if (m_source == url)
        return;
    m_source = url;
    loadRenderer();
    emit sourceChanged();
    update();
}

void SvgIconItem::setElementId(const QString& id)
{
    if (m_elementId == id)
        return;
    m_elementId = id;
    emit elementIdChanged();
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

void SvgIconItem::loadRenderer()
{
    m_renderer.reset();

    if (!m_source.isEmpty()) {
        const QString local = m_source.isLocalFile()
            ? m_source.toLocalFile()
            : m_source.toString(); // qrc:/, :/ 등 경로도 허용

        if (!local.isEmpty()) {
            auto renderer = std::make_unique<KSvg::Renderer>();
            if (renderer->load(local)) {
                m_renderer = std::move(renderer);
                // 암시 크기 갱신(가능하면 SVG의 뷰박스/요소 크기를 사용)
                const QRectF b = elementBounds();
                if (b.isValid() && b.width() > 0 && b.height() > 0) {
                    setImplicitWidth(b.width());
                    setImplicitHeight(b.height());
                } else {
                    setImplicitWidth(24);
                    setImplicitHeight(24);
                }
            }
        }
    }
}

QRectF SvgIconItem::elementBounds() const
{
    if (!m_renderer)
        return {};
    if (!m_elementId.isEmpty())
        return m_renderer->boundsOnElement(m_elementId);
    // 전체 문서의 뷰박스
    return m_renderer->boundsOnElement(QStringLiteral("")); // 빈 값: 전체
}

void SvgIconItem::paint(QPainter* painter)
{
    if (!m_renderer)
        return;

    painter->setRenderHint(QPainter::Antialiasing, m_smooth);
    painter->setRenderHint(QPainter::SmoothPixmapTransform, m_smooth);

    const QRectF target(0, 0, width(), height());

    // 고해상도 디스플레이 고려
    const qreal effectiveDpr = (m_dpr > 0.0)
        ? m_dpr
        : (window() ? window()->devicePixelRatio() : qApp->devicePixelRatio());

    painter->save();
    painter->scale(1.0, 1.0); // 필요 시 스케일 조정 지점

    if (!m_elementId.isEmpty() && m_renderer->elementExists(m_elementId)) {
        m_renderer->render(painter, m_elementId, target);
    } else {
        m_renderer->render(painter, target);
    }

    painter->restore();

    Q_UNUSED(effectiveDpr);
}