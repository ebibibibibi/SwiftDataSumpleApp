//
//  ListItem.swift
//  SwiftDataSumpleApp
//
//  Created by TakahashiKotomi on 2024/02/25.
//

import SwiftUI

struct MessageItem: View {
    var message: Message
    var body: some View {
        NavigationLink(value: message) {
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.pink)
                    .frame(width: 64, height: 64)
                    .overlay {
                        Text("")
                            .font(.system(size: 48))
                            .foregroundStyle(.background)
                    }
                    .padding(.trailing)
                
                VStack(alignment: .leading) {
                    Text("")
                        .font(.headline)
                }
            }
        }
    }
}
