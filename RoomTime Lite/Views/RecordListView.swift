//
//  RecordListView.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/23.
//

import SwiftUI
import Markdown
import RoomTime

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
                        VStack(alignment: .leading, spacing: 0) {
                            Text(info.title)
                                .font(.title3)
                            
                            Text(info.date.formatted(date: .numeric, time: .omitted))
                                .foregroundColor(.secondary)
                                .padding(.bottom, 7)
                            
                            AutoWrap(info.tags, id: \.self, hSpacing: 7) { tag in
                                TagMiniView(tag: tag)
                                    .padding(.bottom, 7)
                            }
                        }
                        .padding(.top, 7)
                    }

                }
            }
            .refreshable {
                list.fresh()
            }
            .navigationTitle("文章")
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
