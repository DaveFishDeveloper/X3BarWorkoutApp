//
//  History.swift
//  X3BarWorkout
//
//  Created by David Fish on 10/28/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI

struct History: View {

    var body: some View {
        List {
            NavigationLink(destination: PersonalView()) {
                Text("Personal Details")
            }
            NavigationLink(destination: ListBandsView()) {
                Text("Bands")
            }
            NavigationLink(destination: ListExercisesView()) {
                Text("Exercises")
            }
        }
    }
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History()
    }
}
