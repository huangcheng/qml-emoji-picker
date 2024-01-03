import QtQuick
import QtQuick.Layouts

import "./themes"

import "./components"


/*!
    \qmltype EmojiPicker
    \inherits Rectangle
    \brief A EmojiPicker Component.

    \qml
        EmojiPicker {
            width: 350
            height: 450

            theme: 'light'

            onTextChanged: {
                console.log(text)
            }
        }
    \endqml
*/
Rectangle {
    id: root


    /*!
        \qmlproperty string theme

        Theme for the component.

        The theme can be one of:
        \value 'light'       The default
        \value 'dark'
    */
    property string theme: 'light'


    /*!
        \qmlproperty string placeholder

        Placeholder text for the search.
    */
    property alias placeholder: search.placeholder

    readonly property var colorScheme: theme === 'light' ? light : dark


    /*!
        \qmlproperty int width

        Width of the component, default to 350.
    */
    width: 350


    /*!
        \qmlproperty int height

        Height of the component, default to 350.
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
        anchors.bottomMargin: 15

        anchors.fill: parent

        color: 'transparent'

        // Header
        Rectangle {
            width: parent.width - 20
            height: 40

            color: 'transparent'

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 10
            anchors.rightMargin: 10

            Search {
                id: search

                color: colorScheme.searchInputBg

                width: parent.width - skinTonePicker.width
                height: parent.height

                borderColor: colorScheme.highlight
                textColor: colorScheme.text
                hoverColor: colorScheme.hover

                anchors.top: parent.top
                anchors.left: parent.left
            }

            SkinTonePicker {
                id: skinTonePicker

                indicatorBorderColor: colorScheme.highlight

                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
