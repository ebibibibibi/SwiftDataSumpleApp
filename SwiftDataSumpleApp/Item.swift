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
//    var message: String
//    var image: String
    
    init(timestamp: Date) {
        self.timestamp = timestamp
//        self.message = ""
//        self.image = ""
    }
}
