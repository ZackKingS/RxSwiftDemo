//
//  Alamofire+Reactive.swift
//  Hanwei
//
//  Created by 高炼 on 2019/1/23.
//  Copyright © 2019 BaiYiYuan. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire
import SwiftyJSON

extension DispatchQueue {
    static let swiftyJSONQueue = DispatchQueue(label: "swiftyJSONQueue")
}

typealias Model<T> = (T?, JSON)

extension Reactive where Base: DataRequest {
    func swiftyJSON(_ keyPath: String) -> Observable<JSON> {
        let keys: [JSONSubscriptType] = keyPath.split(separator: ".").map { (substring) -> JSONSubscriptType in
            if let intValue = Int(substring) {
                return intValue
            } else {
                return String(substring)
            }
        }
        
        return swiftyJSON().map { $0[keys] }
    }
    
    func swiftyJSON() -> Observable<JSON> {//处理responseData  Json
        
        return responseData().map({ (_, data) -> JSON in
            
            print("========Alamofire+Reactive=====swiftyJSON============")
            print(JSON(data))
            print("========Alamofire+Reactive=====swiftyJSON============")
            
            return JSON(data)
        })
    }
    
    func codable<T: Codable>(of type: T.Type, keyPath: String? = nil) -> Observable<Model<T>> {
        let keys: [JSONSubscriptType]? = keyPath?.split(separator: ".").map { (substring) -> JSONSubscriptType in
            if let intValue = Int(substring) {
                return intValue
            } else {
                return String(substring)
            }
        }
        
        return swiftyJSON().flatMap({ (json) -> Observable<Model<T>> in
            return Observable<Model<T>>.create({ (observer) -> Disposable in
                DispatchQueue.swiftyJSONQueue.async {
                    if let keys = keys {
                        observer.onNext((json[keys].codable(of: type), json))
                    } else {
                        observer.onNext((json.codable(of: type), json))
                    }
                    observer.onCompleted()
                }
                return Disposables.create()
            })
        }).observeOn(MainScheduler.instance)
    }
}
