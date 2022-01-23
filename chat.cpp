#include "chat.h"

#include <QDebug>

Chat::Chat(TextToSpeech &textToSpeech): m_textToSpeech(textToSpeech)
{
    connect(&client, SIGNAL(newMessage(QString,QString)), this, SLOT(appendMessage(QString,QString)));
    connect(&client, SIGNAL(connectedToPeer()), this, SLOT(connectedToPeer()));
    connect(&client, SIGNAL(disconnectedFromPeer()), this, SLOT(disconnectedFromPeer()));

    connect(&m_textToSpeech, &TextToSpeech::stateChanged, this, &Chat::textToSpeechFinished);
}

void Chat::appendMessage(const QString &from, const QString &message)
{
    Q_UNUSED(from);

    if (m_textToSpeech.state() == QTextToSpeech::Ready)
        m_speaking = false;
    else
        m_speaking = true;

    m_textToSpeech.speak(message);
}

void Chat::connectedToPeer()
{
    emit connected();
}

void Chat::disconnectedFromPeer()
{
    emit disconnected();
}

void Chat::textToSpeechFinished()
{
    if (m_textToSpeech.state() == QTextToSpeech::Ready) {
        if (m_speaking == false)
            client.sendMessage("ok");
    }
    m_speaking = false;
}
