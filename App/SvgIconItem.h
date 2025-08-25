#pragma once
#include <QQuickPaintedItem>
#include <QUrl>
#include <QString>
#include <QRectF>
#include <memory>

class QSvgRenderer;

class SvgIconItem : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QUrl source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(QString elementId READ elementId WRITE setElementId NOTIFY elementIdChanged)
    Q_PROPERTY(bool smooth READ smooth WRITE setSmooth NOTIFY smoothChanged)
    Q_PROPERTY(qreal devicePixelRatio READ devicePixelRatio WRITE setDevicePixelRatio NOTIFY devicePixelRatioChanged)

public:
    enum FitMode {
        PreserveAspectFit = 0,  // 프레임에 맞춰 비율 유지, 전체 보이기
        PreserveAspectCrop,     // 프레임을 꽉 채우되 비율 유지(잘릴 수 있음)
        Stretch,                // 프레임에 정확히 맞춤(비율 무시)
        None                    // 스케일링 안 함(원본 크기)
    };
    Q_ENUM(FitMode)
    Q_PROPERTY(FitMode fitMode READ fitMode WRITE setFitMode NOTIFY fitModeChanged)

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

    FitMode fitMode() const { return m_fitMode; }
    void setFitMode(FitMode m);

signals:
    void sourceChanged();
    void elementIdChanged();
    void smoothChanged();
    void devicePixelRatioChanged();
    void fitModeChanged();

#if QT_VERSION >= QT_VERSION_CHECK(6, 0, 0)
protected:
    void geometryChange(const QRectF& newGeometry, const QRectF& oldGeometry) override;
#else
protected:
    void geometryChanged(const QRectF& newGeometry, const QRectF& oldGeometry) override;
#endif


private:
    void ensureSvg();
    void applySource();
    void updateImplicitSize();
    QRectF elementBounds() const;

private:
    QUrl m_source;
    QString m_elementId;
    bool m_smooth = true;
    qreal m_dpr = 0.0;
    FitMode m_fitMode = PreserveAspectFit;
    std::unique_ptr<QSvgRenderer> m_svg;
};