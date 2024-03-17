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
    @Query private var messages: [Message]
    @State private var selection: Message?
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(messages) { message in
                    MessageItem(message: message)
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
        Text("こんにちは🐧")
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
