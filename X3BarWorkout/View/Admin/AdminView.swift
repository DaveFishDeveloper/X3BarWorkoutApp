//
//  AdminView.swift
//  X3BarWorkout
//
//  Created by David Fish on 11/29/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI

struct AdminView: View {

    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    @FetchRequest(entity: Languages.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Languages.languageName, ascending: true)]) var language: FetchedResults<Languages>

    @State private var showingAddScreen = false

    func deleteLanguage(at offsets: IndexSet) {
        for offset in offsets {
            // find this language in our fetch request
            let lang = language[offset]

            //delete it from the context
            moc.delete(lang)
        }

        // save the context
        try? moc.save()
    }

    var body: some View {
        NavigationView {
                List {
                    ForEach(language, id: \.self) { lang in
                        NavigationLink(destination: EditLanguagesView(lang: lang)) {
                            Text(lang.languageName ?? "Unknown")
                                .bold()
                        }
                    }
                    //.onDelete(perform: deleteLanguage)
                }
                .navigationBarTitle("Languages", displayMode: .inline)
                .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                    self.showingAddScreen.toggle()
                }) {
                    Image(systemName: "plus")
                })
                    .sheet(isPresented: $showingAddScreen) {
                        AddLanguagesView().environment(\.managedObjectContext, self.moc)
                }
                Spacer()
            }
        }
    }
//}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
