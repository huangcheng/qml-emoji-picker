import QtQuick
import QtQuick.Layouts

Rectangle {
    property var categories: []
    property string theme: 'light'
    property int activeCategory: 0

    required property string highlightColor

    readonly property int buttonSize: 30
    readonly property int imageSkip: 1
    readonly property int darkOffset: 2
    readonly property int highlightOffset: 1
    readonly property int originalImageWidth: 200
    readonly property int originalImageHeight: 80
    readonly property int originalImageCellSize: 20
    readonly property double scaleFactor: buttonSize / originalImageCellSize
    readonly property bool isDark: theme !== 'light'

    Row {
        spacing: (parent.width - categories.length * buttonSize) / (categories.length - 1)

        anchors.verticalCenter: parent.verticalCenter

        Repeater {
            model: categories

            MouseArea {
                required property int index
                required property var modelData

                readonly property int category: modelData.category

                width: buttonSize
                height: buttonSize

                hoverEnabled: true

                onClicked: activeCategory = category

                Rectangle {
                    radius: 200

                    border.width: 1
                    border.color: highlightColor

                    visible: containsPress

                    anchors.fill: parent
                }

                Image {
                    source: 'qrc:/cheng.im/EmojiPicker/images/CategoryNav.svg'
                    sourceSize: Qt.size(originalImageWidth * scaleFactor,
                                        originalImageHeight * scaleFactor)

                    readonly property bool isActive: index === activeCategory

                    readonly property int offsetY: parent.containsMouse
                                                   || isActive ? (isDark ? (darkOffset + highlightOffset) * buttonSize : highlightOffset * buttonSize) : (isDark ? darkOffset * buttonSize : 0)

                    sourceClipRect: Qt.rect(
                                        (index + imageSkip - 1) * buttonSize,
                                        offsetY, buttonSize, buttonSize)

                    fillMode: Image.Stretch

                    anchors.fill: parent
                }
            }
        }
    }
}
