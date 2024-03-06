//
//  ErrorView.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha
//

import SwiftUI
struct ErrorView: View {
    let errorMessage: String
    
    var body: some View {
        Text(errorMessage)
            .alert(isPresented: .constant(true)) {
                Alert(title: Text("Error"),
                      message: Text(errorMessage),
                      dismissButton: .default(Text("OK")))
            }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorMessage: "NetworkError")
    }
}

