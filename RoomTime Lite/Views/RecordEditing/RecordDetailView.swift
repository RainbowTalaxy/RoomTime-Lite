//
//  RecordDetailView.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/25.
//

import SwiftUI
import Markdown

struct RecordDetailView: View {
    @ObservedObject private var detail: RecordDetail
    
    init(recordInfo: RecordInfo, settings: UserSettings) {
        self.detail = RecordDetail(recordInfo: recordInfo, settings: settings)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                MarkdownView(text: detail.content) { element in
                    ElementView(element: element)
                }
                .padding()
                .padding(.bottom, 20)
            }
        }
        .navigationTitle(detail.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            detail.fresh()
        }
    }
}
