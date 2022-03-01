//
//  TagColorChooseView.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/25.
//

import SwiftUI

struct TagColorChooseView: View {
    @EnvironmentObject var settings: UserSettings
    
    @State private var color: TagColor
    
    let tag: Tag
    
    init(tag: Tag) {
        self.tag = tag
        _color = State(initialValue: tag.color)
    }
    
    var body: some View {
        Form {
            Section {
                VStack {
                    ForEach(TagColor.all) { color in
                        Button {
                            self.color = color
                            settings.updateTag(tag: tag, color: color)
                        } label: {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(color.value)
                                    .frame(height: 40)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(self.color == color ? Color.blue : Color.clear, lineWidth: 2)
                                    )
                                    .padding(5)
                        }
                    }
                }
                .padding(.vertical, 10)
            }
        }
        .navigationTitle("选择颜色")
        .navigationBarTitleDisplayMode(.inline)
    }
}

