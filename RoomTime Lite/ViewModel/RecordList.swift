//
//  RecordList.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/25.
//

import Foundation

class RecordList: ObservableObject {
    @Published var recordInfos: [RecordInfo]
    
    let settings: UserSettings
    
    init(settings: UserSettings) {
        self.settings = settings
        self.recordInfos = Storage.getRecordsInfo(settings: settings)
    }
    
    func fresh() {
        recordInfos = Storage.getRecordsInfo(settings: settings)
    }
}
