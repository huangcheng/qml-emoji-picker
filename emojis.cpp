#include "emojis.h"

const Emojis& Emojis::read(const QJsonObject &json)
{
    for (auto key : Category::groups)
    {
        QList<Emoji> list;

        if (const auto& v = json[key]; v.isArray())
        {
            auto array = v.toArray();

            for (const auto& item : array)
            {
                if (item.isObject())
                {
                    list.push_back(Emoji::fromJson(item.toObject()));
                }
            }
        }

        if (!list.isEmpty())
        {
            m_document.insert(key, list);
        }
    }

    return *this;
}

Emojis::DocumentType Emojis::get() const
{
    return m_document;
}
