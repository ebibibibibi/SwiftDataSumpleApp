//
//  ContentView.swift
//  SwiftDataSumpleApp
//
//  Created by TakahashiKotomi on 2024/01/03.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var peaple: [Person]
    @Query private var community: [Community]
    @Query private var communityRelationship: [CommunityRelationship]
    @State private var selection: Person?
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(peaple) { person in
                    ListItem(person: person)
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } 
    detail: {
        if let selection = selection {
            NavigationStack {
                let community = community.filter { community in
                    community.member.contains(where: { $0 == selection })
                }
                let communityRelationship = communityRelationship.filter { community in
                    community.person1 == selection }
                DetailView(person: selection, community: community, communityRelationship: communityRelationship)
                }
            }
        }
        .task {
            if peaple.isEmpty {
                Person.insertSampleData(modelContext: modelContext)
            }
        }
    }
    private func addItem() {
        withAnimation {
            print("💐")
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
        }
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            print("🌷")
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
        }
    }
}
