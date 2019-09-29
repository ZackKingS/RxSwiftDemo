//
//  String+Matches.swift
//  Handsome
//
//  Created by 高炼 on 2018/5/4.
//  Copyright © 2018年 BaiYiYuan. All rights reserved.
//

import Foundation

enum StringPattern {
    case custom(String)
    
    static let email: StringPattern = .custom("\\w*@\\w+(\\.\\w+)+")
    static let phone: StringPattern = .custom("1\\d{10}")
    static let numberString: StringPattern = .custom("\\d+")
    static let numberStringOrEmpty: StringPattern = .custom(StringPattern.numberString.orEmpty)
    static let numberAndAlpha: StringPattern = .custom("[0-9a-zA-Z]*")
    
    private var orEmpty: String {
        if case let .custom(patternString) = self {
            return "(\(patternString))|"
        } else {
            fatalError()
        }
    }
}

extension String {
    fileprivate var orEmpty: String {
        return "(\(self))|"
    }
    
    func matches(_ pattern: StringPattern) -> Bool {
        if case let .custom(patternString) = pattern {
            return NSPredicate(format: "SELF MATCHES %@", patternString).evaluate(with: self)
        } else {
            fatalError()
        }
    }
}
