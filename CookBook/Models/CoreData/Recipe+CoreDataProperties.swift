//  Recipe+CoreDataProperties.swift
//  CookBook
//  Created by Satyajit Bhol on 31/07/25.

import Foundation
import CoreData
import UIKit

extension Recipe {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var name: String?
    @NSManaged public var instruction: String?
    @NSManaged public var preparationTime: Int16
    @NSManaged public var imageData: Data?
}
