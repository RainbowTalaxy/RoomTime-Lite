//
//  BookList.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/3/2.
//

import Foundation

class BookList: ObservableObject {
    @Published var bookInfos: [BookInfo]
    
    let settings: UserSettings
    
    init(settings: UserSettings) {
        self.settings = settings
        self.bookInfos = Storage.getBooksInfo(settings: settings).sorted { r1, r2 in
            r1.file.name > r2.file.name
        }
    }
    
    func fresh() {
        bookInfos = Storage.getBooksInfo(settings: settings).sorted { r1, r2 in
            r1.file.name > r2.file.name
        }
    }
    
    func createBook() {
        _ = Storage.createBook(settings: settings)
        fresh()
    }
    
    func createBook(name: String, tags: [Tag]) {
        Storage.createBook(book: Book(name: name, tags: tags.map { $0.name }))
        fresh()
    }
    
    func removeBook(book: BookInfo) {
        Storage.deleteBook(book: book)
        fresh()
    }
}
