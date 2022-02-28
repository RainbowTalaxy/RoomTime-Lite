//
//  RecordListView.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/23.
//

import SwiftUI
import WrappingHStack

struct RecordListView: View {
    @EnvironmentObject var list: RecordList
    @EnvironmentObject var settings: UserSettings
    
    let columns = [
        GridItem(.adaptive(minimum: 0), alignment: .leading)
      ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(list.recordInfos) { info in
                    NavigationLink {
                        RecordDetailView(recordInfo: info, settings: settings)
                    } label: {
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
                .onDelete { indexs in
                    for index in indexs {
                        list.removeRecord(record: list.recordInfos[index])
                    }
                }
            }
            .refreshable {
                list.fresh()
            }
            .navigationTitle("文章")
            .toolbar {
                Button {
                    list.createRecord()
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

struct RecordListView_Previews: PreviewProvider {
    static var previews: some View {
        RecordListView()
    }
}
