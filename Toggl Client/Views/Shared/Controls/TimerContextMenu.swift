import SwiftUI

struct ContextMenuDeleteButton: View {
    var deleteAction: () -> Void
    
    var body: some View {
        Button(action: deleteAction) {
            Text(title)
            Image(systemName: iconName)
        }
    }
    
    //MARK: Constants
    let iconName = "trash"
    let title = "Delete"
    
}

struct ContextMenuDuplicateButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Duplicate")
            Image(systemName: "doc.on.doc")
        }
    }
}

struct ContextMenuPinButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Pin")
            Image(systemName: "pin")
        }
    }
}

struct ContextMenuPlayButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Start")
            Image(systemName: "play")
        }
    }
}

struct ContextMenuEditButton: View {
    var editAction: () -> Void

    var body: some View {
        Button(action: editAction) {
            Text(title)
            Image(systemName: "pencil")
        }
    }
    
    //MARK: Constants
    let iconName = "pencil"
    let title = "Edit"
}

struct ContextMenuAddButton: View {
    var editAction: () -> Void

    var body: some View {
        Button(action: editAction) {
            Text(title)
            Image(systemName: "plus.app.fill")
        }
    }
    
    //MARK: Constants
    let iconName = "plus"
    let title = "Add"
}

struct ContextMenuSortButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
            Image(systemName: image)
        }
    }
    
    //MARK: Constants
    let iconName = "pencil"
    let title = "Sort"
    let image = "sort"
}
