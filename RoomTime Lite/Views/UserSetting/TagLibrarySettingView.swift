//
//  TagLibrarySettingView.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/23.
//

import SwiftUI

struct TagLibrarySettingView: View {
    @EnvironmentObject var settings: UserSettings
    @State private var isSheetVisible = false
    
    var body: some View {
        List {
            ForEach(settings.tagLirary) { tag in
                Text(tag.name)
                    .padding(.horizontal, 17)
                    .padding(.vertical, 7)
                    .background(
                        RoundedRectangle(cornerRadius: 13)
                            .fill(tag.color.value)
                    )
                    .padding(.vertical, 5)
            }
            .onDelete { indexs in
                for index in indexs {
                    settings.removeTag(index: index)
                }
            }
        }
        .sheet(isPresented: $isSheetVisible) {
            TagFormView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("标签库")
        .toolbar {
            Button("添加") {
                isSheetVisible = true
            }
        }
    }
}

struct TagLibrarySettingView_Previews: PreviewProvider {
    static var previews: some View {
        TagLibrarySettingView()
    }
}
