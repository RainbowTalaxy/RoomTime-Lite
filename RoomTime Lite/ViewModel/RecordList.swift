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
        self.recordInfos = Storage.getRecordsInfo(settings: settings).sorted { r1, r2 in
            r1.file.name > r2.file.name
        }
    }
    
    func fresh() {
        recordInfos = Storage.getRecordsInfo(settings: settings).sorted { r1, r2 in
            r1.file.name > r2.file.name
        }
    }
    
    func createRecord() {
        Storage.createRecord(settings: settings)
        fresh()
    }
    
    func removeRecord(record: RecordInfo) {
        Storage.deleteRecord(record: record)
        fresh()
    }
}
