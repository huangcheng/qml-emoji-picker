#ifndef EMOJIDATAPROVIDER_H
#define EMOJIDATAPROVIDER_H

#include <QObject>
#include <QQmlEngine>
#include <QFile>
#include <QString>
#include <QByteArray>
#include <QJsonDocument>

#include "document.h"

class EmojiDataProvider : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList categories READ categories)
    QML_ELEMENT
public:
    explicit EmojiDataProvider(QObject *parent = nullptr);

private:
    Document::DocumentType m_document;

public:
    QStringList categories();

private:
    void handleSourceChanged();

signals:
    void sourceChanged();
};

#endif // EMOJIDATAPROVIDER_H
