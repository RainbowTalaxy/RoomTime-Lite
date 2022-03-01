//
//  RecordInfoForm.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/28.
//

import SwiftUI
import WrappingHStack
import RoomTime

struct RecordInfoForm: View {
    @EnvironmentObject var list: RecordList
    @EnvironmentObject var settings: UserSettings
    
    @ObservedObject private var detail: RecordDetail
    
    @State private var isSheetVisible = false
    
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
                DatePicker("文章日期", selection: $detail.date, displayedComponents: .date)
                    .datePickerStyle(.graphical)
            }
            
            Section {
                WrappingHStack(settings.tagLirary, spacing: .constant(9), lineSpacing: 9) { tag in
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
                .padding(.vertical, 9)
                
                Button {
                    isSheetVisible = true
                } label: {
                    Label("添加新标签", systemImage: "plus.circle")
                }
            }
        }
        .listStyle(.insetGrouped)
        .sheet(isPresented: $isSheetVisible) {
            TagFormView()
        }
        .navigationTitle("文章信息")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            detail.store()
            list.fresh()
        }
    }
}
