//
//  LoginView.swift
//  FaceIDFinal
//
//  Created by Qiwei on 11/30/22.
//
// before you're in

import SwiftUI

struct ImageView: View {
    @EnvironmentObject var authenticationManager: AuthenticationManager
    
    var body: some View {
        VStack(spacing: 40) {
            Title()

            // Evaluate the biometryType and display a button accordingly
            switch authenticationManager.biometryType {
            case .faceID:
                PrimaryButton(image: "faceid", text: "Login with FaceID")
                    .onTapGesture {
                        Task.init {
                            await authenticationManager.authenticateWithBiometrics()
                        }
                    }
            case .touchID:
                PrimaryButton(image: "touchid", text: "Login with TouchID")
                    .onTapGesture {
                        Task.init {
                            await authenticationManager.authenticateWithBiometrics()
                        }
                    }
            default:
                NavigationLink {
                    CredentialsLoginView()
                        .environmentObject(authenticationManager)
                } label: {
                    PrimaryButton(image: "person.fill", text: "Login with your credentials")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}


struct LoginView: View {

    @State private var chickens = ["chicken1", "chicken2", "chicken3"]
    @State private var showSheet = false
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors:[.pink,.purple,.blue]), startPoint: .top, endPoint: UnitPoint.bottom).ignoresSafeArea()
            
            VStack{
                Text("Face IDecryption")
                    .foregroundColor(.white)
                    .font(.largeTitle.weight(.bold))
                
                Text("Use your face to unlock the images")
                    .foregroundColor(.white)
                
                HStack{
                    ForEach(0..<3){ num in
                        Button{
                            showSheet.toggle()
                        }label: {
                            Image(chickens[num])
                                .renderingMode(.original)
                                .frame(maxWidth: 100, maxHeight: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                        }.sheet(isPresented: $showSheet){
                            ImageView()
                        }
                    }
                }.padding()
            }.padding()
            
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthenticationManager())
    }
}
