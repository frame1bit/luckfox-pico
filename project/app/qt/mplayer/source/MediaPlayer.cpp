#include <cstdio>
#include "MediaPlayer.h"

MediaPlayer::MediaPlayer(QObject *parent) : QObject(parent)
{
    printf("This is constructor!\n");
    mTimerPlayer.setInterval(1000);
    //QObject *context = new QObject(this);
    QObject::connect(&mTimerPlayer, &QTimer::timeout, this, &MediaPlayer::timerTimeoutHandler);
}


void MediaPlayer::timerTimeoutHandler()
{
    // do something
    this->player_run();
    
}

void MediaPlayer::player_run()
{
    if (position() > cduration) {
        setPosition(0);
    }
    setPosition( position() + 1000 );
    //setPosition = mPosition;
    //printf("Timer tick: %d\n", mPosition);
}

void MediaPlayer::setPlaybackState(int value)
{
    if (mPlaybackState != value)
    {
        mPlaybackState = value;
        emit sigPlaybackState(value);
    }
}

void MediaPlayer::setSource(QString source)
{
    if (mSource != source)
    {
        printf("Source: %s\n", source.toStdString().c_str());
        mSource = source;
        emit sigSource(source);
    }
}

void MediaPlayer::setStatus(int status)
{
    if (mStatus != status) {
        mStatus = status;
        emit sigStatus(status);
    }
}

void MediaPlayer::setSeekable(bool value)
{
    if (mSeekable != value) {
        mSeekable = value;
        emit sigSeekable(value);
    }
}

void MediaPlayer::setDuration(int value)
{
    if (mDuration != value) {
        mDuration = value;
        emit sigDuration(value);
    }
}
void MediaPlayer::setSeek(int value)
{
    printf("Do seek %d !\n", value);
}
void MediaPlayer::play()
{
    if (mTimerPlayer.isActive() == false) {
        printf("Do playing..");
        emit playing();
        mTimerPlayer.start();
        mDuration = 60 * 1000;
    } else {
        mTimerPlayer.stop();
        emit paused();
    }
}
void MediaPlayer::setBufferProgress(int value)
{
    if (mBufferProgress != value ) {
        mBufferProgress = value;
        emit sigBufferProgress(value);
    }
}
void MediaPlayer::setPosition(int value)
{
    if (mPosition != value ) {
        mPosition = value;
        emit sigPosition(value);
    }
}


void MediaPlayer::setMetaData(QJsonObject value)
{
    if (mMetadata != value) {
        mMetadata = value;
        emit sigMetadata(value);
    }
}


MediaPlayer::~MediaPlayer()
{

}
