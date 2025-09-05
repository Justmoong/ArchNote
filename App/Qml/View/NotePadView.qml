import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs

Item {
    id: root
    Layout.fillWidth: true
    Layout.fillHeight: true

    // State
    property string currentPath: ""
    property bool showPreview: true
    property bool splitView: true

    signal newRequested()

    signal openRequested(string path)

    signal saveRequested(string path, string contents)

    // Material Design 툴바
    ToolBar {
        id: toolBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        Material.primary: Material.BlueGrey

        RowLayout {
            anchors.fill: parent
            anchors.margins: 8
            spacing: 8

            Button {
                text: qsTr("📄 New")
                flat: true
                Material.foreground: "white"
                onClicked: {
                    editor.text = "# New note\n\nStart typing…";
                    root.currentPath = "";
                    root.newRequested();
                }
            }

            Button {
                text: qsTr("📁 Open")
                flat: true
                Material.foreground: "white"
                onClicked: openDialog.open()
            }

            Button {
                text: qsTr("💾 Save")
                flat: true
                Material.foreground: "white"
                onClicked: {
                    if (root.currentPath === "") {
                        saveDialog.open();
                    } else {
                        root.saveRequested(root.currentPath, editor.text);
                    }
                }
            }

            Rectangle {
                width: 1
                height: parent.height * 0.6
                color: Material.dividerColor
                Layout.alignment: Qt.AlignVCenter
            }

            Button {
                text: root.splitView ? qsTr("📑 Single") : qsTr("📊 Split")
                flat: true
                Material.foreground: "white"
                onClicked: root.splitView = !root.splitView
            }

            Button {
                text: root.showPreview ? qsTr("👁️ Hide") : qsTr("👀 Preview")
                flat: true
                Material.foreground: "white"
                onClicked: root.showPreview = !root.showPreview
            }

            Item {
                Layout.fillWidth: true
            }
        }
    }

// Layout area
    Item {
    id: content
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: toolBar.bottom
    anchors.bottom: parent.bottom
        anchors.margins: 8

        RowLayout {
            anchors.fill: parent
            spacing: 8

            // Material Design 에디터 카드
            Pane {
                visible: !root.showPreview || root.splitView
                Layout.fillHeight: true
                Layout.fillWidth: root.splitView ? true : !root.showPreview
                Layout.preferredWidth: root.splitView ? 0.5 : 1
                Material.elevation: 2

                ScrollView {
                    id: editorPane
                    anchors.fill: parent
                    clip: true

                    TextArea {
                        id: editor
                        placeholderText: qsTr("# Markdown\n\nType here…")
                        wrapMode: TextEdit.Wrap
                        font.family: "SF Mono, Monaco, Consolas, 'Courier New', monospace"
                        font.pointSize: 13
                        selectByMouse: true
                        persistentSelection: true

                        Material.theme: Material.Dark
                        background: Rectangle {
                            color: Material.backgroundColor
                            radius: 4
                        }
                    }
                }
            }

            // Material Design 프리뷰 카드
            Pane {
                visible: root.showPreview
                Layout.fillHeight: true
                Layout.fillWidth: root.splitView ? true : root.showPreview
                Layout.preferredWidth: root.splitView ? 0.5 : 1
                Material.elevation: 2

                ScrollView {
                    id: previewPane
                    anchors.fill: parent
                    clip: true

                    Text {
                        id: preview
                        width: previewPane.width - 24
                        text: editor.text
                        textFormat: Text.MarkdownText
                        wrapMode: Text.WordWrap
                        color: Material.primaryTextColor
                        font.pointSize: 13
                        padding: 12
                    }
                }
            }
        }

        FileDialog {
            id: openDialog
            title: qsTr("Open Markdown")
            nameFilters: [qsTr("Markdown (*.md *.markdown)"), qsTr("Text (*.txt)"), qsTr("All Files (*)")]
            onAccepted: {
                // QML has no direct file I/O; emit signal for C++ side
                root.currentPath = selectedFile.toString()
                root.openRequested(root.currentPath)
            }
        }

        FileDialog {
            id: saveDialog
            title: qsTr("Save Markdown")
            fileMode: FileDialog.SaveFile
            defaultSuffix: "md"
            nameFilters: [qsTr("Markdown (*.md *.markdown)")]
            onAccepted: {
                root.currentPath = selectedFile.toString()
                root.saveRequested(root.currentPath, editor.text)
            }
        }
}
}
