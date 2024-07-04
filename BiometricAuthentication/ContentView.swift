//
//  ContentView.swift
//  BiometricAuthentication
//
//  Created by Shah Md Imran Hossain on 22/6/24.
//

import LocalAuthentication
import SwiftUI

struct Home: View {
    @State private var userName = ""
    @State private var password = ""
    
    @AppStorage("storedUser") var user = "shahcodersden@gmail.com"
    @AppStorage("status") var logged = false
    
    var body: some View {
        VStack {
            Spacer(minLength: 0)
            
            Image(systemName: "lock")
                .resizable()
                .aspectRatio(contentMode: .fit)
            // dynamic frame
                .padding(.horizontal, 35)
                .frame(width: 250)
            
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Login")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    Text("Please sign in to continue")
                        .foregroundStyle(.white.opacity(0.5))
                }
                
                Spacer(minLength: 0)
            }
            .padding()
            .padding(.leading, 15)
            
            HStack {
                Image(systemName: "envelope")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .frame(width: 35)
                
                TextField("EMAIL", text: $userName)
                    .textInputAutocapitalization(.none)
            }
            .padding()
            .background(Color.white.opacity(userName == "" ? 0 : 0.12))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal)
            
            HStack {
                Image(systemName: "key.horizontal")
                    .font(.title2)
                    .foregroundStyle(.white)
                
                SecureField("PASSWORD", text: $password)
                    .textInputAutocapitalization(.none)
            }
            .padding()
            .background(Color.white.opacity(password == "" ? 0 : 0.12))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal)
            .padding(.top)
            
            HStack(spacing: 15) {
                Button {
                    
                } label: {
                    Text("LOGIN")
                        .fontWeight(.heavy)
                        .foregroundStyle(.black)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 150) // need to replace
                        .background(Color.green.opacity(0.75))
                        .clipShape(Capsule())
                }
                .padding(.top)
//                .opacity(userName != "" && password != "" ? 1 : 0)
                .disabled(userName != "" && password != "" ? false : true)
                
                if getBioMetricStatus() {
                    Button {
                        authenticateUser()
                    } label: {
                        Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                            .font(.title)
                            .foregroundStyle(Color.black)
                            .padding()
                            .background(Color.green)
                            .clipShape(Circle())
                    }

                }
            }
            
            // forget button
            
            Button {
                
            } label: {
                Text("Forget password?")
                    .foregroundStyle(Color.green)
            }
            
            Spacer(minLength: 0)
            
            // signup
            
            HStack(spacing: 5) {
                Text("Don't have an account?")
                    .foregroundStyle(Color.white.opacity(0.6))
                
                Button {
                    
                } label: {
                    Text("Signup")
                        .fontWeight(.heavy)
                        .foregroundStyle(Color.green)
                }
                
            }
            .padding(.vertical)
        }
        .background(Color.gray.ignoresSafeArea(.all, edges: .all))
    }
}

// MARK: - Methods
extension Home {
    // getting biometric type
    func getBioMetricStatus() -> Bool {
        let scanner = LAContext()
        
        if userName == user && scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none) {
            return true
        }
        
        return false
    }
    
    func authenticateUser() {
        let scanner = LAContext()
        
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To Unlock \(userName)") { status, error in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            withAnimation(.easeOut) {
                logged = true
            }
        }
    }
}

struct ContentView: View {
    @AppStorage("status") var logged = false
    
    var body: some View {
        NavigationStack {
            
            if logged {
                Text("User logged In....")
                    .navigationTitle("Home")
                    .preferredColorScheme(.light)
            } else {
                withAnimation(.easeInOut(duration: 0.3)) {
                    Home()
                        .toolbar(.hidden)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
