//
//  CoreDataManager.swift
//  X3BarWorkout
//
//  Created by David Fish on 11/9/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager(moc: NSManagedObjectContext.current)

    var moc: NSManagedObjectContext

    private init(moc: NSManagedObjectContext) {
        self.moc = moc
    }

    private func fetchBand(bandName: String) -> BandsList? {

        var bands = [BandsList]()

        let request: NSFetchRequest<BandsList> = BandsList.fetchRequest()
        request.predicate = NSPredicate(format: "bandName == %@", bandName)

        do {
            bands = try self.moc.fetch(request)
        } catch let error as NSError {
            print(error)
        }

        return bands.first

    }

    func getAllBands() -> [BandsList] {

        var bands = [BandsList]()

        let bandRequest: NSFetchRequest<BandsList> = BandsList.fetchRequest()

        do {
            bands = try self.moc.fetch(bandRequest)
        } catch let error as NSError {
            print(error)
        }

        return bands

    }

    func deleteBand(bandName: String) {

        do {
            if let bands = fetchBand(bandName: bandName) {
                self.moc.delete(bands)
                try self.moc.save()
            }
        } catch let error as NSError {
            print(error)
        }

    }

    func saveBand(bandName: String, bandColor: String, bandMinimumWeight: String, bandMaximumWeight: String) {

        let bands = BandsList(context: self.moc)

        bands.bandName = bandName
        bands.bandColor = bandColor
        bands.bandMinimumWeight = Int16(bandMinimumWeight)!
        bands.bandMaximumWeight = Int16(bandMaximumWeight)!

        do {
            try self.moc.save()
        } catch let error as NSError {
            print(error)
        }

    }
}
