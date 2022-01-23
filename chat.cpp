#include "chat.h"

#include <QDebug>

Chat::Chat(TextToSpeech *textToSpeech)
{
    connect(&client, SIGNAL(newMessage(QString,QString)), this, SLOT(appendMessage(QString,QString)));
    connect(&client, SIGNAL(newParticipant(QString)), this, SLOT(newParticipant(QString)));
    connect(&client, SIGNAL(participantLeft(QString)), this, SLOT(participantLeft(QString)));
    connect(&client, SIGNAL(connectedToPeer()), this, SLOT(connectedToPeer()));
    connect(&client, SIGNAL(disconnectedFromPeer()), this, SLOT(disconnectedFromPeer()));

    m_textToSpeech = textToSpeech;

    connect(m_textToSpeech, &TextToSpeech::stateChanged, this, &Chat::textToSpeechFinished);
}

QString Chat::getNickName()
{
    return client.nickName();
}

QString Chat::getCurrentClient()
{
    return currentClient;
}

void Chat::appendMessage(const QString &from, const QString &message)
{
    Q_UNUSED(from);

    if (m_textToSpeech->state() == QTextToSpeech::Ready)
        m_speaking = false;
    else
        m_speaking = true;

    m_textToSpeech->speak(message);
//    qDebug() << m_textToSpeech.voice().name();

//    for (int i = 0; i < m_textToSpeech.availableLocales().size(); i++) {
//        QLocale locale = m_textToSpeech.availableLocales().at(i);
//        QString language = QLocale::languageToString(locale.language());
//        qDebug() << language;
//    }

//    qDebug() << m_textToSpeech.availableLocales().size();

//    for (int i = 0; i < m_textToSpeech.availableVoices().size(); i++) {
//        QVoice voice = m_textToSpeech.availableVoices().at(i);
//        QString name = voice.name();
//        qDebug() << name;
//    }

//    qDebug() << m_textToSpeech.availableVoices().size();
}

void Chat::newParticipant(const QString &nick)
{
    qDebug() << nick << " joined";
    currentClient = nick;
}

void Chat::participantLeft(const QString &nick)
{
    qDebug() << nick << " left";
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
    if (m_textToSpeech->state() == QTextToSpeech::Ready) {
        if (m_speaking == false)
            client.sendMessage("ok");
    }
    m_speaking = false;
}
