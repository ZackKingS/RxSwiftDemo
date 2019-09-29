//
//  IHURL.swift
//  JianDeCiShan
//
//  Created by 高炼 on 2019/5/6.
//  Copyright © 2019 BaiYiYuan. All rights reserved.
//

import UIKit
import Alamofire

class IHURL: RawRepresentable, URLConvertible, Equatable {
    typealias RawValue = String
    var rawValue: String
    
    required init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    func asURL() throws -> URL {
        
        return URL(string: "\(IHAppConfiguration.shared()._nethhost)/\(rawValue)")!
    }
}
