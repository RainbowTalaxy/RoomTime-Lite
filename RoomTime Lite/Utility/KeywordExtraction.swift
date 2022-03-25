//
//  KeywordExtraction.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/3/10.
//

import Foundation
import NaturalLanguage
import Markdown

class KeywordExtraction {
    static func getWordCounts(target: String) -> [String: Double] {
        var dict: [String: Double] = [:]
        let resolver = Markdown.Resolver()
        let elements = resolver.render(text: target)
        elements.forEach { element in
            dict.merge(getWordCounts(element: element)) { d1, d2 in
                d1 + d2
            }
        }
        return dict
    }
    
    static let nouseTags: [NLTag] = [.adjective, .adverb, .particle, .number, .pronoun, .preposition, .conjunction]
    
    static func getWordCounts(text: String, weight: Double = 1) -> [String: Double] {
        var dict: [String: Double] = [:]
        let tagger = NLTagger(tagSchemes: [.lexicalClass])
        tagger.string = text
        let options: NLTagger.Options = [.omitPunctuation, .omitWhitespace]
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange in
            if let tag = tag, !nouseTags.contains(tag) {
                let term = String(text[tokenRange]).lowercased()
                if let freq = dict[term] {
                    dict[term] = freq + weight
                } else {
                    dict[term] = weight
                }
            }
            return true
        }
        return dict
    }
    
    static func getWordCounts(element: Markdown.Element, weight: Double = 1) -> [String: Double] {
        var dict: [String: Double] = [:]
        switch element {
        case let fm as FrontMatterElement:
            if let title = fm.properties["title"] as? String {
                dict = getWordCounts(text: title , weight: weight * 6)
            }
        case let header as HeaderElement:
            dict = getWordCounts(text: header.title, weight: weight * (1 + Double(7 - header.level) * 0.5))
        case let quote as QuoteElement:
            quote.elements.forEach { element in
                dict.merge(getWordCounts(element: element, weight: weight * 0.7)) { d1, d2 in
                    d1 + d2
                }
            }
        case let orderList as OrderListElement:
            orderList.items.forEach { elements in
                elements.forEach { element in
                    dict.merge(getWordCounts(element: element)) { d1, d2 in
                        d1 + d2
                    }
                }
            }
        case let unorderList as UnorderListElement:
            unorderList.items.forEach { elements in
                elements.forEach { element in
                    dict.merge(getWordCounts(element: element)) { d1, d2 in
                        d1 + d2
                    }
                }
            }
        case let table as TableElement:
            table.heads.forEach { head in
                dict.merge(getWordCounts(text: head)) { d1, d2 in
                    d1 + d2
                }
            }
            table.rows.forEach { row in
                row.forEach { item in
                    dict.merge(getWordCounts(text: item)) { d1, d2 in
                        d1 + d2
                    }
                }
            }
        case let line as LineElement:
            dict = getWordCounts(text: line.text)
        default:
            break
        }
        return dict
    }
    
    static func calc_TF_IDF(documentDict: [String: Double], allDicts: Array<[String: Double]>) -> [String: Double] {
        var result: [String: Double] = [:]
        for (word, count) in documentDict {
            let documentWordCount = documentDict.reduce(0) { prev, pair in
                return prev + pair.value
            }
            let termFrequency = count / documentWordCount
            let documentAppearCount = allDicts.reduce(0) { prev, dict in
                return prev + (min(dict[word] ?? 0, 1))
            }
            let documentFrequency = documentAppearCount / allDicts.count.double
            let inverseDocumentFrequence = log(allDicts.count.double / documentFrequency + 0.125) + 1
            result[word] = termFrequency * inverseDocumentFrequence
        }
        return result
    }
    
    static func getKeywords(target: String, allDocuments: [String], num: Int = 8) -> [String] {
        let keywordStats = calc_TF_IDF(documentDict: getWordCounts(target: target), allDicts: allDocuments.map(getWordCounts))
        let keywordRank = Array(keywordStats).sorted { keyword1, keyword2 in
            keyword1.value > keyword2.value
        }.map { $0.key }
        let num = min(num, keywordRank.count)
        return Array(keywordRank[0..<num])
    }
}
