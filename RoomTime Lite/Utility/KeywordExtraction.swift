//
//  KeywordExtraction.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/3/10.
//

import Foundation
import NaturalLanguage

/*
 TODO:
    1. 筛词
    2. 加权
 */

class KeywordExtraction {
    static func getWordCounts(target: String) -> [String: Int] {
        var dict: [String: Int] = [:]
        let tokenizer = NLTokenizer(unit: .word)
        tokenizer.string = target
        tokenizer.enumerateTokens(in: target.startIndex..<target.endIndex) { tokenRange, _ in
            let term = String(target[tokenRange])
            if let freq = dict[term] {
                dict[term] = freq + 1
            } else {
                dict[term] = 1
            }
            return true
        }
        return dict
    }
    
    static func getAllWordCounts(documents: [String]) -> [String: Int] {
        documents.map { document in
            getWordCounts(target: document)
        }.reduce([:]) { prevResult, next in
            prevResult.merging(next) { $1 }
        }
    }
    
    static func getWords(target: String) -> Set<String> {
        var set: Set<String> = []
        let tokenizer = NLTokenizer(unit: .word)
        tokenizer.string = target
        tokenizer.enumerateTokens(in: target.startIndex..<target.endIndex) { tokenRange, _ in
            let term = String(target[tokenRange])
            set.insert(term)
            return true
        }
        return set
    }
    
    static func calc_TF_IDF(documentDict: [String: Int], allDicts: Array<[String: Int]>) -> [String: Double] {
        var result: [String: Double] = [:]
        for (word, count) in documentDict {
            let documentWordCount = documentDict.reduce(0) { prev, pair in
                return prev + pair.value
            }
            let termFrequency = count.double / documentWordCount.double
            let documentAppearCount = allDicts.reduce(0) { prev, dict in
                return prev + (dict[word] ?? 0)
            }
            let documentFrequency = documentAppearCount.double / allDicts.count.double
            let inverseDocumentFrequence = log(allDicts.count.double / documentFrequency) + 1
            result[word] = termFrequency * inverseDocumentFrequence
        }
        return result
    }
    
    static func getKeywords(target: String, allDocuments: [String], num: Int = 10) -> [String] {
        let keywordStats = calc_TF_IDF(documentDict: getWordCounts(target: target), allDicts: allDocuments.map(getWordCounts))
        let keywordRank = Array(keywordStats).sorted { keyword1, keyword2 in
            keyword1.value > keyword2.value
        }.map { $0.key }
        let num = min(num, keywordRank.count)
        return Array(keywordRank[0..<num])
    }
}
