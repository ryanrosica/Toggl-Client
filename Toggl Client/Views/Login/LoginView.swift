//
//  LoginView.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/27/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State private var password: String = ""
    @State private var username: String = ""
    @State var loading = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var store: LoginStore
    @State var attempts = 0
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                    .frame(height: 50)
                if (attempts > 0) {
                    Text ("Somethings Wrong!")
                        .font(.system(.body))
                        .bold()
                        .foregroundColor(.red)
                }
                Text("Login to Toggl")
                    .font(.system(.largeTitle))
                    .fontWeight(.heavy)
                TextField("email", text: $username)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .background(Color(.tertiarySystemFill))
                    .cornerRadius(15.0)
                    .frame(maxWidth: 500)
                    .padding()
                SecureField("password", text: $password)
                    .padding()
                    .background(Color(.tertiarySystemFill))
                    .frame(maxWidth: 500)
                    .cornerRadius(15.0)
                    .padding()
                if (!loading) {
                    Button(action: {
                        self.loading = true
                        self.store.login(username: self.username, password: self.password) {_ in
                            self.loading = false
                            self.attempts += 1
                        }
                    }) {
                        Text("login")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                else {
                    ProgressView()
                }
                    
            }
        }
        
    }
}

