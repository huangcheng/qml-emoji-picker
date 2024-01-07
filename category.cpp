#include "category.h"

QMap<QString, QString> Category::categories = {
    {"smileys_people", "Smileys & People"},
    {"animals_nature", "Animals & Nature"},
    {"food_drink", "Food & Drink"},
    {"travel_places", "Travel & Places"},
    {"activities", "Activities"},
    {"objects", "Objects"},
    {"symbols", "Symbols"},
    {"flags", "Flags"}};

QString Category::name() { return m_name; }

void Category::setName(const QString &name) {
  if (m_name != name) {
    m_name = name;
  }
}

QString Category::description() { return m_description; }

void Category::setDescription(const QString &description) {
  if (m_description != description) {
    m_description = description;
  }
}
