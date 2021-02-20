//
//  AddBandsView.swift
//  X3BarWorkout
//
//  Created by David Fish on 11/16/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI

struct AddBandsView: View {

    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    @State private var bandName = ""
    @State private var bandColor = ""
    @State private var bandMinimumWeight = ""
    @State private var bandMaximumWeight = ""
    @State private var bandIncluded = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Band Name and Color").bold()) {
                    TextField("Band Name", text: $bandName)
                    TextField("Band Color", text: $bandColor)
                }

                Section(header: Text("Band Resistance (in lbs)").bold()) {
                    TextField("Minimum Weight", text: $bandMinimumWeight)
                    TextField("Maximum Weight", text: $bandMaximumWeight)
                }

                Section {
                    Toggle("Include Band in Workout List", isOn: $bandIncluded)
                }

                Section {
                    Button("Add Band") {
                        let newBand = BandsList(context: self.moc)
                        newBand.bandName = self.bandName
                        newBand.bandColor = self.bandColor
                        newBand.bandMinimumWeight = Int16(self.bandMinimumWeight) ?? 0
                        newBand.bandMaximumWeight = Int16(self.bandMaximumWeight) ?? 0
                        newBand.bandIncluded = self.bandIncluded

                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Band", displayMode: .inline)
        }
    }
}

struct AddBandsView_Previews: PreviewProvider {
    static var previews: some View {
        AddBandsView()
    }
}
