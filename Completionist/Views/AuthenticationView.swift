//
//  AuthenticationView.swift
//  Completionist
//
//  Created by Max Kerscher-Santelli on 4/15/20.
//  Copyright © 2020 Max Kerscher-Santelli. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    
    //MARK: Properties
    @State var email: String = ""
    @State var password: String = ""
    
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Sign In")
            TextField("Email", text: $email)
            
            SecureField("Password", text: $password)
            Button(action: signIn) {
                Text("Sign In")
            }
            .padding()
            NavigationLink(destination: SignUp()) {
                Text("Sign Up")
            }
        }
    .padding()
    }
    
    //MARK: Functions
    func signIn() {
        session.signIn(email: email, password: password) { (result, error) in
            if error != nil {
                print("Error")
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

struct AuthenticationScreen : View {
    
    var body : some View {
        NavigationView {
            SignInView()
        }
    }
}


#if DEBUG
struct Authenticate_Previews : PreviewProvider {
    static var previews: some View {
        AuthenticationScreen()
            .environmentObject(SessionStore())
    }
}
#endif

