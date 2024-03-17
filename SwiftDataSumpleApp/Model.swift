//
//  Model.swift
//  SwiftDataSumpleApp
//
//  Created by TakahashiKotomi on 2024/01/03.
//

import Foundation
import SwiftData

@Model
final class Message {
    @Attribute let massageID = UUID()
    var message: String
    var image: String?
    
    init(message: String) {
        self.message = message
    }
    
}
