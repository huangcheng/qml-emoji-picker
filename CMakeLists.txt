project(EmojiPicker)

CMAKE_MINIMUM_REQUIRED(VERSION 3.5)

qt_add_library(EmojiPicker STATIC)

qt_add_qml_module(EmojiPicker
        URI EmojiPicker

        QML_FILES
        themes/Dark.qml
        themes/Light.qml
            EmojiPicker.qml

        RESOURCE_PREFIX /cheng.im/qml
)