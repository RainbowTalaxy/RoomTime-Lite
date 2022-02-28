//
//  RecordDetailView.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/25.
//

import SwiftUI
import Markdown
import RoomTime
import WrappingHStack

struct RecordDetailView: View {
    @EnvironmentObject var list: RecordList
    
    @ObservedObject private var detail: RecordDetail
    
    @FocusState private var nameIsFocused: Bool
    
    @State private var isEditingContent = false
    
    init(recordInfo: RecordInfo, settings: UserSettings) {
        self.detail = RecordDetail(recordInfo: recordInfo, settings: settings)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        if isEditingContent {
                            TextField("请输入标题", text: $detail.title)
                                .font(.system(size: 29, weight: .bold))
                        } else {
                            Text(detail.title == "" ? "无标题" : detail.title)
                                .font(.system(size: 29, weight: .bold))
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    WrappingHStack(detail.tags, spacing: .constant(7), lineSpacing: 7) { tag in
                        TagMiniView(tag: tag)
                    }
                    .padding(.horizontal)
                    
                    if isEditingContent {
                        TextArea(text: $detail.content, extraHeight: 500)
                            .padding(.horizontal)
                    } else {
                        MarkdownView(text: detail.content == "" ? "无内容" : detail.content) { element in
                            ElementView(element: element)
                        }
                        .padding(.vertical)
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical, 20)
            }
            .gesture(DragGesture().onChanged { value in
                print("Hello")
                if value.translation.height > 10 {
                    UIApplication.shared.endEditing()
                }
            })
        }
        .navigationTitle(detail.date.numeric)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                if isEditingContent {
                    Button {
                        isEditingContent = false
                        detail.fresh()
                    } label: {
                        Text("取消")
                    }
                    Button {
                        isEditingContent = false
                        detail.store()
                        list.fresh()
                    } label: {
                        Text("保存")
                    }
                } else {
                    NavigationLink {
                        RecordInfoForm(detail: detail)
                    } label: {
                        Image(systemName: "info.circle")
                    }

                    Button {
                        isEditingContent = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
            
        }
    }
}
