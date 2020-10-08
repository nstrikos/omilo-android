#include "chat.h"

#include <QDebug>

Chat::Chat()
{
    connect(&client, SIGNAL(newMessage(QString,QString)), this, SLOT(appendMessage(QString,QString)));
    connect(&client, SIGNAL(newParticipant(QString)), this, SLOT(newParticipant(QString)));
    connect(&client, SIGNAL(participantLeft(QString)), this, SLOT(participantLeft(QString)));
    connect(&client, SIGNAL(connectedToPeer()), this, SLOT(connectedToPeer()));
    connect(&client, SIGNAL(disconnectedFromPeer()), this, SLOT(disconnectedFromPeer()));
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
    qDebug() << "Message: " << message << " from: " << from;
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
