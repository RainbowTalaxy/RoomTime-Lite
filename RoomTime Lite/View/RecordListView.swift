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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(list.recordInfos) { info in
                    NavigationLink {
                        RecordDetailView(recordInfo: info, settings: settings)
                    } label: {
                        RecordInfoView(info: info)
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
