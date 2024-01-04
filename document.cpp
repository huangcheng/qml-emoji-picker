#include "document.h"

const Document& Document::read(const QJsonObject &json)
{
    QList<Emoji> smileys;

    if (const QJsonValue v = json[EMOJI_CATEGORY_SMILEYS_PEOPLE]; v.isArray())
    {
        QJsonArray emojis = v.toArray();

        for (const QJsonValue& item : emojis)
        {
            if (item.isObject())
            {
                smileys.push_back(Emoji::fromJson(item.toObject()));
            }
        }
    }

    if (!smileys.isEmpty())
    {
        m_document.insert(EMOJI_CATEGORY_SMILEYS_PEOPLE, smileys);
    }

    QList<Emoji> animals;

    if (const QJsonValue v = json[EMOJI_CATEGORY_ANIMALS_NATURE]; v.isArray())
    {
        QJsonArray emojis = v.toArray();

        for (const QJsonValue& item : emojis)
        {
            if (item.isObject())
            {
                animals.push_back(Emoji::fromJson(item.toObject()));
            }
        }
    }

    if (!animals.isEmpty())
    {
        m_document.insert(EMOJI_CATEGORY_ANIMALS_NATURE, animals);
    }

    QList<Emoji> food;

    if (const QJsonValue v = json[EMOJI_CATEGORY_FOOD_DRINK]; v.isArray())
    {
        QJsonArray emojis = v.toArray();

        for (const QJsonValue& item : emojis)
        {
            if (item.isObject())
            {
                food.push_back(Emoji::fromJson(item.toObject()));
            }
        }
    }

    if (!food.isEmpty())
    {
        m_document.insert(EMOJI_CATEGORY_FOOD_DRINK, food);
    }

    QList<Emoji> activities;

    if (const QJsonValue v = json[EMOJI_CATEGORY_ACTIVITIES]; v.isArray())
    {
        QJsonArray emojis = v.toArray();

        for (const QJsonValue& item : emojis)
        {
            if (item.isObject())
            {
                activities.push_back(Emoji::fromJson(item.toObject()));
            }
        }
    }

    if (!activities.isEmpty())
    {
        m_document.insert(EMOJI_CATEGORY_ACTIVITIES, activities);
    }

    QList<Emoji> travel;

    if (const QJsonValue v = json[EMOJI_CATEGORY_TRAVEL_PLACES]; v.isArray())
    {
        QJsonArray emojis = v.toArray();

        for (const QJsonValue& item : emojis)
        {
            if (item.isObject())
            {
                travel.push_back(Emoji::fromJson(item.toObject()));
            }
        }
    }

    if (!travel.isEmpty())
    {
        m_document.insert(EMOJI_CATEGORY_TRAVEL_PLACES, travel);
    }

    QList<Emoji> objects;

    if (const QJsonValue v = json[EMOJI_CATEGORY_OBJECTS]; v.isArray())
    {
        QJsonArray emojis = v.toArray();

        for (const QJsonValue& item : emojis)
        {
            if (item.isObject())
            {
                objects.push_back(Emoji::fromJson(item.toObject()));
            }
        }
    }

    if (!objects.isEmpty())
    {
        m_document.insert(EMOJI_CATEGORY_OBJECTS, objects);
    }

    QList<Emoji> symbols;

    if (const QJsonValue v = json[EMOJI_CATEGORY_SYMBOLS]; v.isArray())
    {
        QJsonArray emojis = v.toArray();

        for (const QJsonValue& item : emojis)
        {
            if (item.isObject())
            {
                symbols.push_back(Emoji::fromJson(item.toObject()));
            }
        }
    }

    if (!symbols.isEmpty())
    {
        m_document.insert(EMOJI_CATEGORY_SYMBOLS, symbols);
    }

    QList<Emoji> flags;

    if (const QJsonValue v = json[EMOJI_CATEGORY_FLAGS]; v.isArray())
    {
        QJsonArray emojis = v.toArray();

        for (const QJsonValue& item : emojis)
        {
            if (item.isObject())
            {
                flags.push_back(Emoji::fromJson(item.toObject()));
            }
        }
    }

    if (!flags.isEmpty())
    {
        m_document.insert(EMOJI_CATEGORY_FLAGS, flags);
    }

    return *this;
}

Document::DocumentType Document::get() const
{
    return m_document;
}
