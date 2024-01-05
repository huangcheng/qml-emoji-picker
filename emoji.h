#ifndef EMOJI_H
#define EMOJI_H

#include <QObject>
#include <QStringList>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>
#include <QQmlEngine>

class Emoji
{
    Q_GADGET
    Q_PROPERTY(QStringList n READ n WRITE setN FINAL)
    Q_PROPERTY(QString u READ u WRITE setU FINAL)
    Q_PROPERTY(QString a READ a WRITE setA FINAL)
    QML_VALUE_TYPE(emoji)

public:
    Emoji() = default;
    Emoji(const QStringList& n, const QString& u, const QString& a);

public:
    QStringList n() const;
    QString u() const;
    QString a() const;

public:
    void setN(const QStringList& n);
    void setU(const QString& u);
    void setA(const QString& a);

public:
    static Emoji fromJson(const QJsonObject& json);

private:
    QStringList m_n;
    QString m_u;
    QString m_a;
};

#endif // EMOJI_H
