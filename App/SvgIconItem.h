//
// Created by Justmoong on 8/13/25.
//

#pragma once
#include <QQuickPaintedItem>
#include <QUrl>
#include <memory>
#include <QSvgRenderer>

class SvgIconItem : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QUrl source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(QString elementId READ elementId WRITE setElementId NOTIFY elementIdChanged)
    Q_PROPERTY(bool smooth READ smooth WRITE setSmooth NOTIFY smoothChanged)
    Q_PROPERTY(qreal devicePixelRatio READ devicePixelRatio WRITE setDevicePixelRatio NOTIFY devicePixelRatioChanged)

public:
    explicit SvgIconItem(QQuickItem* parent = nullptr);
    ~SvgIconItem() override;

    void paint(QPainter* painter) override;

    QUrl source() const { return m_source; }
    void setSource(const QUrl& url);

    QString elementId() const { return m_elementId; }
    void setElementId(const QString& id);

    bool smooth() const { return m_smooth; }
    void setSmooth(bool s);

    qreal devicePixelRatio() const { return m_dpr; }
    void setDevicePixelRatio(qreal dpr);

signals:
    void sourceChanged();
    void elementIdChanged();
    void smoothChanged();
    void devicePixelRatioChanged();

private:
    void ensureSvg();
    void applySource();
    void updateImplicitSize();
    QRectF elementBounds() const;

private:
    QUrl m_source;
    QString m_elementId;
    bool m_smooth = true;
    qreal m_dpr = 0.0; // QQuickPaintedItem가 DPR을 처리하므로 보통 필요 없음
    std::unique_ptr<QSvgRenderer> m_svg;
};
