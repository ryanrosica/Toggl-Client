//
//  TimerInspector.swift
//  Timer2
//
//  Created by Ryan Rosica on 5/14/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct TimerInspectorViewSmall: View {
    enum Inspector {
        case projects
        case tags
    }
    
    @Binding var timer: TogglTimer
    @State var editingTimer: TogglTimer = TogglTimer()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let userStore = UserStore.shared
    @Binding var open: Bool
    var completion: () -> Void
    @State var loading = false
    @State var sheet = false
    @State var inspector: Inspector = .projects

    var body: some View {
        VStack(spacing: 8) {
        
//            Button(action: {
//                sheet = true
//                inspector = .projects
//            }) {
//                FormCell(
//                    label: "Project",
//                    content:
//                        Text(self.editingTimer.project?.name ?? "No Project")
//                            .font(UIConstants.Fonts.body)
//                            .foregroundColor(.gray),
//                    image: "folder.fill",
//                    tint: .purple
//                )
//            }


            PPicker(editingTimer: $editingTimer, menuPickerStyle: true)
            
            Divider()

            Button (action: {
                sheet = true
                inspector = .tags
            }) {
                FormCell(
                    label: "Tags",
                    content:
                        Text(self.editingTimer.tags?.joined(separator: ", ") ?? "")
                            .font(UIConstants.Fonts.body)
                            .foregroundColor(.gray),
                    image: "tag.fill",
                    tint: .yellow
                )
            }


            
            Divider()

            FormCell (
                label: "Description",
                content:
                    TextField("Description", text: .init(
                        get: {self.editingTimer.description ?? ""},
                        set: {self.editingTimer.description = $0}
                    )).foregroundColor(.gray).multilineTextAlignment(.trailing),
                image: "doc.plaintext",
                tint: .blue
            )

            Divider()

             DateRangePicker (
                dateWidth: datePickerWidth,
                startDate: .init(
                    get: {
                        editingTimer.start
                    },
                    set: {
                        editingTimer.start = $0
                    }
                ),
                endDate: .init(
                    get: {
                        editingTimer.stop
                    },
                    set: {
                        editingTimer.stop = $0
                    }
                ),
                displayedComponents: [.hourAndMinute]
            
            )

            HStack(spacing: 0) {
                SecondaryActionButton (name: "Cancel"){
                    self.editingTimer = self.timer
                    open = false
                }
                ActionButton (name: "Save"){
                    self.timer = self.editingTimer
                    UserStore.shared.refresh()
                }
            }



            
            

        }
        
        .onAppear {
            self.editingTimer = self.timer
        
        }
        .sheet(isPresented: $sheet) {
            switch (inspector) {
                case .projects:
                    NavigationView {
                        ProjectPicker(
                            project: .init(
                                get: {(self.editingTimer.project ?? nil)},
                                set: {self.editingTimer.project = $0})
                        )
                        .navigationTitle("Projects")

                    }

                case .tags:
                    NavigationView {
                        TagPicker(
                            tags: .init(
                                get: {(self.editingTimer.tags ?? [])},
                                set: {self.editingTimer.tags = $0}),
                            userStore: userStore
                        )
                    }
                    .accentColor(UIConstants.Colors.theme)

            }

        }
        
        
        
    }
    
    let datePickerWidth: CGFloat = 80
}


struct PPicker: View {
    @Binding var editingTimer: TogglTimer
    var menuPickerStyle = true
    var body: some View {
        
        Picker (
            selection: .init (
                get: {
                    return editingTimer.project?.name ?? ""
                },
                set: {newProject in editingTimer.project = UserStore.shared.user?.project(with: newProject) }
            ),
            label:
                FormCell(
                    label: "Project",
                    content:
                        Text(menuPickerStyle ? self.editingTimer.project?.name ?? "No Project" : "")
                            .font(UIConstants.Fonts.body)
                            .foregroundColor(.gray),
                    image: "folder.fill",
                    tint: .purple
                )
        ) {
            ForEach (UserStore.shared.user?.projects ?? []) { project in
                Label(
                    title: { Text(project.name ?? "") },
                    icon: { Circle().foregroundColor(project.color()).frame(height: 5) }
                )
                .tag(project.name ?? "")

                
            }

        }
        .if(menuPickerStyle) {$0.pickerStyle(MenuPickerStyle() ) }

    }
}
