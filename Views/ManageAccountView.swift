//
//  ManageAccountView.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 8/5/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct ManageAccountView: View {
    @StateObject var userStore: UserStore = UserStore.shared
    
    @ViewBuilder
    var body: some View {
        DisclosureGroup("Projects") {
            ForEach(userStore.user?.projects ?? []) { project in
                projectCell(project: project)
            }
        }
        DisclosureGroup("Tags") {
            ForEach(userStore.user?.tags ?? []) { tag in
                tagCell(tag: tag)
            }
        }
    }
    

    func projectCell(project: TogglProject) -> some View {
        NavigationLink (
            destination: ProjectInspector (
                project: .init(
                    get: { project },
                    set: { userStore.updateProject(from: project, to: $0) }
                )
            )
        ) {
            Label(title: {Text(project.name ?? "")}) {
                Image(systemName: projectIcon)
                    .foregroundColor(project.color())
            }
        }
    }
    
    func tagCell (tag: TogglTag) -> some View {
        FormCell(
            label: tag.name ?? "Untitled",
            content: EmptyView(),
            image: tagIcon,
            tint: tagColor)
    }
    
    let projectIcon = "folder.fill"
    let tagIcon = "tag.fill"
    let tagColor = Color.purple
}
