import QtQuick 2.0
import QtQuick.Controls 1.4 as QtControls
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.0
import Qt.labs.settings 1.0

import org.kde.kquickcontrols 2.0 as KQuickControls
import org.kde.plasma.core 2.0 as Plasmacore

ColumnLayout {
    id: root
    spacing: units.largeSpacing/3
    property alias cfg_CircleColor: circleColor.color
    property alias cfg_ShadowColor: shadowColor.color
    property alias cfg_HideLogo: hideCheckBox.checked
    property alias cfg_UseTimer: useTimer.checked
    property alias cfg_TimerValue: timerValue.text
    property alias cfg_TransitionValue: transitionValue.text
    property alias cfg_ShapeRadius: radiusValue.value
    property alias cfg_ShapeSize: sizeValue.value
    property string cfg_IconPath
    property string datastore: ""
    property string cfg_WallPath
    property int currIndex

    Settings {
        property alias datastore: root.datastore
        property alias currIndex: root.currIndex
    }

    Rectangle {
        width: 10
        height: units.largeSpacing/2
        color: "transparent"
        
        Component.onCompleted: {
            if (datastore) {
            dataModel.clear()
            var datamodel = JSON.parse(datastore)
            for (var i = 0; i < datamodel.length; ++i) 
                dataModel.append(datamodel[i])
            }
        }

        Component.onDestruction: {
            var datamodel = []
            for (var i = 0; i < dataModel.count; ++i) {
                datamodel.push(dataModel.get(i))
            }
            datastore = JSON.stringify(datamodel)
        }

    }
    
    Row {
        spacing: units.largeSpacing / 2
        
        QtControls.Label {
            id: iconLabel
            width: formAlignment  - units.largeSpacing
            anchors.verticalCenter: iconComboBox.verticalCenter
            horizontalAlignment: Text.AlignRight
            text: "Icon:"
        }

        QtControls.ComboBox {
            id: iconComboBox
            property int textLength: 24
            width: theme.mSize(theme.defaultFont).width * textLength
            model: [
                        {
                            'label': "Alpine",
                            'iconPath': "icons/alpine.svg" 
                        },
                        {
                            'label': "Archlinux",
                            'iconPath': "icons/archlinux.svg" 
                        },
                        {
                            'label': "Debian",
                            'iconPath': "icons/debian.svg" 
                        },
                        {
                            'label': "Docker",
                            'iconPath': "icons/docker.svg" 
                        },
                        {
                            'label': "Elementary",
                            'iconPath': "icons/elementary.svg" 
                        },
                        {
                            'label': "Fedora",
                            'iconPath': "icons/fedora.svg" 
                        },
                        {
                            'label': "Gentoo",
                            'iconPath': "icons/gentoo.svg" 
                        },
                        {
                            'label': "KDE",
                            'iconPath': "icons/kde.svg" 
                        },
                        {
                            'label': "Mint",
                            'iconPath': "icons/linuxmint.svg" 
                        },
                        {
                            'label': "Manjaro",
                            'iconPath': "icons/manjaro.svg" 
                        },
                        {
                            'label': "Opensuse",
                            'iconPath': "icons/opensuse.svg" 
                        },
                        {
                            'label': "Plasma",
                            'iconPath': "icons/plasma.svg" 
                        },
                        {
                            'label': "Raspberry-pi",
                            'iconPath': "icons/raspberry-pi.svg" 
                        },
                        {
                            'label': "Snappy",
                            'iconPath': "icons/snappy.svg" 
                        },
                        {
                            'label': "Tux",
                            'iconPath': "icons/tux.svg" 
                        },
                        {
                            'label': "Ubuntu",
                            'iconPath': "icons/ubuntu.svg" 
                        }, 
                    ]

            textRole: "label"
            onCurrentIndexChanged: cfg_IconPath = model[currentIndex]["iconPath"]
            Component.onCompleted: setMethod();

            function setMethod() {
                for (var i = 0; i < model.length; i++) {
                    if (model[i]["iconPath"] == wallpaper.configuration.IconPath) {
                        iconComboBox.currentIndex = i;
                    }
                }
            }
        }
    }

    Row {
        spacing: units.largeSpacing / 2

        QtControls.Label {
            id: circleLabel
            width: formAlignment  - units.largeSpacing
            anchors.verticalCenter: circleColor.verticalCenter
            horizontalAlignment: Text.AlignRight
            text: "Circle Color:"
        }
        KQuickControls.ColorButton {
            id: circleColor
            dialogTitle: "Select Circle Color"
        }

        QtControls.Label {
            id: shadowLabel
            width: iconLabel.width + iconComboBox.width - circleLabel.width - 2*circleColor.width - units.largeSpacing
            visible: !useTimer.checked
            anchors.verticalCenter: shadowColor.verticalCenter
            horizontalAlignment: Text.AlignRight
            text: "Shadow Color:"
        }

        KQuickControls.ColorButton {
            id: shadowColor
            anchors.verticalCenter: circleColor.verticalCenter
            visible: !useTimer.checked
            dialogTitle: "Select Shadow Color"
        }
    }
   
    Row {
        spacing: units.largeSpacing / 2
        QtControls.Label {
            width: formAlignment  - units.largeSpacing
            anchors.verticalCenter: radiusValue.verticalCenter
            horizontalAlignment: Text.AlignRight
            text: "Curve Corner:"
            wrapMode: Text.WordWrap
        }

        QtControls.SpinBox {
                    id: radiusValue
                    Layout.minimumWidth: textMetrics.width + units.gridUnit
                    width: units.gridUnit * 4
                    decimals: 0
                    value: 0
                    minimumValue: 0
                    maximumValue: 100
        }

        QtControls.Label {
            width: shadowLabel.width - units.largeSpacing
            anchors.verticalCenter: radiusValue.verticalCenter
            horizontalAlignment: Text.AlignRight
            text: "Size:"
            wrapMode: Text.WordWrap
        }

        QtControls.SpinBox {
                    id: sizeValue
                    anchors.verticalCenter: radiusValue.verticalCenter
                    Layout.minimumWidth: textMetrics.width + units.gridUnit
                    width: units.gridUnit * 4
                    decimals: 0
                    value: 0
                    minimumValue: 0
                    maximumValue: 100
        }
    }

    Row {
        spacing: units.largeSpacing / 2

        QtControls.Label {
            id: useTimerLabel
            width: formAlignment  - units.largeSpacing 
            anchors.verticalCenter: useTimer.verticalCenter
            horizontalAlignment: Text.AlignRight
            text: "Rainbow Cycle:"
        }
        
        QtControls.CheckBox {
            id: useTimer
        }

        QtControls.Label {
            width: iconLabel.width + iconComboBox.width - useTimerLabel.width - 2*useTimer.width - units.largeSpacing + 10
            anchors.verticalCenter: useTimer.verticalCenter
            horizontalAlignment: Text.AlignRight
            text: "Hide Logo:"
        }
        QtControls.CheckBox {
            id: hideCheckBox
            anchors.verticalCenter: useTimer.verticalCenter
        }
    }
 
    Row {
        spacing: units.largeSpacing / 2
        visible: useTimer.checked
        QtControls.Label {
            width: formAlignment  - units.largeSpacing
            anchors.verticalCenter: timerValue.verticalCenter
            horizontalAlignment: Text.AlignRight
            text: "Next Color Duration:"
            wrapMode: Text.WordWrap
        }
        QtControls.TextField {
            id: timerValue
            width: formAlignment  - units.largeSpacing/2
            validator: IntValidator {bottom: 1; top: 99999;}
            maximumLength: 5
        }
        
        QtControls.Label {
            width: 50
            anchors.verticalCenter: timerValue.verticalCenter
            horizontalAlignment: Text.AlignLeft
            text: "sec"
        }
    }
    
    Row {
        spacing: units.largeSpacing / 2
        visible: useTimer.checked

        QtControls.Label {
            width: formAlignment  - units.largeSpacing
            anchors.verticalCenter: transitionValue.verticalCenter
            horizontalAlignment: Text.AlignRight
            text: "Transition Duration:"
            wrapMode: Text.WordWrap
        }
        QtControls.TextField {
            id: transitionValue
            width: formAlignment  - units.largeSpacing/2
            validator: IntValidator {bottom: 1; top: 99999;}
            maximumLength: 5
        }
        
        QtControls.Label {
            width: 50
            anchors.verticalCenter: transitionValue.verticalCenter
            horizontalAlignment: Text.AlignLeft
            text: "sec"
        }
    }

    Rectangle {
        id: gridRect
        Layout.fillHeight: true
        Layout.fillWidth: true 
        Layout.margins: units.largeSpacing
        color: "#33000000"
        clip: true

        QtControls.ScrollView {    
            horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
            verticalScrollBarPolicy: Qt.ScrollBarAlwaysOn
            height: gridRect.height
            width: gridRect.width
            
            Rectangle {
                height: flowtest.height
                width: gridRect.width
                color: "transparent"
    
               Grid {
                    id: flowtest
                    anchors.centerIn: parent
                    width: gridRect.width - 25
                    height: contentHeight - 20
                    columns: gridRect.width / 230
                    Repeater {
                        model: dataModel
                        delegate: numberDelegate
                    }
                }

                Component {
                    id: numberDelegate
                    Item {
                        width: 220
                        height: 160
                        Rectangle {
                            id: imageWrapper
                            width: 200
                            height: 140
                            radius: 4
                            anchors.centerIn: parent
                            color: currIndex == index ? "#44FFFFFF" : "#77000000"
                        
                            Image {
                                id: wallThumbnail
                                anchors.fill: parent
                                anchors.margins: 5
                                source: Qt.resolvedUrl(path)
                                fillMode: Image.PreserveAspectCrop
                            }
                            
                            MouseArea {
                                anchors.fill: imageWrapper
                                onClicked: {
                                        currIndex = index
                                        cfg_WallPath = qsTr(dataModel.get(index).path)
                                }
                            }
                            
                        }
                        Rectangle {
                            id: delett
                            height: width
                            width: 30
                            radius: width/2
                            color: delettMouse.containsMouse?"red":"#44000000"
                            anchors {
                                bottom: imageWrapper.bottom
                                bottomMargin: width/3 
                                right: imageWrapper.right
                                rightMargin: width/3
                            }
                            Image {
                                anchors.centerIn: parent
                                source: "x.svg"
                                sourceSize: width/1.5 
                            }
                            MouseArea {
                                id: delettMouse
                                anchors.fill: delett
                                hoverEnabled : true
                                onClicked: {
                                    dataModel.remove(index)
                                }
                            }
                        }
                        
                    }
                }

                ListModel {
                    id: dataModel
                    ListElement {path: "wallpaper/bitmap4.png"}
                }

            }
        }
    }

    Component {
        id: fileDialogC

        FileDialog {
                id: fileDialog
                title: "Please choose Image file(s)"
                folder: shortcuts.home
                selectMultiple: true
                onAccepted: {
                    var doit = 0 
                    for (var i = 0; i < fileDialog.fileUrls.length; i++) {
                        doit = 0 
                        for (var j = 0; j < dataModel.count; j++){
                            if (fileDialog.fileUrls[i] == dataModel.get(j).path) {doit = 1}
                        }
    
                        if (doit == 0) {
                            dataModel.append({"path":fileDialog.fileUrls[i]})
                        }
                    }
                    fileDialogLoader.active = false
                }
                onRejected: {
                    console.log("Canceled")
                    fileDialogLoader.active = false
                }
                
                Component.onCompleted: fileDialog.visible=true 
                Component.onDestruction: console.log("Destruction Beginning!")
        }
    }

    Loader {    
        id: fileDialogLoader
        active: false
        sourceComponent: fileDialogC
    }

    QtControls.Button {
        text: "Add Image"
        Layout.alignment: Qt.AlignRight
        onClicked: {
            fileDialogLoader.active = true
        }
    }
}
