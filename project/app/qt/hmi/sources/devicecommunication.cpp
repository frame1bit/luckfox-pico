/**
* file: DeviceCommunication.cpp
* brief:
*/

#include "devicecommunication.h"
#include <QDebug>


DeviceCommunication::DeviceCommunication(QObject *parent) : QObject(parent),
    serialPort(new QSerialPort(this))
{
    connect(serialPort, &QSerialPort::readyRead, this, &DeviceCommunication::readData);
    connect(this, &DeviceCommunication::processData, this, &DeviceCommunication::parsingData);
    connect(serialPort, &QSerialPort::errorOccurred, this, &DeviceCommunication::handleError);

    autoConnect();

    dataAux["adc1"] = 0;
    dataAux["adc2"] = 0;
    dataAux["volume"] = 0;

    m_timer = new QTimer(this);
    connect(m_timer, &QTimer::timeout, this, &DeviceCommunication::TimerCallback);
    m_timer->start(1000);
}


bool fileExists(const QString &filePath) {
    QProcess process;
    process.start("bash", QStringList() << "-c" << QString("[ -f %1 ] && echo exists").arg(filePath));
    process.waitForFinished();

    QString output = process.readAllStandardOutput().trimmed();
    return output == "exists";
}


void DeviceCommunication::TimerCallback()
{
    // QString filePath = "/dev/ttyUSB2";

    // if (fileExists(filePath)) {
    //     qDebug() << "File Exist!";
    // }
    // else {
    //     qDebug() << "File not Exist!";
    // }

    //qDebug() << "Timer callback!";
    // try {
    //     openSerialPort("/dev/ttyUSB1");
    // }
    // catch (...) {
    //     qDebug()<< "Telah terjadi error!";
    // }
    autoConnect();
}

DeviceCommunication::~DeviceCommunication()
{
    if (serialPort->isOpen()) {
        serialPort->close();
    }
}

void DeviceCommunication::openSerialPort(const QSerialPortInfo &info)
{

    if (serialPort->isOpen())
        return;

    serialPort->setPort(info);
    serialPort->setBaudRate(QSerialPort::Baud9600);
    if (serialPort->open(QIODevice::ReadWrite)) {
        qDebug() << "Connected to: " << info.portName();
        //m_port_scanning = false;
        //m_timer->stop();
    }
    else
    {
        qDebug() << "Failed to open serial port: " << info.portName();
        m_port_scanning = true;
    }
}

void DeviceCommunication::closeSerialPort()
{
    if (serialPort->isOpen()) {
        serialPort->close();
    }
    qDebug() << "Serial port closed.";
}

void DeviceCommunication::writeData(const QByteArray &data)
{
    if (serialPort->isOpen()){
        serialPort->write(data);
    }
}

static uint16_t crc16_ccitt(const uint8_t *data, size_t length) {
    uint16_t crc = 0xFFFF;
    uint16_t polynomial = 0xA001;

    for (size_t i = 0; i < length; ++i) {
        crc ^= (uint16_t)data[i];

        for (size_t j = 0; j < 8; ++j) {
            if (crc & 0x0001) {
                crc = (crc >> 1) ^ polynomial;
            } else {
                crc >>= 1;
            }
        }
    }

    return crc;
}

