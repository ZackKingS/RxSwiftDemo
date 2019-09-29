//
//  SwiftyJSON+Codable.swift
//  JianDeCiShan
//
//  Created by 高炼 on 2019/4/11.
//  Copyright © 2019 BaiYiYuan. All rights reserved.
//

import Foundation
import SwiftyJSON

extension JSONDecoder: Singleton {
    static func createSingleton() -> Any {
        return JSONDecoder()
    }
}

extension JSONEncoder: Singleton {
    static func createSingleton() -> Any {
        return JSONEncoder()
    }
}

extension JSON {
    func codable<T: Codable>(of type: T.Type) -> T? {
        guard let object: Any = dictionaryObject ?? arrayObject else {
            return self.object as? T
        }
        
        return try? JSONDecoder.shared().decode(T.self, from: JSONSerialization.data(withJSONObject: object, options: []))
    }
}
