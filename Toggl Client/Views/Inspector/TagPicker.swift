//
//  TagPicker.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/20/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct TagPicker: View {
    @Binding var tags: [String]
    @State var editingTags: [String] = []
    @State var search = ""
    @ObservedObject var userStore: UserStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var allTags: [String] {
        var result = Set((userStore.user?.tags ?? []).map{ $0.name ?? "" })
        tags.forEach { result.insert($0) }
        if (search == "") { return Array(result).sorted() }
        var arr = Array(result)
        arr = arr.sorted().filter { $0.contains(search) }
        if (!tags.contains(search) && !arr.contains(search)) { arr.append(search) }
        return arr
    }

    var body: some View {
        List {
            Section( header:
                TextField("Search or Add a Tag..", text: $search)
                    .textCase(nil)
                    .padding()
                    .background(Color(.tertiarySystemFill))
                    .cornerRadius(15.0)
                    .listRowBackground(Color(.systemGroupedBackground))
            ){}
            .onAppear {
                editingTags = tags
            }
            
            ForEach(allTags, id: \.self) { tag in
                Button (
                    action: {
                        if (!editingTags.contains(tag)) { self.editingTags.append(tag)}
                        else {
                            self.editingTags.removeAll(where: {$0 == tag})
                            print(editingTags)
                        }
                    },
                    label: {
                        HStack {
                            if (self.tags.contains(where: {$0 == tag})) {
                                Image(systemName: "tag.fill")
                                    .foregroundColor(.blue)
                            }
                            else {
                                Image(systemName: "tag")
                                    .foregroundColor(.blue)
                            }
                            Text(tag)
                                .font(UIConstants.Fonts.body)
                                .foregroundColor(.primary)
                        }
                    }
                )
            }
            
            Section(header:
                ActionButton(name: "Done", action: {
                    self.tags = editingTags
                    self.presentationMode.wrappedValue.dismiss()
                })
                .listRowBackground(Color(.systemGroupedBackground))
            ) {}
        }
        .navigationBarTitle("Tags")
        .listStyle(InsetGroupedListStyle())

    }
    
    
}

