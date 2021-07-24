//
//  NewProjectView.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/29/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct ProjectInspector: View {
    @Binding var project: TogglProject
    @State var newProject: TogglProject = TogglProject()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var initialized = false
    
    var body: some View {
        VStack {
            TextField("Name", text: .init(get: { (newProject.name ?? "")}, set: { newProject.name = $0 }))
                .padding()
                .background(Color(.tertiarySystemFill))
                .cornerRadius(15.0)
                .padding()
            ColorPickerView(selected: .init(get: { newProject.colorID ?? 0 }, set: { newProject.colorID =  $0}))

            ActionButton (name: "Save") {
                project = newProject
                presentationMode.wrappedValue.dismiss()
            }
            Spacer()
        }
        .navigationBarTitle(newProject.name ?? "")

        .onAppear {
            self.newProject = self.project
        }

    }
}


