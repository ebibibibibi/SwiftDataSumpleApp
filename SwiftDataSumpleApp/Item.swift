//
//  Item.swift
//  SwiftDataSumpleApp
//
//  Created by TakahashiKotomi on 2024/01/03.
//

import Foundation
import SwiftData

enum ItemSchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Item.self]
    }
}
extension ItemSchemaV1 {
    @Model
    final class Item {
        var timestamp: Date
        init(timestamp: Date) {
            self.timestamp = timestamp
        }
    }
}

enum ItemSchemaV2: VersionedSchema {
    static var versionIdentifier = Schema.Version(2, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Item.self]
    }
}
extension ItemSchemaV2 {
    @Model
    final class Item {
        var timestamp: Date
        var message: String
        var image: String
        
        init(timestamp: Date, message: String, image: String) {
            self.timestamp = timestamp
            self.message = message
            self.image = image
        }
    }
}

// Itemが常に最新バージョンを指すように型エイリアスを追加する
typealias Item = ItemSchemaV1.Item

// マイグレーションプランを作成する。
// 一つの特定のバージョンから別のバージョンに移動する方法を定義する
//
enum ItemMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        // バージョンの順番に配置することで、SwiftDataが順序正しくバージョン間を移行できるようにする
        [ItemSchemaV1.self, ItemSchemaV2.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
    
    // これまでに定義した2つのバージョン付きスキーマの配列を追加する。
    static let migrateV1toV2 = MigrationStage.custom(
        fromVersion: ItemSchemaV1.self,
        toVersion: ItemSchemaV2.self,
        willMigrate: { context in
            print("migrateV1toV2.willMigrate()")
        },
        didMigrate: {
            context in
            let oldItems = try context.fetch(FetchDescriptor<ItemSchemaV1.Item>())
            for oldItem in oldItems {
                let newItem = ItemSchemaV2.Item(timestamp: oldItem.timestamp, message: "", image: "")
                context.insert(newItem)
            }
            try context.save()
        }
    )
}
