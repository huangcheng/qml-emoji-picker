import QtQuick

MouseArea {
    property alias color: container.color
    property alias textColor: input.color
    property alias text: input.text

    property string borderColor: 'transparent'
    property string hoverColor: 'transparent'

    property string placeholder: 'Search'

    Rectangle {
        id: container

        width: parent.width - 20
        height: 40

        border.width: 1

        border.color: 'transparent'
        radius: 12

        anchors.fill: parent

        antialiasing: true

        states: [
            State {
                name: "focused"
                when: input.focus

                PropertyChanges {
                    target: container
                    border.color: borderColor
                }
            },
            State {
                when: !input.focus

                PropertyChanges {
                    target: container
                    border.color: 'transparent'
                }
            }
        ]

        transitions: Transition {
            ColorAnimation {
                duration: 500
            }
        }

        Image {
            id: magnifier

            source: 'qrc:/cheng.im/EmojiPicker/images/magnifier.svg'

            width: 20
            height: 20

            sourceClipRect: Qt.rect(0, 0, 20, 20)

            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        }

        TextInput {
            id: input

            width: parent.width - magnifier.width - clear.width

            font.pixelSize: 14

            anchors.left: magnifier.right

            anchors.verticalCenter: parent.verticalCenter

            Text {
                text: placeholder
                color: parent.color
                visible: !parent.text.length

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
            }
        }

        MouseArea {
            id: clear

            width: 30
            height: 30

            opacity: 0

            hoverEnabled: true

            onClicked: input.text = ''

            states: State {
                when: input.text.length > 0

                PropertyChanges {
                    target: clear
                    opacity: 1
                }
            }

            transitions: Transition {
                NumberAnimation {
                    properties: "opacity"
                    duration: 200
                }
            }

            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter

            Rectangle {
                radius: 200

                color: parent.containsMouse ? hoverColor : 'transparent'

                anchors.fill: parent

                Image {
                    width: 20
                    height: 20

                    source: 'qrc:/cheng.im/EmojiPicker/images/times.svg'

                    sourceClipRect: clear.containsMouse ? Qt.rect(0, 20, 20,
                                                                  20) : Qt.rect(
                                                              0, 0, 20, 20)

                    anchors.centerIn: parent
                }
            }
        }
    }
}
