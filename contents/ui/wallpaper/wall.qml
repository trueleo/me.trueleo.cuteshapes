import QtQuick 2.7

Item {
id: root
width: 1920
height: 1080
Image {
    id: background
    anchors.fill: parent
    source: "background.svg"

    Image {
        id: spiral
        sourceSize {
            width: parent.height/2
            height: width
        }
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        source: "spiral.svg"
    }

    Image {
        id: circles
        sourceSize {
            height: parent.height/2
            width: height*1.4
        }
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        source: "threecirc.svg"
    }

    Image {
        id: neko
        sourceSize {
            height: parent.height/1.3
            width: height
        }
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        source: "thisisnotneko.svg"
    }

    Image {
        id: headphone
        anchors {
            left: parent.left
            leftMargin: parent.width*0.1
        }
        sourceSize {
            width: parent.height/2
            height: width
        }
        source: "headphone.svg"
    }
}

}
