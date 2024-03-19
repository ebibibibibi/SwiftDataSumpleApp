//
//  ContentView.swift
//  SwiftDataSumpleApp
//
//  Created by TakahashiKotomi on 2024/01/03.
//

import SwiftUI
import SwiftData

struct RecordBook {
    var title: String
    var image: [String]
    var createdAt: Date
    var updatedAt: Date?
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var messages: [Message]
    @State private var selection: Message?
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderTitleView()
            
            ScrollView(.vertical) {
                
                Spacer()
                    .frame(height: 30)
                
                ScrollViewItem()
            }
        }
        .background(
            // 背景色の設定
            LinearGradient(gradient: Gradient(colors: [Color(red: 18 / 255, green: 18 / 255, blue: 36 / 255), Color(red: 94 / 255, green: 58 / 255, blue: 102 / 255)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
    }
}

// 画面上部　ヘッダー
struct HeaderTitleView: View {
    
    var body: some View {
        VStack (spacing: 0) {
            Spacer()
                .frame(height: 50)
            HStack(spacing: 0) {
                Text("本棚")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "line.3.horizontal.decrease.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color(red: 55 / 255, green: 50 / 255, blue: 70 / 255))
                    .background(
                        Color.white
                            .cornerRadius(90)
                    )
            }
            .padding(.horizontal, 20)
        }
    }
}


struct ScrollViewItem: View {
    let date = Date()
    var body: some View {
        VStack {
            HStack {
                Text("これはタイトルです")
                    .lineLimit(nil)
                    .font(.system(.title3, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
                .frame(height: 20)
            
            Text("""
これは長いテキストです
これは長いテキストです
これは長いテキストですこれは長いテキストです
""")
            .lineLimit(nil)
            .font(.system(.body, design: .rounded))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
                .frame(height: 20)
            
            Divider()
                .frame(height: 1)
                .background(Color(red: 95 / 255, green: 85 / 255, blue: 100 / 255))
            
            HStack {
                Text(startDateToString(date))
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                    .background(Color(red: 55 / 255, green: 50 / 255, blue: 70 / 255))
            }
            .padding(.top, 10)
        }
        .padding(20)
        .background(
            Color(red: 60 / 255, green: 60 / 255, blue: 75 / 255)
                .opacity(0.5)
        )
        .cornerRadius(10)
        .frame(minHeight: 150)
        .padding(.horizontal, 20)
    }
    
    private func startDateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        // ロケールを日本に設定
        formatter.locale = Locale(identifier: "ja_JP")
        // 曜日を含む形式で日付をフォーマット
        formatter.dateFormat = "M月d日 EEEE"
        
        return formatter.string(from: date)
    }

}
