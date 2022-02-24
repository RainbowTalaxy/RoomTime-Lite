//
//  UserInfoSettingView.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/23.
//

import SwiftUI

struct UserInfoSettingView: View {
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        Form {
            Section {
                TextField("名称", text: $settings.authorName)
            } header: {
                Text("作者")
            }
        }
        .navigationTitle("作者信息")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            settings.store()
        }
    }
}

struct UserInfoSettingView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoSettingView()
    }
}
