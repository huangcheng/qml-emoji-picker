project(EmojiPicker)

CMAKE_MINIMUM_REQUIRED(VERSION 3.5)

set(CMAKE_CXX_STANDARD 23)

qt_add_library(EmojiPicker STATIC)

qt_add_qml_module(EmojiPicker
    URI im.cheng.EmojiPicker

    QML_FILES
        themes/Dark.qml
        themes/Light.qml

        components/Search.qml
        components/SkinTonePicker.qml
        components/Navigation.qml
        components/EmojiView.qml

        EmojiPicker.qml

    SOURCES
        category.h
        emoji.h
        emoji.cpp
        document.h
        document.cpp
        emojidataprovider.h
        emojidataprovider.cpp

    RESOURCE_PREFIX /cheng.im/qml
)

qt_add_resources(EmojiPicker "images"
    PREFIX /cheng.im/EmojiPicker

    FILES
        images/magnifier.svg
        images/times.svg
        images/CategoryNav.svg
)

qt_add_resources(EmojiPicker "data"
    PREFIX /cheng.im/EmojiPicker

    FILES
        data/emojis.json
)
