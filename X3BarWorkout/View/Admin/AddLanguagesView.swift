//
//  AddLanguagesView.swift
//  X3BarWorkout
//
//  Created by David Fish on 11/29/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI

struct AddLanguagesView: View {

    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    @State private var languageCode = ""
    @State private var languageName = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Language").bold()) {
                    TextField("Language Code", text: $languageCode)
                    TextField("Language Name", text: $languageName)
                }

                Section {
                    Button("Add Language") {
                        let newLanguage = Languages(context: self.moc)
                        newLanguage.languageCode = self.languageCode
                        newLanguage.languageName = self.languageName

                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Language", displayMode: .inline)
        }
    }
}

struct AddLanguagesView_Previews: PreviewProvider {
    static var previews: some View {
        AddLanguagesView()
    }
}
