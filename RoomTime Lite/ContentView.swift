//
//  ContentView.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/23.
//

import SwiftUI

let globalUserSettings = UserSettings()

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
                .tabItem {
                    Label("设置", systemImage: "person")
                }
        }
        .environmentObject(globalUserSettings)
        .environmentObject(RecordList(settings: globalUserSettings))
        .environmentObject(BookList(settings: globalUserSettings))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
