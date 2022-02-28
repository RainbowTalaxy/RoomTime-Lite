//
//  TagFormView.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/23.
//

import SwiftUI

struct TagFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var settings: UserSettings
    
    @State private var tagName = ""
    @State private var color = TagColor.all.first!
    
    let onAdded: (Tag) -> Void
    
    init(onAdded: @escaping (Tag) -> Void = { _ in }) {
        self.onAdded = onAdded
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("标签名", text: $tagName)
                        .textInputAutocapitalization(.never)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(TagColor.all) { color in
                                Button {
                                    self.color = color
                                } label: {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(color.value)
                                        .frame(width: 40, height: 40)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(self.color == color ? Color.blue : Color.clear, lineWidth: 2)
                                        )
                                        .padding(.horizontal, 5)
                                }
                            }
                        }
                        .padding(.vertical, 10)
                    }
                }
            }
            .navigationTitle("添加标签")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("取消") {
                    presentationMode.wrappedValue.dismiss()
                }, trailing: Button("添加") {
                    let tag = settings.addTag(name: tagName, color: color)
                    onAdded(tag)
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
        .navigationViewStyle(.stack)
    }
}

struct TagFormView_Previews: PreviewProvider {
    static var previews: some View {
        TagFormView()
    }
}
