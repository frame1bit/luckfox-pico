#ifndef DATA_H
#define DATA_H

#include <QObject>
#include <QQmlApplicationEngine>

class Data : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int screen_height READ screen_height WRITE setScreen_height NOTIFY screen_heightChanged FINAL)
    Q_PROPERTY(int screen_width READ screen_width WRITE setScreen_width NOTIFY screen_widthChanged FINAL)
    Q_PROPERTY(bool darkmode READ darkmode WRITE setDarkmode NOTIFY darkmodeChanged FINAL)

public:
    Data();
    Data(int screen_height, int screen_width);
    static Data* instance(QQmlEngine *engine, QJSEngine *scriptEngine);
    int screen_height() const;
    void setScreen_height(int newScreen_height);
    int screen_width() const;
    void setScreen_width(int newScreen_width);

    bool darkmode() const;
    void setDarkmode(bool newDarkmode);

signals:
    void screen_heightChanged();
    void screen_widthChanged();

    void darkmodeChanged();

private:
    int m_screen_height = 480;
    int m_screen_width = 800;
    bool m_darkmode;
};

#endif // DATA_H
