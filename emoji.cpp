#include "emoji.h"

Emoji::Emoji(const QStringList &n, const QString &u, const QString &a) : m_n(n), m_u(u), m_a(a)
{}

QStringList Emoji::n() const
{
    return m_n;
}

QString Emoji::u() const
{
    return m_u;
}

QString Emoji::a() const
{
    return m_a;
}

Emoji Emoji::fromJson(const QJsonObject &json)
{
    QStringList n;
    QString u;
    QString a;

    if (const QJsonValue v = json["n"]; v.isArray())
    {
         const QJsonArray list = v.toArray();

        for (const QJsonValue& item : list) {
             n.push_back(item.toString());
        }
    }

    if (const QJsonValue v = json["u"]; v.isString())
    {
        u = std::move(v.toString());
    }

    if (const QJsonValue v = json["a"]; v.isString())
    {
        a = std::move(v.toString());
    }

    return Emoji(n, u, a);
}
