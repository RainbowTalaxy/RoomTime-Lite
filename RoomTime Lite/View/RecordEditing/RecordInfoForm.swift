//
//  RecordInfoForm.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/28.
//

import SwiftUI
import RoomTime

struct RecordInfoForm: View {
    @EnvironmentObject var list: RecordList
    @EnvironmentObject var settings: UserSettings
    
    @ObservedObject private var detail: RecordDetail
    
    @State private var isAuthorSheetVisible = false
    @State private var isTagSheetVisible = false
    @State private var isKeywordSheetVisible = false
    
    init(detail: RecordDetail) {
        self.detail = detail
    }
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("标题")
                    TextField("文章标题", text: $detail.title)
                }
            }
            
            Section {
                ForEach(detail.authors, id: \.self) { author in
                    Text(author)
                }
                .onDelete { indexs in
                    for index in indexs {
                        detail.authors.remove(at: index)
                    }
                }
                Button {
                    isAuthorSheetVisible = true
                } label: {
                    Label("添加作者", systemImage: "plus.circle")
                }

            } header: {
                Text("作者")
            }
            .sheet(isPresented: $isAuthorSheetVisible) {
                AuthorForm(detail: detail)
            }
            
            Section {
                DatePicker("文章日期", selection: $detail.date, displayedComponents: .date)
                    .datePickerStyle(.graphical)
            }
            
            Section {
                if settings.tagLirary.isEmpty {
                    Text("无标签")
                        .foregroundColor(.secondary)
                } else {
                    AutoWrap(settings.tagLirary, id: \.id, vSpacing: 10, hSpacing: 10) { tag in
                        TagView(tag: tag)
                            .opacity(detail.hasTag(tag: tag) ? 1 : 0.3)
                            .onTapGesture {
                                if detail.hasTag(tag: tag) {
                                    detail.removeTag(tag: tag)
                                } else {
                                    detail.addTag(tag: tag)
                                }
                            }
                    }
                    .padding(.vertical, 10)
                }
                
                Button {
                    isTagSheetVisible = true
                } label: {
                    Label("添加新标签", systemImage: "plus.circle")
                }
                
                Button {
                    isKeywordSheetVisible = true
                } label: {
                    Label("从文章中获取关键词", systemImage: "plus.circle")
                }
            } header: {
                Text("标签")
            }
            .sheet(isPresented: $isTagSheetVisible) {
                TagFormView { tag in
                    detail.addTag(tag: tag)
                }
            }
            .sheet(isPresented: $isKeywordSheetVisible) {
                KeywordSelectForm(detail: detail)
            }
        }
        .navigationTitle("文章信息")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            detail.store()
            list.fresh()
        }
    }
}
