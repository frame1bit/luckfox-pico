#ifndef DEVICECOMMUNICATION_H
#define DEVICECOMMUNICATION_H

#include <QObject>
#include <QtSerialPort/QSerialPort>
#include <QSerialPortInfo>
#include <QTimer>
#include <QProcess>
#include <QJsonObject>
#include <QJsonDocument>

/** communication header */
#define COM_HEADER_1ST  0x12
#define COM_HEADER_2ND  0x21
#define COM_HEADER_3RD  0x34
#define COM_HEADER_4TH  0x76

/** function code */
#define FUNCTION_CODE_WRITE 0x06
#define FUNCTION_CODE_READ  0x03

/** address register */
// read
#define ADDR_REG_CHECK_COM              0x0000
#define ADDR_REG_CHECK_ENROLL_STATUS    0x0001
#define ADDR_REG_CHECK_ID_FINGER        0x0002
#define ADDR_REG_BATTERY_STATUS         0x0003
#define ADDR_REG_FIRMWARE_VERSION       0x0004

#define ADDR_REG_ADC1_VALUE             0x0005
#define ADDR_REG_ADC2_VALUE             0x0006
#define ADDR_REG_VOLUME                 0x0007

// write
#define ADDR_REG_ENROLL_LOOP    0x0001
#define ADDR_REG_DELETE_FINGER  0x0002
#define ADDR_REG_CANCEL_ENROLL  0x0003
#define ADDR_REG_RESET_SYSTEM   0x0004

#define RX_BUFFER_LEN   100

struct serialData {
    int index = 0;
    uint8_t data;
    uint8_t buffer[RX_BUFFER_LEN];
    uint16_t crc16;
};

class DeviceCommunication : public QObject
{
    Q_OBJECT


public:
    DeviceCommunication(QObject *parent=nullptr);
    ~DeviceCommunication();

    void openSerialPort(const QSerialPortInfo &info);
    void closeSerialPort();
    void writeData(const QByteArray &data);
    void TimerCallback();

signals:
    void dataReceived(const QString &data);
    void processData();
    void auxDataTriggered(const QVariantMap &jsonData);

public slots:
    void autoConnect();

private slots:
    void readData();
    void parsingData();
    void handleError(QSerialPort::SerialPortError error);

private:
    QSerialPort *serialPort;
    serialData serialdata;
    uint16_t m_data_len;
    QTimer *m_timer;
    QProcess process;
    QJsonObject dataAux;

    bool m_port_scanning = true;
    void parsingDataRead(uint16_t reg, uint8_t *data, uint16_t len);
    void parsingDataWrite(uint16_t reg, uint8_t *data, uint16_t len);

};

#endif // DEVICECOMMUNICATION_H
