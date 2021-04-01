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

    
    var body: some View {
        VStack {
            TextField("Name", text: .init(get: { (newProject.name ?? "")}, set: { newProject.name = $0 }))
                .padding()
                .background(Color(.tertiarySystemFill))
                .cornerRadius(15.0)
                .padding()
            ColorPickerView(colors:
                [[Color.red, Color.green, Color.orange, Color.pink, Color.red, Color.green],
                 [Color.yellow, Color.purple, Color.blue, Color.pink, Color.red, Color.green]], selected: .init(get: { newProject.colorID ?? 0 }, set: { newProject.colorID =  $0})
            )

            ActionButton (name: "Save") {
                project = newProject
                presentationMode.wrappedValue.dismiss()
            }
            

            Spacer()
            
        }
        .navigationBarTitle("New Project")

        .onAppear {
            self.newProject = self.project
        }

    }
}


