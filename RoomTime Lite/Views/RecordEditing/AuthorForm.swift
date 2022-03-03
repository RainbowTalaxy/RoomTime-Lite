//
//  AuthorForm.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/3/2.
//

import SwiftUI

struct AuthorForm: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var detail: RecordDetail
    
    @State private var authorName: String = ""
    
    init(detail: RecordDetail) {
        self.detail = detail
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("作者名", text: $authorName)
                        .textInputAutocapitalization(.never)
                }
            }
            .navigationTitle("添加作者")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("取消") {
                    presentationMode.wrappedValue.dismiss()
                }, trailing: Button("添加") {
                    detail.authors.append(authorName)
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
        .navigationViewStyle(.stack)
    }
}
