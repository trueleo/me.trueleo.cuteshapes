import QtQml 2.0
import QtQuick 2.7
import QtGraphicalEffects 1.0

Item {
    id: root
    property variant shadowColor: ["#BBFF0000", "#BBFF7F00", "#BBFFFF00", "#BB00FF00", "#BB0000FF", "#BB4B0082", "#BB9400D3"]
    property int last: 0
    property int n: shadowColor.length
    
    Loader {
        id: wallLoader
        anchors.fill: parent
        active: false
        sourceComponent: staticImageC
    } 

    Component {
        id: staticImageC
        Image {
            anchors.fill: root
            fillMode: Image.PreserveAspectCrop
            sourceSize: parent
            source: wallpaper.configuration.WallPath
        }
    }
    
    Loader {
        id: wallLoader
        anchors.fill: parent
        active: false
        sourceComponent: staticImageC
    } 

    Component {
        id: staticImageC
        Image {
            anchors.fill: root
            sourceSize: parent
            source: wallpaper.configuration.WallPath
        }
    }

    Rectangle {
        id: circle
        width: ((parent.height + parent.width) / 8) * (wallpaper.configuration.ShapeSize/100)
        height: width
        radius: (width/2) * (wallpaper.configuration.ShapeRadius/100)
        antialiasing: true
        smooth: true
        color: wallpaper.configuration.CircleColor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -5
    
        MouseArea {
            anchors.fill: parent
            onClicked: wallpaper.configuration.UseTimer = !(wallpaper.configuration.UseTimer)
        }
        
        Component.onCompleted: {
           wallLoader.active = true 
        }
    }

    DropShadow {
        id: shadow
        anchors.fill: circle
        horizontalOffset: 0
        verticalOffset: 0
        radius: 22
        samples: 20
        color: wallpaper.configuration.ShadowColor
        source: circle

        ColorAnimation on color {
            id: shadowAnimation
            running: false
            loops: 1
            to: Qt.lighter(shadowColor[last], 1.2)
            duration: wallpaper.configuration.TransitionValue * 1000
        }
    }

    Image {
        id: logo
        source: wallpaper.configuration.IconPath
        height: circle.height / 2
        width: height
        visible: !(wallpaper.configuration.HideLogo)
        sourceSize {
            height: circle.height / 2
            width: height
        }
        anchors.centerIn: parent
    }

    Timer {
        interval: wallpaper.configuration.TimerValue * 1000
        running: wallpaper.configuration.UseTimer
        repeat: true
        onTriggered: {
            last = (last + 1) % n
            shadowAnimation.running = true
        }
    }
}
