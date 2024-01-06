import QtQml
import QtQuick
import QtQuick.Controls

import im.cheng.EmojiPicker

ScrollView {
    id: root

    readonly property int cellSize: 40
    readonly property string transparent: 'transparent'

    required property string highlightColor
    required property string textColor
    required property string skinTone

    property string search: ''
    property int previousIndex: 0

    property string selectedEmoji: String.fromCodePoint(
                                       parseInt(
                                           dataProvider.getEmojisByCategory(
                                               dataProvider.categories[0].name)[0].u,
                                           16))

    signal emojiClicked(string emoji)
    signal categoryChanged(string category)
    signal entered(string category, string codePoint)
    signal exited

    clip: true

    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

    function parseEmoji(emoji, skinTone) {
        let unified = emoji.u

        if (emoji.v.length > 0 && skinTone !== 'neutral') {
            unified = emoji.v.find(function (variation) {
                return variation.includes(skinTone)
            })
        }

        if (/-/.test(unified)) {
            return unified.split('-').map(hex => String.fromCodePoint(
                                              parseInt(hex, 16))).join('')
        }

        return String.fromCodePoint(parseInt(unified, 16))
    }

    ListView {
        id: list

        model: dataProvider.categories

        delegate: Rectangle {
            id: delegate

            required property int index
            required property var modelData
            readonly property string name: modelData.name
            readonly property string description: modelData.description
            readonly property var emojis: dataProvider.getEmojisByCategory(
                                              name, search)

            color: transparent

            visible: emojis.length > 0

            width: root.width
            height: emojis.length > 0 ? childrenRect.height : 0

            Column {
                Rectangle {
                    height: 40
                    width: parent.width
                    color: transparent

                    Text {
                        font.pixelSize: 16
                        font.weight: 700

                        color: textColor
                        text: description

                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Grid {
                    height: childrenRect.height

                    columns: root.width / cellSize

                    Repeater {
                        model: emojis

                        MouseArea {
                            id: button

                            required property var modelData

                            readonly property string u: modelData.u
                            readonly property string emoji: parseEmoji(
                                                                modelData,
                                                                skinTone)

                            width: cellSize
                            height: cellSize

                            hoverEnabled: true

                            anchors.margins: 5

                            Rectangle {
                                anchors.fill: parent
                                radius: 5

                                opacity: button.containsMouse ? 1 : 0

                                color: highlightColor

                                Behavior on opacity {
                                    NumberAnimation {
                                        duration: 700
                                    }
                                }
                            }

                            Text {
                                text: emoji

                                font.pixelSize: 30

                                anchors.centerIn: parent

                                Connections {
                                    target: button

                                    function onClicked() {
                                        selectedEmoji = emoji

                                        root.emojiClicked(emoji)
                                    }
                                }
                            }

                            onEntered: root.entered(name, u)
                            onExited: root.exited()
                        }
                    }
                }
            }
        }

        onContentYChanged: {
            const current = list.indexAt(0, contentY)

            if (previousIndex !== current) {
                let category = dataProvider.categories[current]

                if (category) {
                    category = category.name

                    previousIndex = current

                    root.categoryChanged(category)
                }
            }
        }
    }

    function scrollToCategory(category) {
        const index = dataProvider.categories.findIndex(function (item) {
            return item.name === category
        })

        list.positionViewAtIndex(index, ListView.Beginning)
    }

    EmojiDataProvider {
        id: dataProvider
    }
}