void DeviceCommunication::readData()
{
    /*
    if (serialPort->canReadLine()) {
        QByteArray data = serialPort->readLine();
        emit dataReceived(QString::fromUtf8(data));
    }
    */
    QByteArray _temp;
    uint8_t temp;
    uint16_t _crc16 = 0;

    while( serialPort->isReadable() && serialPort->bytesAvailable())
    {
        _temp = serialPort->read(1);
        temp = _temp[0];

        if (serialdata.index == 0) {
            if (temp == COM_HEADER_1ST) {
                serialdata.buffer[serialdata.index] = temp;
                serialdata.index += 1;
            }
        }
        else if (serialdata.index == 1) {
            if (temp == COM_HEADER_2ND) {
                serialdata.buffer[serialdata.index] = temp;
                serialdata.index += 1;
            }
        }
        else if (serialdata.index == 2) {
            if (temp == COM_HEADER_3RD) {
                serialdata.buffer[serialdata.index] = temp;
                serialdata.index += 1;
            }
        }
        else if (serialdata.index == 3) {
            if (temp == COM_HEADER_4TH) {
                serialdata.buffer[serialdata.index] = temp;
                serialdata.index += 1;
            }
        }
        else if (serialdata.index == 4) {
            serialdata.buffer[serialdata.index] = temp;
            serialdata.index += 1;
        }
        else if (serialdata.index < 7) {
            serialdata.buffer[serialdata.index] = temp;
            m_data_len = (serialdata.buffer[5] << 8) + serialdata.buffer[6];
            serialdata.index += 1;
        }
        else {
            if (serialdata.index >= RX_BUFFER_LEN) {
                serialdata.index = 0;
                return;
            }

            serialdata.buffer[serialdata.index] = temp;

            if (serialdata.index >= m_data_len + 8 + 2) {
                /* do crc calculation */
                serialdata.crc16 = crc16_ccitt(serialdata.buffer, serialdata.index-1);
                _crc16 = serialdata.buffer[serialdata.index-1] | (serialdata.buffer[serialdata.index]<<8);
                serialdata.index = 0;

                if (serialdata.crc16 == _crc16) {
                    //qDebug() << "crc16 Ok!";
                    emit processData();
                }
                else
                {
                    //qDebug() << "crc16 Error!";
                }

                return;
            }

            serialdata.index += 1;
        }

    }
}

void DeviceCommunication::parsingData()
{
    uint16_t function_code = 0, length = 0, address_register = 0;

    function_code       = serialdata.buffer[4];
    length              = (serialdata.buffer[5]<<8) + serialdata.buffer[6];
    address_register    = (serialdata.buffer[7]<<8) + serialdata.buffer[8];
    //qDebug() << "FC: 0x" << QString::number(function_code, 16).toUpper() \
             << " " << "Length: 0x" << QString::number(length, 16).toUpper() \
             << " " << "AR: 0x" << QString::number(address_register, 16).toUpper();

    switch(function_code) {
    case FUNCTION_CODE_READ:
        parsingDataRead(address_register, &serialdata.buffer[9], length);
        break;

    case FUNCTION_CODE_WRITE:
        parsingDataWrite(address_register, &serialdata.buffer[9], length);
        break;
    default: break;
    }

}

void DeviceCommunication::handleError(QSerialPort::SerialPortError error)
{
    qDebug() << "Serial port error:" << serialPort->errorString();

    if (error == QSerialPort::ResourceError) {
        //QTimer::singleShot(1000, this, &DeviceCommunication::autoConnect);
    }
    else if (error == QSerialPort::DeviceNotFoundError) {
        //m_port_scanning = true;
        //m_timer->start(1000);
    }
    else if (error == QSerialPort::ReadError) {
        serialPort->close();
    }
}

void DeviceCommunication::parsingDataRead(uint16_t reg, uint8_t *data, uint16_t len)
{

    switch(reg) {
    case ADDR_REG_CHECK_COM:
        break;

    case ADDR_REG_ADC1_VALUE:
        //qDebug() <<"ADC1 Value: "<< ((data[0]<<8) | data[1]);
        dataAux["adc1"] = ((data[0]<<8) | data[1]);
        break;

    case ADDR_REG_ADC2_VALUE:
        break;

    case ADDR_REG_VOLUME:
        //qDebug() <<"Volume: "<< ((data[0]<<8) | data[1]);
        dataAux["volume"] = ((data[0]<<8) | data[1]);
        break;

    default: break;
    }

    QJsonDocument jsonDoc(dataAux);
    QVariantMap payload = jsonDoc.toVariant().toMap();
    emit auxDataTriggered(payload);

}

void DeviceCommunication::parsingDataWrite(uint16_t reg, uint8_t *data, uint16_t len)
{

}



void DeviceCommunication::autoConnect()
{

    //qDebug() << "Looking for USB-serial devices...";
    foreach (const QSerialPortInfo &info, QSerialPortInfo::availablePorts()) {
        //qDebug() << "USB2Serial: " << info.portName();
        if (info.portName() == "ttyUSB0") {
            //qDebug() << "Found USB-serial device. Connecting...";
            openSerialPort(info);
            return;
        }
    }
    //qDebug() << "No USB-serial device found.";
}
