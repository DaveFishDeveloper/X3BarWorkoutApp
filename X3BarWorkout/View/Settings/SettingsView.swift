//
//  Settings.swift
//  X3BarWorkout
//
//  Created by David Fish on 10/28/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI

struct SettingsView: View {

    var body: some View {
        List {
            NavigationLink(destination: PersonalView()) {
                Text("Profile")
            }
            NavigationLink(destination: ListBandsView()) {
                Text("Bands")
            }
            NavigationLink(destination: ListExercisesView()) {
                Text("Exercises")
            }
            NavigationLink(destination: AdminView()) {
                Text("Admin")
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
