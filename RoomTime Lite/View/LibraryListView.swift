//
//  LibraryListView.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/23.
//

import SwiftUI
import WrappingHStack

struct LibraryListView: View {
    @EnvironmentObject var recordList: RecordList
    @EnvironmentObject var list: BookList
    @EnvironmentObject var settings: UserSettings
    
    @State private var isSheetVisible = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(list.bookInfos) { info in
                    NavigationLink {
                        BookDetailView(bookInfo: info, recordList: recordList, settings: settings)
                        EmptyView()
                    } label: {
                        VStack(alignment: .leading, spacing: 0) {
                            Text(info.name)
                                .font(.title3)
                                .padding(.bottom, 7)
                            
                            WrappingHStack(info.tags, spacing: .constant(7), lineSpacing: 7) { tag in
                                TagMiniView(tag: tag)
                            }
                        }
                        .padding(.vertical, 7)
                    }
                }
                .onDelete { indexs in
                    for index in indexs {
                        list.removeBook(book: list.bookInfos[index])
                    }
                }
            }
            .refreshable {
                list.fresh()
            }
            .sheet(isPresented: $isSheetVisible) {
                BookInfoForm()
            }
            .navigationTitle("书库")
            .toolbar {
                Button {
                    isSheetVisible = true
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
        .navigationViewStyle(.stack)
        .onAppear {
            list.fresh()
        }
    }
}

struct LibraryListView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryListView()
    }
}
