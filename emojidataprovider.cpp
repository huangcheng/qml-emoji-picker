#include "emojidataprovider.h"

#include <QFile>

EmojiDataProvider::EmojiDataProvider(QObject *parent)
    : QObject{parent}
{

    QFile file(":/cheng.im/EmojiPicker/data/emojis.json");

    if (!file.open(QIODevice::ReadOnly))
    {
        qErrnoWarning("Unable to read");
    } else {
        QJsonDocument doc = QJsonDocument::fromJson(file.readAll());

        m_document = Emojis().read(doc.object()).get();
    }
}

QList<Category> EmojiDataProvider::categories() {
    if (m_categories.isEmpty())
    {
        for (auto& key : Category::groups)
        {
            Category category;

            category.setName(key);

            category.setDescription(Category::categories[key]);

            m_categories.append(category);
        }
    }

    return m_categories;
}
