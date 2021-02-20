//
//  AddExerciseView.swift
//  X3BarWorkout
//
//  Created by David Fish on 11/24/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI

struct AddExerciseView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    @State private var name = ""
    @State private var group = ""
    @State private var included = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise Name").bold()) {
                    TextField("Name", text: $name)
                    TextField("Exercise Group", text: $group)
                }

                Section {
                    Toggle("Include Exercise in Workout List", isOn: $included)
                }

                Section {
                    Button("Add Exercise") {
                        let newExercise = ExercisesList(context: self.moc)
                        newExercise.name = self.name
                        newExercise.group = Int16(self.group) ?? 1
                        newExercise.included = self.included

                        try? self.moc.save()
                        print(newExercise.name ?? "Unknown")
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Exercise", displayMode: .inline)
        }
    }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseView()
    }
}
