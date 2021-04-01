//
//  ErrorView.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 9/14/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct DisplayError: ViewModifier {
    @ObservedObject var view: ViewModel
    var errorMessage: ((TogglAPIError) -> String)?
    var message: String {
        if let errorMessage = errorMessage {
            return errorMessage(error ?? .unknown)
        }
        else {
            return (error ?? .unknown).localizedDescription
        }
    }
    
    @State var showing = true
    var error: TogglAPIError? {
        if case .error(let error) = view.state {
            return error
        }
        return nil
    }
    func body(content: Content) -> some View {
        content
            .alert(isPresented:
                .init(
                    get: {
                        if case .error(_) = view.state {
                            return true
                        }
                        return false
                    },
                    set: {
                        _ in
                    }
                )
            ) {
                Alert(
                    title: Text("Error"),
                    message: Text(message),
                    dismissButton: .default(Text("Dismiss"))
                )
            }
    }
}

extension View {
    func displayError(view: ViewModel, errorMessage: ((TogglAPIError) -> String)? = nil) -> some View {
        return self.modifier(DisplayError(view: view, errorMessage: errorMessage))
    }
}
