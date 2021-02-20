//
//  Workout1Detail.swift
//  X3BarWorkout
//
//  Created by David Fish on 10/23/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI

struct Workout1Detail: View {
    @ObservedObject var settings = UserSettings()

    let bands = ["White", "Light Gray", "Dark Gray", "Black", "Elite"]

    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: BandsList.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \BandsList.bandMinimumWeight, ascending: true)],
        predicate: NSPredicate(format: "bandIncluded == %@", NSNumber(booleanLiteral: true))) var bandsList: FetchedResults<BandsList>

    var body: some View {
        Form {

            if settings.chestPressSelected {
                CustomPicker(sectionText: $settings.chestPressLabel, band: $settings.chestPressBand, fullReps: $settings.chestPressRepsFull, partialReps: $settings.chestPressRepsPartial, advancedHolds: $settings.chestPressAdvancedHolds)
            }
            if settings.pecCrossoverSelected {
                CustomPicker(sectionText: $settings.pecCrossoverLabel, band: $settings.pecCrossoverBand, fullReps: $settings.pecCrossoverRepsFull, partialReps: $settings.pecCrossoverRepsPartial, advancedHolds: $settings.pecCrossoverAdvancedHolds)
            }
            if settings.overheadPressSelected {
                CustomPicker(sectionText: $settings.overheadPressLabel, band: $settings.overheadPressBand, fullReps: $settings.overheadPressRepsFull, partialReps: $settings.overheadPressRepsPartial, advancedHolds: $settings.overheadPressAdvancedHolds)
            }
            if settings.uprightRowSelected {
                CustomPicker(sectionText: $settings.uprightRowLabel, band: $settings.uprightRowBand, fullReps: $settings.uprightRowRepsFull, partialReps: $settings.uprightRowRepsPartial, advancedHolds: $settings.uprightRowAdvancedHolds)
            }
            if settings.frontSquatSelected {
                CustomPicker(sectionText: $settings.frontSquatLabel, band: $settings.frontSquatBand, fullReps: $settings.frontSquatRepsFull, partialReps: $settings.frontSquatRepsPartial, advancedHolds: $settings.frontSquatAdvancedHolds)
            }
            if settings.splitSquatLeftSelected {
                CustomPicker(sectionText: $settings.splitSquatLeftLabel, band: $settings.splitSquatLeftBand, fullReps: $settings.splitSquatLeftRepsFull, partialReps: $settings.splitSquatLeftRepsPartial, advancedHolds: $settings.splitSquatLeftAdvancedHolds)
            }
            if settings.splitSquatRightSelected {
                CustomPicker(sectionText: $settings.splitSquatRightLabel, band: $settings.splitSquatRightBand, fullReps: $settings.splitSquatRightRepsFull, partialReps: $settings.splitSquatRightRepsPartial, advancedHolds: $settings.splitSquatRightAdvancedHolds)
            }
            if settings.tricepPressSelected {
                CustomPicker(sectionText: $settings.tricepPressLabel, band: $settings.tricepPressBand, fullReps: $settings.tricepPressRepsFull, partialReps: $settings.tricepPressRepsPartial, advancedHolds: $settings.tricepPressAdvancedHolds)
            }
            Spacer()
        } //Form
    } //Some View
} //View

struct Workout1Detail_Previews: PreviewProvider {
    static var previews: some View {
        //let userSettings = UserSettings()
        Workout1Detail()
    }
}
