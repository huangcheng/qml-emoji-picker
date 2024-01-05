#ifndef EMOJI_H
#define EMOJI_H

#include <QObject>
#include <QStringList>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>

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
