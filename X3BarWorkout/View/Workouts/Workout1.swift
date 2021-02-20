//
//  Workout1.swift
//  X3BarWorkout
//
//  Created by David Fish on 10/27/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI

struct Workout1: View {

    @ObservedObject var settings = UserSettings()

    let exercises = ["Chest Press", "Pec Crossover", "Overhead Press", "Upright Row", "Front Squat", "Left Split Squat", "Right Split Squat", "Tricep Press"]

    //@State private var isSelected = [true,false,true,false,true,false,false,true]

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Section {
                        Toggle(exercises[0], isOn: $settings.chestPressSelected)
                            .padding()
                        Toggle(exercises[1], isOn: $settings.pecCrossoverSelected)
                            .padding()
                        Toggle(exercises[2], isOn: $settings.overheadPressSelected)
                            .padding()
                        Toggle(exercises[3], isOn: $settings.uprightRowSelected)
                            .padding()
                        Toggle(exercises[4], isOn: $settings.frontSquatSelected)
                            .padding()
                    }
                    Section {
                        Toggle(exercises[5], isOn: $settings.splitSquatLeftSelected)
                            .padding()
                        Toggle(exercises[6], isOn: $settings.splitSquatRightSelected)
                            .padding()
                        Toggle(exercises[7], isOn: $settings.tricepPressSelected)
                            .padding()
                        Spacer()

                        NavigationLink(destination: Workout1Detail(settings: settings)
                            .environmentObject(settings)) {
                            Text("Let's Workout!")
                                .myNavStyle()
                        }
                        Spacer()
                    }
                }
                .navigationBarTitle(Text("Workout 1 (Push) Exercises"), displayMode:
                    .inline)
            }
        }
    }
}

struct Workout1_Previews: PreviewProvider {
    static var previews: some View {
        Workout1()
    }
}
