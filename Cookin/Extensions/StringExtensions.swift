//
//  StringExtensions.swift
//  Cookin
//
//  Created by Owen Medina on 11/24/20.
//

import Foundation

extension String {
    func camelCase() -> String {
        var resultWord = ""
        for word in self.wordList {
            resultWord.append(word.lowercased())
        }
        return resultWord
    }
    
    var wordList: [String] {
        return components(separatedBy: CharacterSet.alphanumerics.inverted).filter { !$0.isEmpty }
    }
}
