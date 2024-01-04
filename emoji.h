#ifndef EMOJI_H
#define EMOJI_H

#include <QObject>
#include <QStringList>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>

const char* const EMOJI_CATEGORY_SMILEYS_PEOPLE = "smileys_people";
const char* const EMOJI_CATEGORY_ANIMALS_NATURE = "animals_nature";
const char* const EMOJI_CATEGORY_FOOD_DRINK = "food_drink";
const char* const EMOJI_CATEGORY_TRAVEL_PLACES = "travel_places";
const char* const EMOJI_CATEGORY_ACTIVITIES = "activities";
const char* const EMOJI_CATEGORY_OBJECTS = "objects";
const char* const EMOJI_CATEGORY_SYMBOLS = "symbols";
const char* const EMOJI_CATEGORY_FLAGS = "flags";

class Emoji
{
    Q_GADGET

public:
    Emoji() = delete;
    Emoji(const QStringList& n, const QString& u, const QString& a);

public:
    QStringList n() const;
    QString u() const;
    QString a() const;

public:
    static Emoji fromJson(const QJsonObject& json);

private:
    QStringList m_n;
    QString m_u;
    QString m_a;
};

#endif // EMOJI_H
