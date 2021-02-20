//
//  ListExercisesView.swift
//  X3BarWorkout
//
//  Created by David Fish on 11/24/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI

struct ListExercisesView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: ExercisesList.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExercisesList.name, ascending: true)]) var exList: FetchedResults<ExercisesList>

    @State private var showingAddScreen = false

    func image(exerciseIncluded: Bool) -> Image {
        if exerciseIncluded {
            return Image(systemName: "flag.fill")
        }
        return Image(systemName: "flag.slash")
    }

    func deleteExercise(at offsets: IndexSet) {
        for offset in offsets {
            // find this exercise in our fetch request
            let exercise = exList[offset]

            // delete it from the context
            moc.delete(exercise)
        }

        // save the context
        try? moc.save()
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(exList, id: \.self) { exerciseList in
                    NavigationLink(destination: EditExercisesView(exerciselist: exerciseList)) {
                        self.image(exerciseIncluded: exerciseList.included)
                            .foregroundColor(exerciseList.included ? Color.green : Color.gray)
                        Text(exerciseList.name ?? "Unknown")
                            .bold()
                    }
                }
                .onDelete(perform: deleteExercise)
            }
            .navigationBarTitle("Exercises", displayMode: .inline)
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showingAddScreen.toggle()
            }) {
                Image(systemName: "plus")
            })
                .sheet(isPresented: $showingAddScreen) {
                    AddExerciseView().environment(\.managedObjectContext, self.moc)
            }
            Spacer()
        }
    }
}

struct ListExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ListExercisesView()
    }
}
