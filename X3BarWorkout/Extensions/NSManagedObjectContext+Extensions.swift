//
//  NSManagedObjectContext+Extensions.swift
//  X3BarWorkout
//
//  Created by David Fish on 11/9/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension NSManagedObjectContext {

    static var current: NSManagedObjectContext {
        // swiftlint:disable force_cast
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // swiftlint:enable force_cast
        return appDelegate.persistentContainer.viewContext
    }
}
