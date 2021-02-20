//
//  Reports.swift
//  X3BarWorkout
//
//  Created by David Fish on 10/28/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI

struct Reports: View {

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

struct Reports_Previews: PreviewProvider {
    static var previews: some View {
        Reports()
    }
}
