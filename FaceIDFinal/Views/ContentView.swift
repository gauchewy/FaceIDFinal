//
//  ContentView.swift
//  FaceIDFinal
//
//  Created by Qiwei on 11/30/22.
//
//
// after you're in

import SwiftUI

struct ContentView: View {
    @StateObject var authenticationManager = AuthenticationManager()
     
    var body: some View {
        NavigationView {
            VStack {
                if authenticationManager.isAuthenticated {
                    VStack(spacing: 40) {
                        Title()
                        
                        Text("Welcome in! You are now authenticated.")
                            .foregroundColor(.white)
                        
                        NavigationLink(destination: LoginView(), label:{
                            Text("go back")
                        })
                        
//                        PrimaryButton(showImage: false, text: "Back")
//                            .onTapGesture {
//                                authenticationManager.logout()
//                            }
                    }
                    .navigationTitle("test title")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    
                    
                    
                } else {
                    LoginView()
                        .environmentObject(authenticationManager)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .alert(isPresented: $authenticationManager.showAlert) {
                Alert(title: Text("Error"), message: Text(authenticationManager.errorDescription ?? "Error trying to login with credentials, please try again"), dismissButton: .default(Text("Ok")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
