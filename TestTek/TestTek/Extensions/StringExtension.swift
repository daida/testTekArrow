//
//  StringExtension.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import Foundation

extension String {
    var isHex: Bool {
        guard let regex = try? NSRegularExpression(pattern: "^#?[0-9a-fA-F]{3,6}") else { return false }
             guard regex.numberOfMatches(in: self, range: NSMakeRange(0, self.count)) == 1 else { return false }
        return true
    }
}
