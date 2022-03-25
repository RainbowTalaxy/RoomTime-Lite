//
//  KeywordSelectForm.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/3/25.
//

import SwiftUI
import RoomTime

struct KeywordSelectForm: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var detail: RecordDetail
    
    @State private var tags: [Tag] = []
    
    let standbyTags: [Tag]
    
    init(detail: RecordDetail) {
        self.detail = detail
        self.standbyTags = detail.keywords.map { tagName in
            if let tag = globalUserSettings.tagLirary.first(where: { $0.name == tagName }) {
                return tag
            } else {
                return Tag(name: tagName, color: .random)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    AutoWrap(standbyTags, id: \.id, vSpacing: 9, hSpacing: 9) { tag in
                        TagView(tag: tag)
                            .opacity(tags.contains(tag) ? 1 : 0.3)
                            .onTapGesture {
                                if tags.contains(tag) {
                                    if let index = tags.firstIndex(where: { tag == $0 }) {
                                        tags.remove(at: index)
                                    }
                                } else {
                                    tags.append(tag)
                                }
                            }
                    }
                    .padding(.vertical, 9)
                }
            }
            .navigationTitle("文章中的关键字")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("取消") {
                    presentationMode.wrappedValue.dismiss()
                }, trailing: Button("添加") {
                    tags.forEach { tag in
                        detail.addTag(tag: tag)
                    }
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
        .navigationViewStyle(.stack)
    }
}
