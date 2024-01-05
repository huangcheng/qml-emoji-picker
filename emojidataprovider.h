#ifndef EMOJIDATAPROVIDER_H
#define EMOJIDATAPROVIDER_H

#include <QObject>
#include <QQmlEngine>
#include <QFile>
#include <QString>
#include <QList>
#include <QByteArray>
#include <QJsonDocument>

#include "emojis.h"
#include "category.h"

class EmojiDataProvider : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<Category> categories READ categories CONSTANT FINAL)
    QML_ELEMENT
public:
    explicit EmojiDataProvider(QObject *parent = nullptr);

private:
    Emojis::DocumentType m_document;

public:
    QList<Category> categories();

private:
    QList<Category> m_categories;

};

#endif // EMOJIDATAPROVIDER_H
