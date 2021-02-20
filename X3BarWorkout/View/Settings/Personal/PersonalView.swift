//
//  Personal.swift
//  X3BarWorkout
//
//  Created by David Fish on 10/28/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI
import CoreData

struct PersonalView: View {

    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    @FetchRequest(entity: Languages.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Languages.languageName, ascending: true)]) var languages: FetchedResults<Languages>

    @FetchRequest(entity: PersonalInfo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \PersonalInfo.lastName, ascending: true)]) var personal: FetchedResults<PersonalInfo>

    @State private var showingDeleteAlert = false

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var age = Int16(30)
    @State private var gender = ""
    @State private var weight = ""
    @State private var height = Int16(72)
    @State private var email = ""
    @State private var measurementSystem = false
    @State private var language = "EN"

    func onAppear() {
        if !personal.isEmpty {

            let somePerson = personal.first
            self.firstName = somePerson?.firstName ?? "Unknown First Name"
            self.lastName = somePerson?.lastName ?? "Unknown Last Name"
            self.age = somePerson?.age ?? 30
            self.gender = somePerson?.gender ?? "Unknown Gender"

            let sWeight = somePerson?.weight ?? 150
            self.weight = String(sWeight)

            self.height = somePerson?.height ?? 72
            self.email = somePerson?.email ?? "Unknown Email Address"
            self.measurementSystem = somePerson?.measurementSystem ?? false
            self.language = somePerson?.language ?? "EN"
        }
    }

    var body: some View {
        Form {
            Section(header: Text("Name").bold()) {
                TextField("First Name", text: $firstName )
                TextField("Last Name", text: $lastName)
                TextField("Email Address", text: $email)
                    .autocapitalization(.none)
            }

            Section(header: Text("Details").bold()) {

                Picker("Gender", selection: self.$gender) {
                    Text("Female")
                        .bold()
                        .tag("Female")
                    Text("Male")
                        .bold()
                        .tag("Male")
                    Text("Other")
                        .bold()
                        .tag("Other")
                }
                .pickerStyle(SegmentedPickerStyle())

                Stepper(value: $age) {
                    Text("Age: \(age)")
                }.padding(.horizontal)

                Stepper(value: $height) {
                    Text("Height (Inches): \(height)")
                }.padding(.horizontal)

                HStack {
                    Text("Weight:")
                        .padding()
                    TextField("Weight (pounds):", text: $weight)
                        .keyboardType(.decimalPad)
                }
            }
            Section {
                HStack(alignment: .center, spacing: 105, content: {
                    Text("Imperial")
                    Toggle("", isOn: $measurementSystem)
                    Text("Metric")
                })
            }
            Section(header: Text("Language").bold()) {
                Picker("Language", selection: self.$language) {
                    ForEach(languages, id: \.self) { lang in
                        Text(lang.languageName ?? "Unknown Language")
                            .bold()
                            .tag(lang.languageCode ?? "EN")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            Section {
                Button("Save") {
                    if !self.personal.isEmpty {
                        let existingpersonal = self.personal.first
                        existingpersonal?.firstName = self.firstName
                        existingpersonal?.lastName = self.lastName
                        existingpersonal?.email = self.email
                        existingpersonal?.age = self.age
                        existingpersonal?.gender = self.gender
                        existingpersonal?.height = self.height
                        existingpersonal?.weight = Double(self.weight) ?? 150
                        existingpersonal?.measurementSystem = self.measurementSystem
                        existingpersonal?.language = self.language

                    } else {
                        let newpersonal = PersonalInfo(context: self.moc)
                        newpersonal.firstName = self.firstName
                        newpersonal.lastName = self.lastName
                        newpersonal.email = self.email
                        newpersonal.age = Int16(self.age)
                        newpersonal.gender = self.gender
                        newpersonal.height = self.height
                        newpersonal.weight = Double(self.weight) ?? 150
                        newpersonal.measurementSystem = self.measurementSystem
                        newpersonal.language = self.language
                    }

                    try? self.moc.save()
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .onAppear(perform: { self.onAppear() })
        .navigationBarTitle(Text("Profile Information"), displayMode: .inline)
    }
}

/* struct PersonalView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        //let personalDetails = PersonalInfo(context: moc)
        personalDetails.firstName = "Test First"
        personalDetails.lastName = "Test Last"
        personalDetails.age = 50
        personalDetails.gender = "Male"
        personalDetails.weight = 189.6
        personalDetails.height = 72
        personalDetails.email = "dave@davidefish.com"
        personalDetails.language = "EN"

        return NavigationView {
            PersonalView()
        }
    }
} */
