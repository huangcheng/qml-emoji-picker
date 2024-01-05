import QtQuick

Rectangle {
    id: root

    readonly property string skinToneNeutral: '#FFD225'
    readonly property string skinToneLight: '#FFDFBD'
    readonly property string skinToneMediumLight: '#E9C197'
    readonly property string skinToneMedium: '#C88E62'
    readonly property string skinToneMediumDark: '#A86637'
    readonly property string skinToneDark: '#60463A'

    readonly property list<string> colors: [skinToneNeutral, skinToneLight, skinToneMediumLight, skinToneMedium, skinToneMediumDark, skinToneDark]

    readonly property int cellWidth: 20
    readonly property int cellHeight: 20

    readonly property int gap: 10

    readonly property int buttonWidth: 16
    readonly property int buttonHeight: 16

    readonly property int containerWidth: 178
    readonly property int containerHegiht: 20

    property string indicatorBorderColor: 'transparent'

    property bool open: false
    property int activeIndex: 0

    color: 'transparent'
    width: cellWidth + gap
    height: containerHegiht

    anchors.topMargin: 10
    anchors.bottomMargin: 10

    states: State {
        name: 'open'
        when: open

        PropertyChanges {
            target: root
            width: containerWidth
        }
    }

    Repeater {
        model: 6

        MouseArea {
            required property int index

            width: cellWidth
            height: cellHeight

            property bool isActive: activeIndex === index

            z: open ? 1 : isActive ? 1 : -1

            transform: [
                Translate {
                    x: open ? calcPositionX(index) : gap
                }
            ]

            Rectangle {
                anchors.fill: parent

                radius: 5

                visible: isActive && open

                border.width: 1
                border.color: indicatorBorderColor
            }

            Rectangle {
                color: colors[index]

                width: buttonWidth
                height: buttonHeight

                radius: 4

                opacity: isActive ? 1 : 0

                NumberAnimation on opacity {
                    running: open

                    from: 0
                    to: 1

                    duration: 400
                }

                NumberAnimation on opacity {
                    running: !open && !isActive

                    from: 1
                    to: 0

                    duration: 400
                }

                anchors.centerIn: parent
            }

            onPressed: {
                activeIndex = index

                open = !open
            }
        }
    }

    function calcPositionX(index) {
        return width - ((index + 1) * cellWidth) - (index * gap)
    }
}
