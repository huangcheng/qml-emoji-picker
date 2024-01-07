#ifndef EMOJI_H
#define EMOJI_H

#include <QJsonArray>
#include <QJsonObject>
#include <QJsonValue>
#include <QObject>
#include <QQmlEngine>
#include <QStringList>

class Emoji {
  Q_GADGET
  Q_PROPERTY(QStringList n READ n WRITE setN FINAL)
  Q_PROPERTY(QString u READ u WRITE setU FINAL)
  Q_PROPERTY(QString a READ a WRITE setA FINAL)
  Q_PROPERTY(QStringList v READ v WRITE setV FINAL)
  QML_VALUE_TYPE(emoji)

public:
  Emoji() = default;
  Emoji(const QStringList &n, const QString &u, const QString &a,
        const QStringList &v);

public:
  QStringList n() const;
  QString     u() const;
  QString     a() const;
  QStringList v() const;

public:
  void setN(const QStringList &n);
  void setU(const QString &u);
  void setA(const QString &a);
  void setV(const QStringList &v);

public:
  static Emoji fromJson(const QJsonObject &json);

private:
  QStringList m_n;
  QString     m_u;
  QString     m_a;
  QStringList m_v;
};

#endif // EMOJI_H
