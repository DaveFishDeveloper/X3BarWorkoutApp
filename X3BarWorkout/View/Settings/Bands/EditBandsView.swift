//
//  EditBandsView.swift
//  X3BarWorkout
//
//  Created by David Fish on 11/16/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI
import CoreData

struct EditBandsView: View {

    let bandlist: BandsList

    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    @State private var bandName = ""
    @State private var bandColor = ""
    @State private var bandMinimumWeight = ""
    @State private var bandMaximumWeight = ""
    @State private var bandIncluded = false

    func deleteBand() {
        moc.delete(bandlist)

        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }

    func onAppear() {

        self.bandName = self.bandlist.bandName ?? "Unknown Band"
        self.bandColor = self.bandlist.bandColor ?? "Unknown Color"
        self.bandMinimumWeight = String(self.bandlist.bandMinimumWeight)
        self.bandMaximumWeight = String(self.bandlist.bandMaximumWeight)
        self.bandIncluded = self.bandlist.bandIncluded

    }

    var body: some View {
        //NavigationView {
            Form {
                Section(header: Text("Band Name and Color").bold()) {
                    TextField("Band Name", text: $bandName )
                    TextField("Band Color", text: $bandColor)
                }

                Section(header: Text("Band Resistance (in lbs)").bold()) {
                    TextField("Minimum Weight (in lbs)", text: $bandMinimumWeight)
                    TextField("Maximum Weight (in lbs)", text: $bandMaximumWeight)
                }
                Section {
                    Toggle("Include Band in Workout List", isOn: $bandIncluded)
                }

                Section {
                    Button("Save") {
                        self.bandlist.bandName = self.bandName
                        self.bandlist.bandColor = self.bandColor
                        self.bandlist.bandMinimumWeight = Int16(self.bandMinimumWeight) ?? 0
                        self.bandlist.bandMaximumWeight = Int16(self.bandMaximumWeight) ?? 0
                        self.bandlist.bandIncluded = self.bandIncluded

                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .onAppear(perform: { self.onAppear() })
        //}
        .alert(isPresented: $showingDeleteAlert) {
        Alert(title: Text("Delete band"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                self.deleteBand()
                }, secondaryButton: .cancel()
            )
        }
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
            .navigationBarTitle(Text(self.bandlist.bandName ?? "Unknown Band"), displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let bandsList = BandsList(context: moc)
        bandsList.bandName = "Test band"
        bandsList.bandColor = "Test color"
        bandsList.bandMinimumWeight = 0
        bandsList.bandMaximumWeight = 0

        return NavigationView {
            EditBandsView(bandlist: bandsList)
        }
    }
}
