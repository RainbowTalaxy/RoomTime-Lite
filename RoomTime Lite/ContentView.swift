//
//  ContentView.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isAlertVisible = false
    
    var body: some View {
        TabView {
            RecordListView()
                .tabItem {
                    Label("文章", systemImage: "doc.text")
                }
            
            LibraryListView()
                .tabItem {
                    Label("书库", systemImage: "books.vertical")
                }
            
            UserSettingView()
                .environmentObject(UserSettings())
                .tabItem {
                    Label("设置", systemImage: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
