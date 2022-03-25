//
//  BookEditingForm.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/3/2.
//

import SwiftUI
import WrappingHStack

struct BookEditingForm: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var list: BookList
    @EnvironmentObject var settings: UserSettings
    
    @ObservedObject private var detail: BookDetail
    
    init(detail: BookDetail) {
        self.detail = detail
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("书本名", text: $detail.name)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    WrappingHStack(settings.tagLirary, spacing: .constant(9), lineSpacing: 9) { tag in
                        TagView(tag: tag)
                            .opacity(detail.tags.contains(tag) ? 1 : 0.3)
                            .onTapGesture {
                                if detail.tags.contains(tag) {
                                    if let index = detail.tags.firstIndex(where: { $0 == tag }) {
                                        detail.tags.remove(at: index)
                                    }
                                } else {
                                    detail.tags.append(tag)
                                }
                            }
                    }
                    .padding(.vertical, 9)
                }
            }
            .navigationTitle("修改书本信息")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("取消") {
                    detail.fresh()
                    presentationMode.wrappedValue.dismiss()
                }, trailing: Button("更新") {
                    detail.update()
                    list.fresh()
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
        .navigationViewStyle(.stack)
    }
}
