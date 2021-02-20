//
//  EditLanguagesView.swift
//  X3BarWorkout
//
//  Created by David Fish on 11/29/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI
import CoreData

struct EditLanguagesView: View {

    let lang: Languages

    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    @State private var showingDeleteAlert = false
    @State private var languageCode = ""
    @State private var languageName = ""

    func deleteLanguage() {
        moc.delete(lang)

        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }

    func onAppear() {

        self.languageCode = self.lang.languageCode ?? "Unknown Language Code"
        self.languageName = self.lang.languageName ?? "Unknown Language Name"

    }

    var body: some View {
        //NavigationView {
            Form {
                Section(header: Text("Supported Languages").bold()) {
                    TextField("Language Code", text: $languageCode )
                    TextField("Language Name", text: $languageName)
                }

                Section {
                    Button("Save") {
                        self.lang.languageCode = self.languageCode
                        self.lang.languageName = self.languageName

                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .onAppear(perform: { self.onAppear() })
        //}
        .alert(isPresented: $showingDeleteAlert) {
        Alert(title: Text("Delete language"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                self.deleteLanguage()
                }, secondaryButton: .cancel()
            )
        }
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
            .navigationBarTitle(Text(self.lang.languageName ?? "Unknown Language"), displayMode: .inline)
    }
}

/* struct EditLanguagesView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let languages = Languages(context: moc)
        languages.languageCode = "EN"
        languages.languageName = "English"

        return NavigationView {
            EditLanguagesView(lang: Languages)
        }
    }
} */
