project(EmojiPicker)

CMAKE_MINIMUM_REQUIRED(VERSION 3.5)

qt_add_library(EmojiPicker STATIC)

qt_add_qml_module(EmojiPicker
    URI EmojiPicker

    QML_FILES
        themes/Dark.qml
        themes/Light.qml

        components/Search.qml
        components/SkinTonePicker.qml
        components/Navigation.qml

        EmojiPicker.qml

    SOURCES
        category.h

    RESOURCE_PREFIX /cheng.im/qml
)

qt_add_resources(EmojiPicker "images"
    PREFIX /cheng.im/EmojiPicker

    FILES
        images/magnifier.svg
        images/times.svg
        images/CategoryNav.svg
)
