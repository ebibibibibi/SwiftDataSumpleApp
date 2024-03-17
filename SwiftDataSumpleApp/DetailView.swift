//
//  DetailView.swift
//  SwiftDataSumpleApp
//
//  Created by TakahashiKotomi on 2024/02/25.
//

import SwiftUI

struct DetailView: View {
    var person: Person
    var community: [Community]
    var communityRelationship: [CommunityRelationship]
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("年齢")
                        .bold()
                    Text("\(person.age)")
                }
                HStack {
                    Text("性別")
                        .bold()
                    Text(person.gender.rawValue)
                }
                
                //            if case let (start?, end?) = (trip.startDate, trip.endDate) {
                //                HStack {
                //                    Text(start, style: .date)
                //                    Image(systemName: "arrow.right")
                //                    Text(end, style: .date)
                //                }
                //            }
            }
            
            Section {
                VStack(alignment: .leading) {
                    Text("所属コミュニティ")
                        .font(.title)
                        .bold()
                    ForEach(community, id: \.self) { community in
                        Text(community.communityName)
                    }
                }
            }
            Section {
                VStack(alignment: .leading) {
                    Text("関係性")
                        .font(.title)
                        .bold()
                    ForEach(communityRelationship, id: \.self) { communityRelationship in
                        Text(communityRelationship.relationshipType.rawValue)
                    }
                }
            }
        }
        .navigationTitle(Text(person.name))
    }
    
}
