import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs
import org.kde.kirigami 2.20 as Kirigami

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

    Kirigami.ActionToolBar {
        id: toolBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        actions: [
            Kirigami.Action {
                text: qsTr("New")
                icon.name
        :
        "document-new"
        onTriggered: {
            editor.text = "# New note\n\nStart typing…";
            root.currentPath = "";
            root.newRequested();
        }
    }
    ,
    Kirigami.Action {
        text: qsTr("Open")
        icon.name: "document-open"
        onTriggered: openDialog.open()
    }
    ,
    Kirigami.Action {
        text: qsTr("Save")
        icon.name: "document-save"
        onTriggered: {
            if (root.currentPath === "") {
                saveDialog.open();
            } else {
                root.saveRequested(root.currentPath, editor.text);
            }
        }
    }
    ,
    Kirigami.Action {
        separator: true
    }
    ,
    Kirigami.Action {
        text: root.splitView ? qsTr("Single Pane") : qsTr("Split View")
        icon.name: root.splitView ? "view-restore" : "view-split-left-right"
        onTriggered: root.splitView = !root.splitView
    }
    ,
    Kirigami.Action {
        text: root.showPreview ? qsTr("Hide Preview") : qsTr("Show Preview")
        icon.name: "preview"
        onTriggered: root.showPreview = !root.showPreview
    }
    ]
}

// Layout area
RowLayout {
    id: content
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: toolBar.bottom
    anchors.bottom: parent.bottom
    spacing: 8
    leftPadding: 8
    rightPadding: 8
    bottomPadding: 8

    // Editor pane
    ScrollView {
        id: editorPane
        visible: !root.showPreview || root.splitView
        Layout.fillHeight: true
        Layout.fillWidth: root.splitView ? true : !root.showPreview
        Layout.preferredWidth: root.splitView ? 0.5 : 1
        clip: true

        TextArea {
            id: editor
            width: parent.width
            height: parent.height
            placeholderText: qsTr("# Markdown\n\nType here…")
            wrapMode: TextEdit.Wrap
            font.family: "Menlo, Monaco, Consolas, 'Courier New', monospace"
            font.pointSize: 12
            selectByMouse: true
            persistentSelection: true
        }
    }

    // Preview pane
    ScrollView {
        id: previewPane
        visible: root.showPreview
        Layout.fillHeight: true
        Layout.fillWidth: root.splitView ? true : root.showPreview
        Layout.preferredWidth: root.splitView ? 0.5 : 1
        clip: true

        Rectangle { // background for contrast
            anchors.fill: parent
            color: Qt.rgba(1, 1, 1, 0.03)

            Text {
                id: preview
                anchors.fill: parent
                anchors.margins: 12
                text: editor.text
                textFormat: Text.MarkdownText
                wrapMode: Text.WordWrap
                color: "#f0f0f0"
                font.pointSize: 12
            }
        }
    }
}

FileDialog {
    id: openDialog
    title: qsTr("Open Markdown")
    currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
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
    currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
    fileMode: FileDialog.SaveFile
    defaultSuffix: "md"
    nameFilters: [qsTr("Markdown (*.md *.markdown)")]
    onAccepted: {
        root.currentPath = selectedFile.toString()
        root.saveRequested(root.currentPath, editor.text)
    }
}
}
