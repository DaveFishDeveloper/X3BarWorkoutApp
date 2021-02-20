//
//  NavStyle.swift
//  X3BarWorkout
//
//  Created by David Fish on 10/27/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI

struct MyNavStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding().foregroundColor(Color.white)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(10)
            .frame(width: 300, height: 30, alignment: .center)
    }
}

extension View {
    func myNavStyle() -> some View {
        self.modifier(MyNavStyle())
    }
}
