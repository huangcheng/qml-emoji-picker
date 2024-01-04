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

        m_document = Document().read(doc.object()).get();
    }
}

QStringList EmojiDataProvider::categories() {
    return m_document.keys();
}
