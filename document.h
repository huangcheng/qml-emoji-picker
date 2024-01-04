#ifndef DOCUMENT_H
#define DOCUMENT_H

#include <QObject>
#include <QMap>
#include <QString>
#include <QList>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>
#include <QStringList>

#include "emoji.h"

class Document
{
public:
    typedef QMap<QString, QList<Emoji>> DocumentType;

public:
    Document() = default;

public:
    const Document& read(const QJsonObject& json);
    DocumentType get() const;

private:
    DocumentType m_document;
};

#endif // DOCUMENT_H
