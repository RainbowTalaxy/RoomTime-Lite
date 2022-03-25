//
//  UserSettingView.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/23.
//

import SwiftUI

/*
 User Setting:
    - User information
    - Tag library
 */

struct UserSettingView: View {
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink {
                        UserInfoSettingView()
                    } label: {
                        Label("作者", systemImage: "person.circle")
                        Spacer()
                        Text(settings.authorName)
                            .foregroundColor(.secondary)
                    }
                }
                
                Section {
                    NavigationLink {
                        TagLibrarySettingView()
                    } label: {
                        Label("标签库", systemImage: "tag.circle")
                        Spacer()
                        Text("\(settings.tagLirary.count)个")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("设置")
        }
        .navigationViewStyle(.stack)
        .onAppear {
            settings.fresh()
        }
    }
}

struct UserSettingView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingView()
    }
}
