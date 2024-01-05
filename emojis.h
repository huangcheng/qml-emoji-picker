#ifndef EMOJIS_H
#define EMOJIS_H

#include <QObject>
#include <QMap>
#include <QString>
#include <QList>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>
#include <QStringList>

#include "emoji.h"
#include "category.h"

class Emojis
{
public:
    typedef QMap<QString, QList<Emoji>> DocumentType;

public:
    Emojis() = default;

public:
    const Emojis& read(const QJsonObject& json);
    DocumentType get() const;

private:
    DocumentType m_document;
};

#endif // EMOJIS_H
