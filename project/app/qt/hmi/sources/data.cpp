#include "data.h"


Data::Data()
{
    m_screen_width = 480;
    m_screen_height = 480;
    m_darkmode = true;
}


int Data::screen_height() const
{
    return m_screen_height;
}

void Data::setScreen_height(int newScreen_height)
{
    if (m_screen_height == newScreen_height)
        return;
    m_screen_height = newScreen_height;
    emit screen_heightChanged();
}

int Data::screen_width() const
{
    return m_screen_width;
}

void Data::setScreen_width(int newScreen_width)
{
    if (m_screen_width == newScreen_width)
        return;
    m_screen_width = newScreen_width;
    emit screen_widthChanged();
}



Data* Data::instance(QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    static Data instace;
    return &instace;
}

bool Data::darkmode() const
{
    return m_darkmode;
}

void Data::setDarkmode(bool newDarkmode)
{
    if (m_darkmode == newDarkmode)
        return;
    m_darkmode = newDarkmode;
    emit darkmodeChanged();
}
