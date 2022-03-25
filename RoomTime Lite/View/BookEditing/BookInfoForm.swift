//
//  BookInfoForm.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/3/2.
//

import SwiftUI
import WrappingHStack

struct BookInfoForm: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var list: BookList
    @EnvironmentObject var settings: UserSettings
    
    @State private var bookName: String = ""
    @State private var tags: [Tag] = []
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("书本名", text: $bookName)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    WrappingHStack(settings.tagLirary, spacing: .constant(9), lineSpacing: 9) { tag in
                        TagView(tag: tag)
                            .opacity(tags.contains(tag) ? 1 : 0.3)
                            .onTapGesture {
                                if tags.contains(tag) {
                                    if let index = tags.firstIndex(where: { $0 == tag }) {
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
            .navigationTitle("添加书本")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("取消") {
                    presentationMode.wrappedValue.dismiss()
                }, trailing: Button("添加") {
                    list.createBook(name: bookName, tags: tags)
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
        .navigationViewStyle(.stack)
    }
}

struct BookInfoForm_Previews: PreviewProvider {
    static var previews: some View {
        BookInfoForm()
    }
}
