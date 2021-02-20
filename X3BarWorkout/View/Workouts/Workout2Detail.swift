//
//  Workout2Detail.swift
//  X3BarWorkout
//
//  Created by David Fish on 10/23/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI

struct Workout2Detail: View {
    @ObservedObject var settings = UserSettings()

    let bands = ["White", "Light Gray", "Dark Gray", "Black", "Elite"]

    var body: some View {
            Form {
                if settings.deadliftSelected {
                    CustomPicker(sectionText: $settings.deadliftLabel, band: $settings.deadliftBand, fullReps: $settings.deadliftRepsFull, partialReps: $settings.deadliftRepsPartial, advancedHolds: $settings.deadliftAdvancedHolds)
                }
                if settings.curlsSelected {
                    CustomPicker(sectionText: $settings.curlsLabel, band: $settings.curlsBand, fullReps: $settings.curlsRepsFull, partialReps: $settings.curlsRepsPartial, advancedHolds: $settings.curlsAdvancedHolds)
                }
                if settings.bentRowSelected {
                    CustomPicker(sectionText: $settings.bentRowLabel, band: $settings.bentRowBand, fullReps: $settings.bentRowRepsFull, partialReps: $settings.bentRowRepsPartial, advancedHolds: $settings.bentRowAdvancedHolds)
                }
                if settings.calfRaiseSelected {
                    CustomPicker(sectionText: $settings.calfRaiseLabel, band: $settings.calfRaiseBand, fullReps: $settings.calfRaiseRepsFull, partialReps: $settings.calfRaiseRepsPartial, advancedHolds: $settings.calfRaiseAdvancedHolds)
                }
                if settings.shrugsSelected {
                    CustomPicker(sectionText: $settings.shrugsLabel, band: $settings.shrugsBand, fullReps: $settings.shrugsRepsFull, partialReps: $settings.shrugsRepsPartial, advancedHolds: $settings.shrugsAdvancedHolds)
                }
                if settings.bandPullSelected {
                    CustomPicker(sectionText: $settings.bandPullLabel, band: $settings.bandPullBand, fullReps: $settings.bandPullRepsFull, partialReps: $settings.bandPullRepsPartial, advancedHolds: $settings.bandPullAdvancedHolds)
                }
                Spacer()

            } //Form

    } //Some View

} //View

struct Workout2Detail_Previews: PreviewProvider {
    static var previews: some View {
        //let userSettings = UserSettings()
        Workout1Detail()
    }
}
