#ifndef CHAT_H
#define CHAT_H

#include <QObject>
#include <client.h>

#include "texttospeech.h"

class Chat : public QObject
{
    Q_OBJECT

public:
    Chat(TextToSpeech *textToSpeech);
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
    void textToSpeechFinished();

private:
    Client client;
    QString currentClient;

    TextToSpeech *m_textToSpeech;
    bool m_speaking = false;
};

#endif // CHAT_H
