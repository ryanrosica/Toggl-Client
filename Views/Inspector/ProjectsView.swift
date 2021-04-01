//
//  ProjectsView.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 11/11/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct ProjectsView: View {
    let userStore = UserStore.shared
    @Binding var project: TogglProject?
    @StateObject var projectsViewModel = ProjectsViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var gridModel: GridModel<TogglProject> {
        GridModel(numberOfRows: 4, items: projectsViewModel.projects ?? [])
    }

    var body: some View {
        VStack {
            TextField(
                "Search",
                text: .init (
                    get: { projectsViewModel.filter },
                    set: { projectsViewModel.filter = $0 }
                )
            )
            .padding()
            .background(Color(.systemFill))
            .cornerRadius(15.0)
            .frame(maxWidth: 500)
            .padding()
            
            
            StaggeredGrid(gridModel: gridModel ) { currentProject in
                ProjectView(project: currentProject, selected: currentProject.id == self.project?.id) {
                    self.project = currentProject
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            
            Spacer()
        }

    }
}


struct ProjectView: View {
    var project: TogglProject
    var selected: Bool
    var selectedAction: () -> Void
    
    var body: some View {
//        RoundedRectangle(cornerRadius: 10)
//            .stroke(project.color(), lineWidth: 4)
//            .foregroundColor(Color(.systemBackground))
//            .background(
//                Text(project.name ?? "Untitled")
//                    .bold()
//                    .fixedSize()
//                    .foregroundColor(project.color())
//                    .lineLimit(1)
//
//            )
//            .frame(height: 40)

        
        Text(project.name ?? "Untitled")
            .bold()
            .fixedSize()
            .foregroundColor(selected ? .white : project.color())
            .lineLimit(1)
            .padding(4)
            .background(
                (selected) ?
                AnyView (
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(project.color())
                ):
                AnyView (
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(project.color(), lineWidth: 2.5)
                    EmptyView()
                )
            )
            .onTapGesture {
                print("Tapped")
                selectedAction()
            }

            
        

    }
}

struct GridModel<T: Identifiable> {
    var numberOfRows: Int
    var items: [T]
    var rows: [[T]] {
        let rows = items.indices.filter { $0 % numberOfRows == 0 }
        return rows.map {
            let endIndex = ($0 + numberOfRows < items.count) ? $0 + numberOfRows : items.count
            return Array(items[$0..<(endIndex)])
        }
        
    }
    
}

struct StaggeredGrid<T: Identifiable, ViewType: View>: View {
    var gridModel: GridModel<T>
    var content: (T) -> ViewType
    
    
    
    var body: some View {
        VStack (alignment: .leading, spacing: 8) {
            ForEach(gridModel.rows, id: \.first!.id) { row in
                HStack (spacing: 8){
                    ForEach(row) { item in
                        content(item)
                    }
                }

            }
        }
    }
    
    
}
