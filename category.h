#ifndef CATEGORY_H
#define CATEGORY_H

#include <QObject>
#include <QQmlEngine>
#include <QString>
#include <QMap>

class Category
{
    Q_GADGET
    Q_PROPERTY(QString name READ name WRITE setName)
    Q_PROPERTY(QString description READ description WRITE setDescription)
    QML_VALUE_TYPE(category)

public:
    Category() = default;

public:
    static constexpr const char* const groups[] = {
        "smileys_people",
        "animals_nature",
        "food_drink",
        "travel_places",
        "activities",
        "objects",
        "symbols",
        "flags",
    };

    static QMap<QString, QString> categories;

public:
    QString name();
    void setName(const QString& name);

    QString description();
    void setDescription(const QString& description);

private:
    QString m_name;
    QString m_description;
};

#endif // CATEGORY_H
