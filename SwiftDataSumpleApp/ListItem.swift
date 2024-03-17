//
//  ListItem.swift
//  SwiftDataSumpleApp
//
//  Created by TakahashiKotomi on 2024/02/25.
//

import SwiftUI

struct ListItem: View {
    var person: Person
    
    var body: some View {
        NavigationLink(value: person) {
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.pink)
                    .frame(width: 64, height: 64)
                    .overlay {
                        Text(person.name)
                            .font(.system(size: 48))
                            .foregroundStyle(.background)
                    }
                    .padding(.trailing)
                
                VStack(alignment: .leading) {
                    Text(person.name)
                        .font(.headline)
                }
            }
        }
    }
}
#Preview {
    ListItem(person: .hitomi)
}
