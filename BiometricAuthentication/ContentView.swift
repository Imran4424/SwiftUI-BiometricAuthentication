//
//  ContentView.swift
//  BiometricAuthentication
//
//  Created by Shah Md Imran Hossain on 22/6/24.
//

import SwiftUI

struct Home: View {
    @State private var userName = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Spacer(minLength: 0)
            
            Image(systemName: "lock.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
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
            
            HStack {
                Image(systemName: "envelope")
                    .font(.title2)
                    .foregroundStyle(.white)
                TextField("EMAIL", text: $userName)
            }
            .padding()
            .background(Color.white.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal)
            
            HStack {
                Image(systemName: "key.horizontal")
                    .font(.title2)
                    .foregroundStyle(.white)
                TextField("PASSWORD", text: $password)
            }
            .padding()
            .background(Color.white.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal)
            
            
            Spacer(minLength: 0)
        }
        .background(Color.indigo.ignoresSafeArea(.all, edges: .all))
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .toolbar(.hidden)
        }
    }
}

#Preview {
    ContentView()
}
