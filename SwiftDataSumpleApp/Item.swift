//
//  Item.swift
//  SwiftDataSumpleApp
//
//  Created by TakahashiKotomi on 2024/01/03.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    var message: String
    var image: String
    
    init(timestamp: Date, message: String, image: String) {
        self.timestamp = timestamp
        self.message = ""
        self.image = ""
    }
}

enum SampleTripsSchemaV1: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [Trip.self, BucketListItem.self, LivingAccommodation.self]
    }

    static var versionIdentifier: String?

    @Model
    final class Trip {
        var name: String
        var destination: String
        var start_date: Date
        var end_date: Date

        var bucketList: [BucketListItem]? = []
        var livingAccommodation: LivingAccommodation?
    }

    // Define the other models in this version...
}
