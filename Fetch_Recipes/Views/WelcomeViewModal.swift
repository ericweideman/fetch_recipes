//
//  WelcomeView.swift
//  Fetch_Recipes
//
//  Created by Eric Weideman on 10/25/24.
//
import SwiftUI

struct WelcomeViewModal: View {
    @Binding var isFirstLogin: Bool
    var body: some View {
        VStack {
            Text("Welcome to Fetch Recipes!")
                .font(.title)
            Text("Thank you for joining us.")
                .padding()
            Button("Get Started") {
                UserDefaults.standard.set(true, forKey: "hasLoggedInBefore")
                isFirstLogin = false
            }
        }
        .presentationDetents([.fraction(0.75)])
        .presentationDragIndicator(.hidden)
        .background(Color.clear)
        .padding()
    }
}


#Preview {
    @Previewable @State var testBool: Bool = true
    WelcomeViewModal(isFirstLogin: $testBool)
}
