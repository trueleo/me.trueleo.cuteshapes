import QtQml 2.11
import QtQuick 2.0
import QtGraphicalEffects 1.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: root
    width: 1920
    height: 1080
    property variant shadowColor: ["#BBFF0000","#BBFF7F00","#BBFFFF00","#BB00FF00","#BB0000FF","#BB4B0082","#BB9400D3"]
    property int last: 0
    property int n: shadowColor.length

    Image {
        source: "wallpaper2.svg"
        sourceSize {
          height: parent.height
          width: parent.width
        }
    }

    Image {
        id: circle
        source: "circle.svg"
        sourceSize {
            height: (parent.height + parent.width)/11
            width: height
        }
        anchors.centerIn: parent
    }

    DropShadow {
           id: shadow
           anchors.fill: circle
           horizontalOffset: 0
           verticalOffset: 0
           radius: 45
           samples: 18
           color: "red"
           source: circle

           ColorAnimation on color {
                id: shadowAnimation
                running: false
                loops: 1
                to: Qt.lighter(shadowColor[last], 1.2)
                duration: 2500
           }

    }

    Image {
        id: arch
        source: "arch.png"
        sourceSize {
        height: circle.height/2
        width: height
        }
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -12 
        smooth: true
    }


    Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                last = (last+1)%(n-1)
                shadowAnimation.running = true
            }
    }

}
