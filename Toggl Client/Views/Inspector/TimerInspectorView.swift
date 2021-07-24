//
//  TimerInspector.swift
//  Timer2
//
//  Created by Ryan Rosica on 5/14/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI


struct TimerInspectorView: View {
    @Binding var timer: TogglTimer
    @State var editingTimer: TogglTimer = TogglTimer()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let userStore = UserStore.shared
    @State var loading = false
    
    @ViewBuilder
    var body: some View {
        if (loading) {
//            ProgressView()
        }
        else {
            ZStack (alignment: .top) {
                navView
                DragHandle()
                    .padding(3)
                
            }
        }

    }
    var navView: some View {
        NavigationView {
            List {
                
                if editingTimer.start != nil {
                    Section {
                        FormCell(
                            label: "Time",
                            content: TimeView(timer: editingTimer),
                            image: "stopwatch.fill"
                        )
                    }

                }
                
                
                Section() {
//                    PPicker(editingTimer: $editingTimer, menuPickerStyle: false)
                    NavigationLink (
                        destination: ProjectPicker(
                            project: .init(
                                get: {self.editingTimer.project},
                                set: {self.editingTimer.project = $0}
                            )
                        )
                    ) {
                        FormCell(
                            label: "Project",
                            content:
                                Text(self.editingTimer.project?.name ?? "No Project")
                                    .font(UIConstants.Fonts.body)
                                    .foregroundColor(.gray),
                            image: "folder.fill",
                            tint: .yellow
                        )
                    }
                    
                    NavigationLink (
                        destination: TagPicker(
                            tags: .init(
                                get: {(self.editingTimer.tags ?? [])},
                                set: {self.editingTimer.tags = $0}),
                            userStore: userStore
                        )
                    ) {
                        FormCell(
                            label: "Tags",
                            content:
                                Text(self.editingTimer.tags?.joined(separator: ", ") ?? "")
                                    .font(UIConstants.Fonts.body)
                                    .foregroundColor(.gray),
                            image: "tag.fill",
                            tint: .blue
                        )
                    }
                    FormCell (
                        label: "Description",
                        content:
                            TextField("Description", text: .init(
                                get: {self.editingTimer.description ?? ""},
                                set: {self.editingTimer.description = $0}
                            )).foregroundColor(.gray).multilineTextAlignment(.trailing),
                        image: "doc.plaintext",
                        tint: .purple
                    )


                }

                
                Section {

                    
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
                        displayedComponents: [.hourAndMinute, .date]
                    )
                }
                
                
                Section {
                    Button(action: {
                        self.timer = self.editingTimer
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Save")
                                .font(UIConstants.Fonts.bodyHeader)
                                .foregroundColor(.white)
                            Spacer()
                        }
                    })
                    .listRowBackground(UIConstants.Colors.theme)
                }
   
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Time Entry")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            self.editingTimer = self.timer
        }
    }
    
    let datePickerWidth: CGFloat = 200
}

