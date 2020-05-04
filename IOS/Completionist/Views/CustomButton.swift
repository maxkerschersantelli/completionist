//
//  CustomButton.swift
//  Completionist
//
//  Created by Max Kerscher-Santelli on 4/15/20.
//  Copyright © 2020 Max Kerscher-Santelli. All rights reserved.
//

import SwiftUI

// todo:
// add disabled, spinner, dark mode?
struct CustomButton : View {
    var label: String
    var action: () -> Void
    var loading: Bool = false
    
    
    var body: some View {
        
        Button(action: action) {
            HStack {
                Spacer()
                Text(label)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            
            }
            .padding()
            .background(loading ? Color.blue.opacity(0.3) : Color.blue)
            .cornerRadius(5)
    }
}

#if DEBUG
struct CustomButton_Previews : PreviewProvider {
    static var previews: some View {
        CustomButton(label: "Sign in", action: {
            print("hello")
        })
    }
}
#endif
