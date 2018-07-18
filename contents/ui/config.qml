import QtQuick 2.0
import QtQuick.Controls 1.0 as QtControls
import org.kde.kquickcontrols 2.0 as KQuickControls
import org.kde.plasma.core 2.0 as Plasmacore

Column {
    id: root
    spacing: units.largeSpacing/3
    property alias cfg_CircleColor: circleColor.color
    property alias cfg_ShadowColor: shadowColor.color
    property alias cfg_HideLogo: hideCheckBox.checked
    property alias cfg_UseTimer: useTimer.checked
    property alias cfg_TimerValue: timerValue.text
    property alias cfg_TransitionValue: transitionValue.text
    property string cfg_IconPath
    
    Rectangle {
        width: 10
        height: units.largeSpacing/2
        color: "transparent"
    }
    
    Row {
        spacing: units.largeSpacing / 2
        
        QtControls.Label {
            width: formAlignment
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
            width: formAlignment
            anchors.verticalCenter: circleColor.verticalCenter
            horizontalAlignment: Text.AlignRight
            text: "Circle Color:"
        }
        KQuickControls.ColorButton {
            id: circleColor
            dialogTitle: "Select Circle Color"
        }
    }

    Row {
        spacing: units.largeSpacing / 2

        QtControls.Label {
            width: formAlignment 
            anchors.verticalCenter: useTimer.verticalCenter
            horizontalAlignment: Text.AlignRight
            text: "Rainbow Cycle:"
        }
        
        QtControls.CheckBox {
            id: useTimer
        }
        
        QtControls.Label {
            width: formAlignment 
            visible: !useTimer.checked
            anchors.verticalCenter: useTimer.verticalCenter
            horizontalAlignment: Text.AlignRight
            text: "Shadow Color:"
        }

        KQuickControls.ColorButton {
            id: shadowColor
            anchors.verticalCenter: useTimer.verticalCenter
            visible: !useTimer.checked
            dialogTitle: "Select Shadow Color"
        }
    }

    Row {
        spacing: units.largeSpacing / 2

        QtControls.Label {
            width: formAlignment
            anchors.verticalCenter: hideCheckBox.verticalCenter
            horizontalAlignment: Text.AlignRight
            text: "Hide Logo:"
        }
        QtControls.CheckBox {
            id: hideCheckBox
        }
    }
    
    Row {
        spacing: units.largeSpacing / 2
        visible: useTimer.checked
        QtControls.Label {
            width: formAlignment
            anchors.verticalCenter: timerValue.verticalCenter
            horizontalAlignment: Text.AlignRight
            text: "Next Color Duration:"
            wrapMode: Text.WordWrap
        }
        QtControls.TextField {
            id: timerValue
            width: formAlignment/2
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
            width: formAlignment
            anchors.verticalCenter: transitionValue.verticalCenter
            horizontalAlignment: Text.AlignRight
            text: "Transition Duration:"
            wrapMode: Text.WordWrap
        }
        QtControls.TextField {
            id: transitionValue
            width: formAlignment/2
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
}
