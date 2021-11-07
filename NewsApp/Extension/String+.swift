//
//  String+.swift
//  NewsApp
//
//  Created by user on 06.11.2021.
//

import Foundation

extension String {
    /// возвращает строку у которой первая буква станет большой
    func capitalizeFirst() -> String {
        guard count>0 else { return self }
        let splitIndex = index(after: startIndex)
        let firstCharacter = self[..<splitIndex].uppercased()
        let sentence = self[splitIndex...]
        return firstCharacter + sentence
    }
}
