import QtQuick

import "./themes" as Themes

Rectangle {
    id: root

    property string theme: 'light'

    readonly property var colorScheme: theme == 'light' ? light : dark

    width: 350
    height: 450

    color: colorScheme.background

    border.width: 1
    border.color: colorScheme.border

    radius: 8

    Themes.Light {
        id: light
    }
    Themes.Dark {
        id: dark
    }
}
