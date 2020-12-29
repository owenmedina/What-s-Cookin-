//
//  ArrayExtensions.swift
//  Cookin
//
//  Created by Owen Medina on 12/28/20.
//

import Foundation

extension Array where Element: NSCopying {
    func clone() -> [Any] {
        var copiedArray = Array<Any>()
        for element in self {
            copiedArray.append(element.copy())
        }
        return copiedArray
    }
}
