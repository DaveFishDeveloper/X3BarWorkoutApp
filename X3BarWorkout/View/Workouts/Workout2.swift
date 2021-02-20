//
//  Workout2.swift
//  X3BarWorkout
//
//  Created by David Fish on 10/27/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI

struct Workout2: View {
    @ObservedObject var settings = UserSettings()

    let exercises = ["Deadlift", "Bicep Curl", "Bent Row", "Calf Raise", "Shoulder Shrugs", "Band Pull Aparts"]

    //@State private var isSelected = [true,true,true,false,false,true]

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Toggle(exercises[0], isOn: $settings.deadliftSelected)
                        .padding()
                    Toggle(exercises[1], isOn: $settings.curlsSelected)
                        .padding()
                    Toggle(exercises[2], isOn: $settings.bentRowSelected)
                        .padding()
                    Toggle(exercises[3], isOn: $settings.calfRaiseSelected)
                        .padding()
                    Toggle(exercises[4], isOn: $settings.shrugsSelected)
                    .padding()
                    Toggle(exercises[5], isOn: $settings.bandPullSelected)
                    .padding()

                    Spacer()
                    NavigationLink(destination: Workout2Detail(settings: settings)
                        .environmentObject(settings)) {
                        Text("Let's Workout!")
                            .myNavStyle()
                    }
                    Spacer()
                }
            }
            .navigationBarTitle(Text("Workout 2 (Pull) Exercises"), displayMode:
                .inline)
        }
    }
}

struct Workout2_Previews: PreviewProvider {
    static var previews: some View {
        Workout2()
    }
}
