import QtQuick
import QtQuick.Layouts

import "./themes"

import "./components"

Rectangle {
    id: root

    property string theme: 'light'

    readonly property var colorScheme: theme === 'light' ? light : dark

    width: 350
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

    SystemPalette {
        id: palette

        colorGroup: SystemPalette.Active
    }

    Rectangle {
        anchors.topMargin: 15
        anchors.bottomMargin: 15

        anchors.fill: parent

        // Header
        Rectangle {
            width: parent.width - 20
            height: 40

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 10
            anchors.rightMargin: 10

            Search {
                color: colorScheme.searchInputBg

                width: parent.width
                height: parent.height

                borderColor: colorScheme.highlight
                textColor: colorScheme.text
                hoverColor: colorScheme.hover

                anchors.top: parent.top
                anchors.left: parent.left
            }
        }
    }
}
