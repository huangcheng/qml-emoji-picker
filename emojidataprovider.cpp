#include "emojidataprovider.h"

EmojiDataProvider::EmojiDataProvider(QObject *parent)
    : QObject{parent}
{
    QJsonDocument doc = QJsonDocument::fromJson(emojis);

    m_document = Document().read(doc.object()).get();
}

QStringList EmojiDataProvider::categories() {
    return m_document.keys();
}
