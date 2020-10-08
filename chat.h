#ifndef CHAT_H
#define CHAT_H

#include <QObject>
#include <client.h>

class Chat : public QObject
{
    Q_OBJECT

public:
    Chat();
    Q_INVOKABLE QString getNickName();
    Q_INVOKABLE QString getCurrentClient();

signals:
    void connected();
    void disconnected();

private slots:
    void appendMessage(const QString &from, const QString &message);
    void newParticipant(const QString &nick);
    void participantLeft(const QString &nick);
    void connectedToPeer();
    void disconnectedFromPeer();

private:
    Client client;
    QString currentClient;
};

#endif // CHAT_H
