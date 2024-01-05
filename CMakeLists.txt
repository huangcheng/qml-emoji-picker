project(EmojiPicker)

CMAKE_MINIMUM_REQUIRED(VERSION 3.5)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED on)



if(POLICY CMP0071)
  cmake_policy(SET CMP0071 NEW)
endif()

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

        scripts/utils.mjs

        EmojiPicker.qml

    SOURCES

        emoji.h
        emoji.cpp
        emojis.h
        emojis.cpp
        category.h
        category.cpp
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
