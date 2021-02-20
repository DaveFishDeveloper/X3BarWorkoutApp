//
//  CustomPicker.swift
//  X3BarWorkout
//
//  Created by David Fish on 10/27/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI

struct CustomPicker: View {
    //@ObservedObject private var settings = UserSettings()

    @Binding var sectionText: String
    @Binding var band: Int
    @Binding var fullReps: Int
    @Binding var partialReps: Int
    @Binding var advancedHolds: Bool
    //@Binding var bl: BandsList

    let bands = ["White", "Light Gray", "Dark Gray", "Black", "Elite"]

    var body: some View {

        /* Section {
        Picker("Band2", selection: self.$band) {
            ForEach(bl, id: \.self) { bandList in
                Text(bl.bandName ?? "Unknown")
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        } */

        Section(header: Text(sectionText)
            .bold()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .foregroundColor(.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing))
        ) {
            Picker("Band", selection: self.$band) {
                //ForEach(bands, id: \.self) { xband in
                //    Text(xband)
                ForEach(0 ..< bands.count) { index in
                    Text(self.bands[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .foregroundColor(.white)
            //.background(Color("AccentColorDark"))

            HStack {
                Stepper(value: self.$fullReps) {
                    Text("Full Reps: \(fullReps)").frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                }
                Stepper(value: self.$partialReps) {
                    Text("Partial Reps: \(partialReps)").frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                }
            }
            HStack {
                Toggle("Advanced Hold", isOn: self.$advancedHolds)
                .padding()
            }
        }
    }
}

/* struct CustomPicker_Previews: PreviewProvider {
 static var previews: some View {
 CustomPicker()
 }
 } */
