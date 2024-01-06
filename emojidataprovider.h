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
    Q_PROPERTY(QString keyword READ keyword WRITE setKeyword NOTIFY keywordChanged FINAL)
    Q_PROPERTY(QList<Category> categories READ categories CONSTANT FINAL)
    QML_ELEMENT
public:
    explicit EmojiDataProvider(QObject *parent = nullptr);

public:
    Q_INVOKABLE QList<Emoji> getEmojisByCategory(const QString& category, const QString& keyword = "");
    Q_INVOKABLE Emoji getEmojiByCategoryAndCodePoint(const QString& category, const QString& codePage);

private:
    Emojis::DocumentType m_document;

public:
    QList<Category> categories();

    QString keyword() const;
    void setKeyword(const QString& keyword);

private:
    QList<Category> m_categories;
    QString m_keyword;

signals:
    void keywordChanged();
};

#endif // EMOJIDATAPROVIDER_H
