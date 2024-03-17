//
//  Model.swift
//  SwiftDataSumpleApp
//
//  Created by TakahashiKotomi on 2024/01/03.
//

import Foundation
import SwiftData

@Model
final class Person {
    @Attribute let personID: UUID
    let name: String
    var age: Int
    let gender: Gender
    @Relationship(deleteRule: .noAction, inverse: \Community.member)
    var community: [Community]
    @Relationship(deleteRule: .cascade, inverse: \CommunityRelationship.person1)
    var relationships: [CommunityRelationship]
    
    init(personID: UUID, name: String, age: Int, gender: Gender, community: [Community], relationships: [CommunityRelationship]) {
        self.personID = personID
        self.name = name
        self.age = age
        self.gender = gender
        self.community = community
        self.relationships = relationships
    }
    
    enum Gender: String, Codable  {
        case male = "男"
        case female = "女"
        case other = "その他"
    }
}

@Model
final class Community {
    @Attribute let communityName: String
    var member: [Person]
    init(communityName: String, member: [Person]) {
        self.communityName = communityName
        self.member = member
    }
}


@Model
final class CommunityRelationship {
    var person1: Person?
    var person2: Person?
    var relationshipType: RelationshipType
    
    init(relationshipType: RelationshipType) {
        self.relationshipType = relationshipType
    }
    
    enum RelationshipType: String, Codable  {
        case friend = "友人"
        case lover = "恋人"
        case spouse = "配偶者"
    }
}

extension Community {
    static let houkagoClub = Community(communityName: "放課後クラブ", member: [])
}

extension CommunityRelationship {
    static let hitomiAndTakeshi = CommunityRelationship(relationshipType: .friend)
}

extension Person {
    static var hitomi = Person(personID: UUID(), name: "ひとみ", age: 16, gender: .female, community: [], relationships: [])
    
    static var takeshi = Person(personID: UUID(), name: "たけし", age: 16, gender: .male, community: [], relationships: [])
    
    static func insertSampleData(modelContext: ModelContext) {
        // Add the animal categories to the model context.
        modelContext.insert(hitomi)
        modelContext.insert(takeshi)
        Community.houkagoClub.member.append(hitomi)
        CommunityRelationship.hitomiAndTakeshi.person1 = hitomi
        CommunityRelationship.hitomiAndTakeshi.person2 = takeshi
    }
}


//struct ItemSchemaV1: VersionedSchema {
//    static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)
//    static var models: [any PersistentModel.Type] {
//        [Human.self]
//    }
//    @Model
//    final class Human {
//        var timestamp: Date
//        init(timestamp: Date) {
//            self.timestamp = timestamp
//        }
//    }
//}
//
//
//struct ItemSchemaV2: VersionedSchema {
//    static var versionIdentifier = Schema.Version(2, 0, 0)
//    static var models: [any PersistentModel.Type] {
//        [Item.self]
//    }
//    @Model
//    final class Item {
//        // timestampに一意制約を付与する
//        @Attribute(.unique) var timestamp: Date
//        init(timestamp: Date) {
//            self.timestamp = timestamp
//        }
//    }
//}
//
//struct ItemSchemaV3: VersionedSchema {
//    static var versionIdentifier = Schema.Version(3, 0, 0)
//    static var models: [any PersistentModel.Type] {
//        [Item.self]
//    }
//    @Model
//    final class Item {
//        @Attribute(.unique) var timestamp: Date
//        // メッセージ 写真カラムを追加。
//        var message: String = ""
//        var image: String = ""
//        init(timestamp: Date, message: String = "", image: String = "") {
//            self.timestamp = timestamp
//            self.message = message
//            self.image = image
//        }
//    }
//}
//
//
//// Itemが常に最新バージョンを指すように型エイリアスを追加する
//typealias Item = ItemSchemaV3.Item
//
//// マイグレーションプランを作成する。
//// 一つの特定のバージョンから別のバージョンに移動する方法を定義する
//enum ItemMigrationPlan: SchemaMigrationPlan {
//    static var schemas: [any VersionedSchema.Type] {
//        // バージョンの順番に配置することで、SwiftDataが順序正しくバージョン間を移行できるようにする
//        [ItemSchemaV1.self, ItemSchemaV2.self, ItemSchemaV3.self]
//    }
//
//    static var stages: [MigrationStage] {
//        [migrateV1toV2, migrateV2toV3]
//    }
//    // 簡易的なマイグレーション。V1toV2の時は、一意制約をつけただけなので、lightweightで十分。
//    static let migrateV1toV2: MigrationStage = MigrationStage.lightweight(
//        fromVersion: ItemSchemaV1.self,
//        toVersion: ItemSchemaV2.self
//    )
//    // カスタムマイグレーション。V2toV3時は messageとitemが追加されているため、旧バージョンの際の扱いを定義する。
//    static let migrateV2toV3 = MigrationStage.custom(
//        fromVersion: ItemSchemaV2.self,
//        toVersion: ItemSchemaV3.self,
//        willMigrate: nil
//    ) { context in
//        let items = try? context.fetch(FetchDescriptor<ItemSchemaV3.Item>())
//
//        items?.forEach { item in
//            item.message = ""
//            item.image = ""
//        }
//
//        try? context.save()
//    }
//}
