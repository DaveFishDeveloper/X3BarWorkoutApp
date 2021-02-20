//
//  Bands.swift
//  X3BarWorkout
//
//  Created by David Fish on 10/28/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI

struct ListBandsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: BandsList.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \BandsList.bandMinimumWeight, ascending: true)]) var bandsList: FetchedResults<BandsList>

    @State private var showingAddScreen = false

    func image(bandIncluded: Bool) -> Image {
        if bandIncluded {
            return Image(systemName: "flag.fill")
        }
        return Image(systemName: "flag.slash")
    }

    func deleteBands(at offsets: IndexSet) {
        for offset in offsets {
            // find this band in our fetch request
            let band = bandsList[offset]

            // delete it from the context
            moc.delete(band)
        }

        // save the context
        try? moc.save()
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(bandsList, id: \.self) { bandList in
                    NavigationLink(destination: EditBandsView(bandlist: bandList)) {
                        self.image(bandIncluded: bandList.bandIncluded)
                            .foregroundColor(bandList.bandIncluded ? Color.green : Color.gray)
                        Color(UIColor(name: bandList.bandColor?.lowercased() ?? "Unknown") ?? .white)
                            .border(Color.black)
                            .frame(width: 60, height: 20)
                        Text(bandList.bandName ?? "Unknown")
                            .bold()
                    }
                }
                .onDelete(perform: deleteBands)
            }
            .navigationBarTitle("Bands", displayMode: .inline)
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showingAddScreen.toggle()
            }) {
                Image(systemName: "plus")
            })
                .sheet(isPresented: $showingAddScreen) {
                    AddBandsView().environment(\.managedObjectContext, self.moc)
            }
            Spacer()
        }
    }
}

struct Bands_Previews: PreviewProvider {
    static var previews: some View {
        ListBandsView()
    }
}
