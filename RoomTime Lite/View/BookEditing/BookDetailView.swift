//
//  BookDetailView.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/3/2.
//

import SwiftUI

struct BookDetailView: View {
    @EnvironmentObject var list: BookList
    @EnvironmentObject var settings: UserSettings
    
    @ObservedObject private var detail: BookDetail
    
    @State private var isSheetVisible = false
    
    init(bookInfo: BookInfo, recordList: RecordList, settings: UserSettings) {
        self.detail = BookDetail(bookInfo: bookInfo, recordList: recordList, settings: settings)
    }
    
    var body: some View {
        List {
            ForEach(detail.records) { record in
                NavigationLink {
                    RecordDetailView(recordInfo: record, settings: settings)
                } label: {
                    RecordInfoView(info: record)
                }
            }
        }
        .sheet(isPresented: $isSheetVisible) {
            BookEditingForm(detail: detail)
        }
        .navigationTitle(detail.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                isSheetVisible = true
            } label: {
                Image(systemName: "info.circle")
            }
        }
    }
}
