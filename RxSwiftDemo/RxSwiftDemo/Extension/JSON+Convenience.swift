//
//  JSON+Convenience.swift
//  JianDeCiShan
//
//  Created by 高炼 on 2019/5/6.
//  Copyright © 2019 BaiYiYuan. All rights reserved.
//

import Foundation
import SwiftyJSON

extension JSON: Mutable { }

extension JSON {
    var message: String? {
        get {
            if let message = self["msg"].string {
                if message.lowercased().contains("exception") || message.isEmpty {
                    return nil
                } else {
                    return message
                }
            }
            
            return nil
        }
        set {
            self["msg"].string = newValue
        }
    }
    
    var code: Int? {
        return self["code"].int
    }
    
    var isSuccessed: Bool {
        get {
            return self["code"].int == 0
        }
    }
}

extension JSON {
    func queryString() -> String {
        return dictionaryObject?.queryString() ?? ""
    }
}

extension Dictionary {
    func queryString() -> String {
        return map { (key, value) -> String in
            return "\(key)=\(value)"
            }.joined(separator: "&").addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? ""
    }
}
