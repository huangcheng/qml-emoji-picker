import QtQuick
import QtQuick.Controls

import im.cheng.EmojiPicker

ScrollView {
    id: root

    readonly property int cellSize: 40

    required property int activeIndex

    property string search: ''

    clip: true

    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

    ListView {
        id: list

        model: dataProvider.categories

        delegate: Rectangle {

            required property int index
            required property var modelData
            readonly property string name: modelData.name
            readonly property string description: modelData.description
            readonly property var emojis: dataProvider.getEmojisByCategory(
                                              name, search)

            visible: emojis.length > 0

            width: root.width
            height: childrenRect.height

            Column {
                Rectangle {
                    height: 40
                    width: parent.width

                    Text {
                        font.pixelSize: 16
                        font.weight: 700

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
                            required property var modelData
                            readonly property string u: modelData.u

                            width: cellSize
                            height: cellSize

                            anchors.margins: 5

                            Rectangle {
                                anchors.fill: parent
                                radius: 5

                                Text {
                                    text: String.fromCodePoint(parseInt(u, 16))

                                    font.pixelSize: 30
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    onActiveIndexChanged: {
        list.positionViewAtIndex(activeIndex, ListView.Beginning)
    }

    EmojiDataProvider {
        id: dataProvider
    }
}
