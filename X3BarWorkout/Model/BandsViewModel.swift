//
//  BandsViewModel.swift
//  X3BarWorkout
//
//  Created by David Fish on 11/9/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
import Combine

class BandsListViewModel: ObservableObject {

    @Published
    var bands = [BandsViewModel]()

    init() {
        fetchAllBands()
    }

    func deleteBand(_ bandsVM: BandsViewModel) {
        CoreDataManager.shared.deleteBand(bandName: bandsVM.bandName)
        fetchAllBands()
    }

    func fetchAllBands() {
        self.bands = CoreDataManager.shared.getAllBands().map(BandsViewModel.init)
        print(self.bands)
    }

}

class BandsViewModel {

    var bandName = ""
    var bandColor = ""
    var bandMinimumWeight = "" //0
    var bandMaximumWeight = "" //0

    init(bands: BandsList) {
        self.bandName = bands.bandName!
        self.bandColor = bands.bandColor!
        self.bandMinimumWeight = String(bands.bandMinimumWeight)
        self.bandMaximumWeight = String(bands.bandMaximumWeight)
    }

    var hasBandInfo: Bool {
        if bandName.isEmpty || bandColor.isEmpty {
            return false
        }
        return true
    }

    func saveBand() {

        CoreDataManager.shared.saveBand(bandName: self.bandName, bandColor: self.bandColor, bandMinimumWeight: self.bandMinimumWeight, bandMaximumWeight: self.bandMaximumWeight)
    }
}

class AddBandsViewModel: ObservableObject {

    var bandName = ""
    var bandColor = ""
    var bandMinimumWeight = ""
    var bandMaximumWeight = ""

    var hasBandInfo: Bool {
        if bandName.isEmpty || bandColor.isEmpty {
            return false
        }
        return true
    }

    func saveBand() {
        CoreDataManager.shared.saveBand(bandName: self.bandName, bandColor: self.bandColor, bandMinimumWeight: self.bandMinimumWeight, bandMaximumWeight: self.bandMaximumWeight)
    }
}
