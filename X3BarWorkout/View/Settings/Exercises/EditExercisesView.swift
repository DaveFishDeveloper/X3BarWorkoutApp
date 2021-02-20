//
//  Exercises.swift
//  X3BarWorkout
//
//  Created by David Fish on 10/28/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI
import CoreData

struct EditExercisesView: View {

    let exerciselist: ExercisesList

    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    @State private var name = ""
    @State private var group = ""
    @State private var included = false

    func deleteExercise() {
        moc.delete(exerciselist)

        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }

    func onAppear() {

        self.name = self.exerciselist.name ?? "Unknown Exercise"
        self.group = String(self.exerciselist.group)
        self.included = self.exerciselist.included

    }

    var body: some View {
        //NavigationView {
            Form {
                Section(header: Text("Exercise Name").bold()) {
                    TextField("Name", text: $name )
                }

                Section(header: Text("Group").bold()) {
                    TextField("Group", text: $group)
                }
                Section {
                    Toggle("Include Exercise in Workout List", isOn: $included)
                }

                Section {
                    Button("Save") {
                        self.exerciselist.name = self.name
                        self.exerciselist.group = Int16(self.group) ?? 0
                        self.exerciselist.included = self.included

                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .onAppear(perform: { self.onAppear() })
        //}
        .alert(isPresented: $showingDeleteAlert) {
        Alert(title: Text("Delete exercise"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                self.deleteExercise()
                }, secondaryButton: .cancel()
            )
        }
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
            .navigationBarTitle(Text(self.exerciselist.name ?? "Unknown Exercise"), displayMode: .inline)
    }
}

struct EditExercise_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let exercisesList = ExercisesList(context: moc)
        exercisesList.name = "Test exercise"
        exercisesList.group = 1
        exercisesList.included = true

        return NavigationView {
            EditExercisesView(exerciselist: exercisesList)
        }
    }
}
