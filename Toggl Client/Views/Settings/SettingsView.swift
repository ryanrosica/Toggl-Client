//
//  SettingsView.swift
//  Timer3
//
//  Created by Ryan Rosica on 6/18/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var loginStore: LoginStore
    var savedTimersStore: SavedTimersStore
    @State var confirming = false
    var body: some View {
        Form {
            Section (header: Text ("Profile")) {
                NavigationLink(
                    destination:  List{ManageAccountView().navigationTitle("Manage Account")},
                    label: {
                        ProfileRow(name: UserStore.shared.user?.fullname ?? "Name not found", email: UserStore.shared.user?.email ?? "No email")
                    }
                )
            }
            
            FormCell(label: "Logout", content: EmptyView())
                .onTapGesture {
                    self.confirming = true
                }
        }

        .navigationBarTitle("Settings")
        
        .actionSheet(isPresented: $confirming) {
            ActionSheet (
                title: Text("Confirm Logout"),
                message: Text("All saved timers will be deleted"),
                buttons: [
                    .destructive(Text("Logout")) {
                        self.savedTimersStore.clear()
                        self.loginStore.logout()
                    },
                    .cancel()
                ]
            )
        }
    }


}




