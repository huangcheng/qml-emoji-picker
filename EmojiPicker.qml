import QtQml
import QtQuick
import QtQuick.Layouts

import "./themes"

import "./components"

import "./scripts/utils.mjs" as Utils

import im.cheng.EmojiPicker


/*!
    \qmltype EmojiPicker
    \inherits Rectangle
    \brief A EmojiPicker Component.

    \qml
        EmojiPicker {
            width: 350
            height: 450

            theme: 'light'
            defaultSkinTone: 'neatral'
            skinTonesDisabled: false
            searchPlaceholder: 'Search'
            searchDisabled: false

            onEmojiClicked: function (emoji) {
                console.log(emoji)
            }
        }
    \endqml
*/
Rectangle {
    id: root


    /*!
        \qmlproperty string theme

        Controls the theme of the picker.

        The theme can be one of:
        \value 'light'       The default
        \value 'dark'
    */
    property string theme: 'light'


    /*!
        \qmlproperty string defaultSkinTone

        Controls the default skin tone, default to \c {'neutral'}

        The value can be one of:
        \value 'neutral' ✋
        \value '1f3fb'   ✋🏻
        \value '1f3fc'   ✋🏼
        \value '1f3fd'   ✋🏽
        \value '1f3fe'   ✋🏾
        \value '1f3ff'   ✋🏿
    */
    property string defaultSkinTone: 'neutral'


    /*!
        \qmlproperty bool skinTonesDisabled

        Controls whether the skin tones are disabled or not, default to \c {false}
    */
    property bool skinTonesDisabled: false


    /*!
        \qmlproperty bool searchDisabled

        Controls whether the search is disabled or not, default to \c {false}
    */
    property bool searchDisabled: false


    /*!
        \qmlproperty string searchPlaceholder

        Placeholder text for the search, default to \c {'Search'}
    */
    property alias searchPlaceholder: search.placeholder


    /*!
        \qmlproperty string selectedEmoji

        Emoji selected.
    */
    property alias selectedEmoji: emojiView.selectedEmoji


    /*!
        \qmlproperty bool showPreview

        Show the emoji preview panel or not.
    */
    property bool showPreview: true


    /*!
        \qmlsignal EmojiPicker::emojiClicked(string emoji)

        Signal that is called when an emoji is clicked. The function receives the emoji  as a parameter.
    */
    signal emojiClicked(string emoji)

    readonly property var colorScheme: theme === 'light' ? light : dark

    readonly property var skinTones: {
        "neutral": 0,
        "1f3fb": 1,
        "1f3fc": 2,
        "1f3fd": 3,
        "1f3fe": 4,
        "1f3ff": 5
    }

    readonly property int padding: 10
    readonly property string transparent: 'transparent'

    readonly property string defaultEmoji: '😊'
    readonly property string defaultDescription: 'What\'s Your Mood?'

    property string emoji: defaultEmoji
    property string description: defaultDescription


    /*!
        \qmlproperty int width
        \default 350

        Width of the component.
    */
    width: 350


    /*!
        \qmlproperty int height
        \default 450

        Height of the component.
    */
    height: 450

    color: colorScheme.background

    border.width: 1
    border.color: colorScheme.border

    radius: 8

    Light {
        id: light
    }

    Dark {
        id: dark
    }

    Rectangle {
        anchors.topMargin: 15

        // anchors.bottomMargin: 15
        anchors.fill: parent

        color: 'transparent'

        // Header
        Rectangle {
            id: header

            readonly property int headerHeight: 40

            width: parent.width - 2 * padding
            height: searchDisabled ? 0 : headerHeight

            visible: !searchDisabled

            color: transparent

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: padding
            anchors.rightMargin: padding
            anchors.horizontalCenter: parent.horizontalCenter

            Search {
                id: search

                color: colorScheme.searchInputBg

                width: skinTonesDisabled ? parent.width : parent.width - skinTonePicker.width
                height: parent.height

                borderColor: colorScheme.highlight
                textColor: colorScheme.text
                hoverColor: colorScheme.hover

                anchors.top: parent.top
                anchors.left: parent.left
            }

            SkinTonePicker {
                id: skinTonePicker

                visible: !skinTonesDisabled

                activeIndex: skinTones[defaultSkinTone]
                indicatorBorderColor: colorScheme.highlight

                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        // Navigation
        Rectangle {
            id: navigation

            readonly property int navigationHeight: 40
            readonly property int navigationMargin: 15

            width: parent.width - 2 * padding
            height: navigationHeight

            color: transparent

            anchors.left: parent.left
            anchors.top: header.bottom

            anchors.margins: padding
            anchors.topMargin: navigationMargin
            anchors.bottomMargin: navigationMargin
            anchors.horizontalCenter: parent.horizontalCenter

            Navigation {
                id: nav

                categories: data.categories

                theme: root.theme

                color: transparent
                highlightColor: colorScheme.highlight
                disabled: search.text.length > 0

                anchors.fill: parent

                onActiveCategoryChanged: emojiView.scrollToCategory(
                                             activeCategory)

                Connections {
                    target: emojiView

                    function onCategoryChanged(category) {
                        nav.activeCategory = category
                    }
                }
            }
        }

        // Body
        Rectangle {
            width: parent.width
            height: parent.height - header.height - navigation.height
                    - footer.height - parent.anchors.topMargin

            color: transparent

            anchors.top: navigation.bottom
            anchors.left: parent.left
            anchors.leftMargin: padding
            anchors.rightMargin: padding
            anchors.horizontalCenter: parent.horizontalCenter

            EmojiView {
                id: emojiView

                skinTone: defaultSkinTone
                search: search.text
                textColor: colorScheme.text
                highlightColor: colorScheme.focus

                anchors.fill: parent

                onEntered: function (category, code) {
                    const target = data.getEmojiByCategoryAndCodePoint(
                                     category, code)

                    root.emoji = emojiView.parseEmoji(target, skinTone)
                    root.description = Utils.capitalizeFirstLetter(target.n[0])

                    // timer.stop()
                }

                // onExited: {
                //     timer.restart()
                // }

                // Timer {
                //     id: timer
                //     interval: 1000

                //     onTriggered: {
                //         root.emoji = defaultEmoji
                //         root.description = defaultDescription
                //     }
                // }
                Connections {
                    target: skinTonePicker

                    function onActiveIndexChanged() {
                        const targetSkinTone = Object.keys(skinTones).find(
                                                 function (key) {
                                                     return skinTones[key]
                                                             === skinTonePicker.activeIndex
                                                 })

                        emojiView.skinTone = targetSkinTone
                    }
                }
            }
        }

        // Footer
        Rectangle {
            id: footer

            readonly property int borderWidth: 1
            readonly property int footerHeight: 70

            height: showPreview ? footerHeight : 0
            width: parent.width

            color: transparent

            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            Behavior on height {
                NumberAnimation {
                    duration: 200
                }
            }

            Rectangle {
                width: parent.width
                height: footer.borderWidth

                color: colorScheme.border
                visible: showPreview

                anchors.left: parent.left
                anchors.top: parent.top
            }

            Rectangle {
                color: transparent

                height: parent.height - footer.borderWidth
                visible: showPreview

                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: padding
                anchors.rightMargin: padding

                Text {
                    id: preview

                    font.pixelSize: 45
                    text: emoji

                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    color: colorScheme.text

                    font.pixelSize: 14
                    font.weight: 500
                    text: description

                    anchors.left: preview.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: padding
                    anchors.rightMargin: padding
                }
            }
        }

        EmojiDataProvider {
            id: data
        }
    }

    Connections {
        target: emojiView

        function onEmojiClicked(emoji) {
            emojiClicked(emoji)
        }
    }
}
