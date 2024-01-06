#include "emoji.h"

Emoji::Emoji(const QStringList &n, const QString &u, const QString &a, const QStringList &v) : m_n{n}, m_u{u}, m_a{a}, m_v{v}
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

QStringList Emoji::v() const
{
    return m_v;
}

void Emoji::setN(const QStringList &n)
{
    if (m_n != n)
    {
        m_n = n;
    }
}

void Emoji::setU(const QString &u)
{
    if (m_u != u)
    {
        m_u = u;
    }
}

void Emoji::setA(const QString &a)
{
    if (m_a != a)
    {
        m_a = a;
    }
}

void Emoji::setV(const QStringList &v)
{
    if (m_v != v)
    {
        m_v = v;
    }
}

Emoji Emoji::fromJson(const QJsonObject &json)
{
    QStringList n;
    QString u;
    QString a;
    QStringList _v;

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

    if (const QJsonValue v = json["v"]; v.isArray())
    {
        const QJsonArray list = v.toArray();

        for (const QJsonValue& item : list) {
            _v.push_back(item.toString());
        }
    }

    return Emoji(n, u, a, _v);
}
