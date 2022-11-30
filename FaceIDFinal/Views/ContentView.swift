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
    @State private var chickens = ["chicken1", "chicken2", "chicken3"]
    @EnvironmentObject var appInfo: ChickenData
    @State private var image: UIImage?
     
    var body: some View {
        NavigationView {
            VStack {
                if authenticationManager.isAuthenticated {
                    VStack(spacing: 40) {
                        //Title()
                        
                        Image(uiImage: image ?? UIImage(named: chickens[appInfo.chosenChicken])!)
                            .resizable()
                            .frame(width: 300, height: 300)
                        
//                        NavigationLink(destination: LoginView(), label:{
//                            Text("go back")
//                        })
                        
                        PrimaryButton(showImage: false, text: "Back")
                            .onTapGesture {
                                authenticationManager.logout()
                            }
                    }
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
