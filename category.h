#ifndef CATEGORY_H
#define CATEGORY_H

#include <QQmlEngine>

#include <QtQml/qqmlregistration.h>

class _Category
{
    Q_GADGET
public:
    _Category() = default;
    _Category(const _Category&) = default;

public:
    enum Categoriy { SmileysPeople, AnimalsNature, FoodDrink, TravelPlaces, Activities, Objects, Symbols, Flags };
    Q_ENUM(Categoriy)
};


namespace CategoryForeign
{
Q_NAMESPACE
QML_NAMED_ELEMENT(Category)
QML_FOREIGN_NAMESPACE(_Category)
}

#endif // CATEGORY_H
