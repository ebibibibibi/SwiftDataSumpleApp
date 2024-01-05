//
//  Item.swift
//  SwiftDataSumpleApp
//
//  Created by TakahashiKotomi on 2024/01/03.
//

import Foundation
import SwiftData

//@Model
//final class Item {
//    var timestamp: Date
//
//    init(timestamp: Date) {
//        self.timestamp = timestamp
//    }
//}
struct ItemSchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Item.self]
    }
    @Model
    final class Item {
        var timestamp: Date
        init(timestamp: Date) {
            self.timestamp = timestamp
        }
    }
}


struct ItemSchemaV2: VersionedSchema {
    static var versionIdentifier = Schema.Version(2, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Item.self]
    }
    @Model
    final class Item {
        @Attribute(.unique) var timestamp: Date
        //        var message: String
        //        var image: String
        init(timestamp: Date) {
            self.timestamp = timestamp
        }
        //        init(timestamp: Date, message: String, image: String) {
        //            self.timestamp = timestamp
        //            self.message = message
        //            self.image = image
        //        }
    }
}

struct ItemSchemaV3: VersionedSchema {
    static var versionIdentifier = Schema.Version(3, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Item.self]
    }
    @Model
    final class Item {
        @Attribute(.unique) var timestamp: Date
        var message: String = ""
        var image: String = ""
        init(timestamp: Date, message: String = "", image: String = "") {
            self.timestamp = timestamp
            self.message = message
            self.image = image
        }
    }
}


// Itemが常に最新バージョンを指すように型エイリアスを追加する
typealias Item = ItemSchemaV3.Item

// マイグレーションプランを作成する。
// 一つの特定のバージョンから別のバージョンに移動する方法を定義する
//
enum ItemMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        // バージョンの順番に配置することで、SwiftDataが順序正しくバージョン間を移行できるようにする
//        [ItemSchemaV1.self, ItemSchemaV2.self]
        [ItemSchemaV1.self, ItemSchemaV2.self, ItemSchemaV3.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2, migrateV2toV3]
    }
    static let migrateV1toV2 = MigrationStage.lightweight(
        fromVersion: ItemSchemaV1.self,
        toVersion: ItemSchemaV2.self
    )
    static let migrateV2toV3 = MigrationStage.custom(
        
        fromVersion: ItemSchemaV2.self,
        toVersion: ItemSchemaV3.self,
        willMigrate: nil
    )
    { context in
        let items = try? context.fetch(FetchDescriptor<ItemSchemaV3.Item>())
        
        items?.forEach { item in
            item.message = "🍓"
            item.image = ""
        }
        
        try? context.save()
    }
    //    // これまでに定義した2つのバージョン付きスキーマの配列を追加する。
    //    static let migrateV1toV2 = MigrationStage.custom(
    //        fromVersion: ItemSchemaV1.self,
    //        toVersion: ItemSchemaV2.self,
    //        willMigrate: nil
    //    ) { context in
    //        let items = try? context.fetch(FetchDescriptor<ItemSchemaV2.Item>())
    //        items?.forEach { item in
    //            item.message = ""
    //            item.image = ""
    //        }
    //        try context.save()
    //    }
}
