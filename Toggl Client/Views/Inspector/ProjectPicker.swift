//
//  TextFieldView.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/20/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct ProjectPicker: View {
    @Binding var project: TogglProject?
    @StateObject var projectsViewModel = ProjectsViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        List {
            Section (header:
                TextField(
                    "Search",
                    text: .init (
                        get: { projectsViewModel.filter },
                        set: { projectsViewModel.filter = $0 }
                    )
                )
                    .textCase(nil)
                .padding()
                .background(Color(.tertiarySystemFill))
                .cornerRadius(15.0)
                .frame(maxWidth: 500)
                
            ){}
            
            
            
            ForEach(projectsViewModel.projects ?? []) {project in
                Button(action: {
                    self.project = project
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("\((project.id == self.project?.id ?? -1) ? "✓ " : "")\(project.name ?? "")")
                        .font(UIConstants.Fonts.body)
                        .foregroundColor(project.color())
                }
            }
            .onDelete { indexSet in
                for index in indexSet {
                    UserStore.shared.deleteProject(at: index)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Projects")
        .environment(\.horizontalSizeClass, .regular)

    }
}


struct ProjectPicker_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

