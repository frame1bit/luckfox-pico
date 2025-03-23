#include <QObject>
#include <QJsonObject>
#include <QTimer>

class MediaPlayer : public QObject {
    Q_OBJECT

public:
    const int cduration = 60 * 1000;

    // Q_PROPERTY(QString imageURL READ imageURL WRITE setImageURL)
    Q_PROPERTY(int playbackstate READ playbackstate WRITE setPlaybackState NOTIFY sigPlaybackState)
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sigSource)
    Q_PROPERTY(int status READ status WRITE setStatus NOTIFY sigStatus)
    Q_PROPERTY(bool seekable READ seekable WRITE setSeekable NOTIFY sigSeekable)
    Q_PROPERTY(int duration READ duration WRITE setDuration NOTIFY sigDuration)
    Q_PROPERTY(int bufferProgress READ bufferProgress WRITE setBufferProgress NOTIFY sigBufferProgress)
    Q_PROPERTY(int position READ position WRITE setPosition NOTIFY sigPosition)
    Q_PROPERTY(QJsonObject metaData READ metaData WRITE setMetaData NOTIFY sigMetadata)

    explicit MediaPlayer(QObject *parent=nullptr);
    virtual ~MediaPlayer();

    int playbackstate() {return mPlaybackState; }
    QString source() { return mSource; }
    int status() { return mStatus; }
    bool seekable() { return mSeekable; }
    int duration() { return mDuration; }
    int bufferProgress() { return mBufferProgress; }
    int position() { return mPosition; }
    QJsonObject metaData() { return mMetadata; }

    void setPlaybackState(int value);
    void setSource(QString source);
    void setStatus(int status);
    void setSeekable(bool value);
    void setDuration(int value);
    Q_INVOKABLE void setSeek(int value);
    Q_INVOKABLE void play();
    void setBufferProgress(int value);
    void setPosition(int value);
    void setMetaData(QJsonObject value);



signals:
    void sigPlaybackState(int newValue);
    void sigSource(const QString &newValue);
    void sigStatus(int newValue);
    void sigSeekable(bool newValue);
    void sigDuration(int newValue);
    void sigBufferProgress(int newValue);
    void sigPosition(int newValue);
    void sigMetadata(const QJsonObject &newValue);
    void paused();
    void playing();
    void stopped();
    void mediaObjectChanged();
    void error();


private:
    int mPlaybackState = 0;
    QString mSource = "";
    int mStatus = 0;
    bool mSeekable = true;
    int mDuration = 60 * 1000;
    int mBufferProgress = 1;
    int mPosition = 2;
    bool mIsPlaying = false;
    QJsonObject mMetadata = {
        {"title" , "Belum ada judulnya"},
        {"albumTitle" , "Album masih dipikirkan"}
    };

    QTimer mTimerPlayer;

    void timerTimeoutHandler();
    void player_run();

};
