//
//  RecordInfoView.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/3/2.
//

import SwiftUI
import WrappingHStack

struct RecordInfoView: View {
    let info: RecordInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(info.title)
                .font(.title3)
            
            Text(info.date.numeric)
                .foregroundColor(.secondary)
                .padding(.bottom, 7)
            
            WrappingHStack(info.tags, spacing: .constant(7), lineSpacing: 7) { tag in
                TagMiniView(tag: tag)
            }
        }
        .padding(.vertical, 7)
    }
}
