#ifndef EMOJIS_H
#define EMOJIS_H

#include <QJsonArray>
#include <QJsonObject>
#include <QJsonValue>
#include <QList>
#include <QMap>
#include <QObject>
#include <QString>
#include <QStringList>

#include "category.h"
#include "emoji.h"

class Emojis {
public:
  typedef QMap<QString, QList<Emoji>> DocumentType;

public:
  Emojis() = default;

public:
  const Emojis &read(const QJsonObject &json);
  DocumentType  get() const;

private:
  DocumentType m_document;
};

#endif // EMOJIS_H
