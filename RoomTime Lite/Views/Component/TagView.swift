//
//  TagView.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/24.
//

import SwiftUI

struct TagView: View {
    let tag: Tag
    
    var body: some View {
        Text(tag.name)
            .foregroundColor(.black)
            .padding(.horizontal, 17)
            .padding(.vertical, 7)
            .background(
                RoundedRectangle(cornerRadius: 13)
                    .fill(tag.color.value)
            )
    }
}

struct TagMiniView: View {
    let tag: Tag
    
    var body: some View {
        Text(tag.name)
            .font(.system(size: 12))
            .foregroundColor(.black)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(tag.color.value)
            )
    }
}
