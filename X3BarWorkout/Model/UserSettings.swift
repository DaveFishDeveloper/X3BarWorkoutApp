//
//  UserSettings.swift
//  X3BarWorkout
//
//  Created by David Fish on 10/27/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI
import Combine

class UserSettings: ObservableObject {
    @Published var band: Int = 0
    @Published var fullReps: Int = 10
    @Published var partialReps: Int = 10

    @Published var chestPressLabel = "Chest Press"
    @Published var chestPressRepsFull = 18
    @Published var chestPressRepsPartial = 20
    @Published var chestPressBand = 3
    @Published var chestPressSelected: Bool = true
    @Published var chestPressAdvancedHolds: Bool = false

    @Published var pecCrossoverLabel = "Pec Cross Over"
    @Published var pecCrossoverRepsFull = 20
    @Published var pecCrossoverRepsPartial = 20
    @Published var pecCrossoverBand = 2
    @Published var pecCrossoverSelected: Bool = false
    @Published var pecCrossoverAdvancedHolds: Bool = false

    @Published var overheadPressLabel = "Overhead Press"
    @Published var overheadPressRepsFull = 20
    @Published var overheadPressRepsPartial = 20
    @Published var overheadPressBand = 2
    @Published var overheadPressSelected: Bool = true
    @Published var overheadPressAdvancedHolds: Bool = false

    @Published var uprightRowLabel = "Upright Row"
    @Published var uprightRowRepsFull = 20
    @Published var uprightRowRepsPartial = 20
    @Published var uprightRowBand = 2
    @Published var uprightRowSelected: Bool = false
    @Published var uprightRowAdvancedHolds: Bool = false

    @Published var frontSquatLabel = "Front Squat"
    @Published var frontSquatRepsFull = 20
    @Published var frontSquatRepsPartial = 20
    @Published var frontSquatBand = 2
    @Published var frontSquatSelected: Bool = true
    @Published var frontSquatAdvancedHolds: Bool = false

    @Published var splitSquatLeftLabel = "Left Split Squat"
    @Published var splitSquatLeftRepsFull = 20
    @Published var splitSquatLeftRepsPartial = 20
    @Published var splitSquatLeftBand = 2
    @Published var splitSquatLeftSelected: Bool = false
    @Published var splitSquatLeftAdvancedHolds: Bool = false

    @Published var splitSquatRightLabel = "Right Split Squat"
    @Published var splitSquatRightRepsFull = 20
    @Published var splitSquatRightRepsPartial = 20
    @Published var splitSquatRightBand = 2
    @Published var splitSquatRightSelected: Bool = false
    @Published var splitSquatRightAdvancedHolds: Bool = false

    @Published var tricepPressLabel = "Tricep Press"
    @Published var tricepPressRepsFull = 20
    @Published var tricepPressRepsPartial = 20
    @Published var tricepPressBand = 2
    @Published var tricepPressSelected: Bool = true
    @Published var tricepPressAdvancedHolds: Bool = false

    @Published var deadliftLabel = "Deadlift"
    @Published var deadliftRepsFull = 20
    @Published var deadliftRepsPartial = 20
    @Published var deadliftBand = 2
    @Published var deadliftSelected: Bool = true
    @Published var deadliftAdvancedHolds: Bool = false

    @Published var curlsLabel = "Bicep Curls"
    @Published var curlsRepsFull = 20
    @Published var curlsRepsPartial = 20
    @Published var curlsBand = 2
    @Published var curlsSelected: Bool = true
    @Published var curlsAdvancedHolds: Bool = false

    @Published var bentRowLabel = "Bent Rows"
    @Published var bentRowRepsFull = 20
    @Published var bentRowRepsPartial = 20
    @Published var bentRowBand = 2
    @Published var bentRowSelected: Bool = true
    @Published var bentRowAdvancedHolds: Bool = false

    @Published var calfRaiseLabel = "Calf Raises"
    @Published var calfRaiseRepsFull = 20
    @Published var calfRaiseRepsPartial = 20
    @Published var calfRaiseBand = 2
    @Published var calfRaiseSelected: Bool = true
    @Published var calfRaiseAdvancedHolds: Bool = false

    @Published var shrugsLabel = "Shoulder Shrugs"
    @Published var shrugsRepsFull = 20
    @Published var shrugsRepsPartial = 20
    @Published var shrugsBand = 2
    @Published var shrugsSelected: Bool = false
    @Published var shrugsAdvancedHolds: Bool = false

    @Published var bandPullLabel = "Calf Raises"
    @Published var bandPullRepsFull = 20
    @Published var bandPullRepsPartial = 20
    @Published var bandPullBand = 2
    @Published var bandPullSelected: Bool = false
    @Published var bandPullAdvancedHolds: Bool = false
}
