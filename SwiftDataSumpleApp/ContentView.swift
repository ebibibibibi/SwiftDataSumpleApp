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
    @Query private var items: [Item]
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("\(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    NavigationLink {
                        MessageEntryView()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}


struct MessageEntryView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var message: String = ""
    @State private var image = ""
    var body: some View {
        VStack {
            Spacer().frame(height: 100)
            TextField(" ", text: $message)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text("🍓\(message)🍓")
            Button(action: addItem) {
                Label("Add Item", systemImage: "plus")
            }
            Spacer()
            TextField(" ", text: $image)
                .padding()
            Text("🍇\(image)🍇")
        }
    }
    private func addItem() {
        var newItem = Item(timestamp: Date(), message: message, image: image)
        modelContext.insert(newItem)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
