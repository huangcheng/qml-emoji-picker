#include "emojidataprovider.h"

#include <QFile>

EmojiDataProvider::EmojiDataProvider(QObject *parent) : QObject{parent} {

  QFile file(":/cheng.im/EmojiPicker/data/emojis.json");

  if (!file.open(QIODevice::ReadOnly)) {
    qErrnoWarning("Unable to read");
  } else {
    QJsonDocument doc = QJsonDocument::fromJson(file.readAll());

    m_document = Emojis().read(doc.object()).get();
  }
}

QList<Emoji> EmojiDataProvider::getEmojisByCategory(const QString &category,
                                                    const QString &keyword) {
  auto list = m_document[category];

  if (keyword.size()) {
    decltype(list) result;

    std::copy_if(list.begin(), list.end(), std::back_inserter(result),
                 [&](const auto &item) {
                   auto n = item.n();

                   for (const auto &word : n) {
                     if (word.contains(keyword, Qt::CaseInsensitive)) {
                       return true;
                     }
                   }

                   return false;
                 });

    return result;
  }

  return list;
}

Emoji EmojiDataProvider::getEmojiByCategoryAndCodePoint(
    const QString &category, const QString &codePage) {
  Emoji emoji;

  const auto &emojis = getEmojisByCategory(category);

  auto iter = std::find_if(emojis.begin(), emojis.end(), [&](const auto &item) {
    return item.u() == codePage;
  });

  if (iter != emojis.end()) {
    emoji = *iter;
  }

  return emoji;
}

QList<Category> EmojiDataProvider::categories() {
  if (m_categories.isEmpty()) {
    for (auto &key : Category::groups) {
      Category category;

      category.setName(key);

      category.setDescription(Category::categories[key]);

      m_categories.append(category);
    }
  }

  return m_categories;
}

QString EmojiDataProvider::keyword() const { return m_keyword; }

void EmojiDataProvider::setKeyword(const QString &keyword) {
  if (m_keyword != keyword) {
    m_keyword = keyword;

    emit keywordChanged();
  }
}
