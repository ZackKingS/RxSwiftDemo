//
//  NSObject+HasDisposeBag.swift
//
//  Created by 高炼 on 2019/2/25.
//  Copyright © 2019 BaiYiYuan. All rights reserved.
//

import Foundation
import RxSwift

protocol HasDisposeBag {
    var disposeBag: DisposeBag { get set }
    
    static var disposeBag: DisposeBag { get set }
}

private var hasDisposeBagKey = ""

extension HasDisposeBag {
    var disposeBag: DisposeBag {
        get {
            if let disposeBag = objc_getAssociatedObject(self, &hasDisposeBagKey) as? DisposeBag {
                return disposeBag
            }
            
            let disposeBag = DisposeBag()
            objc_setAssociatedObject(self, &hasDisposeBagKey, disposeBag, .OBJC_ASSOCIATION_RETAIN)
            return disposeBag
        }
        set {
            objc_setAssociatedObject(self, &hasDisposeBagKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    static var disposeBag: DisposeBag {
        get {
            if let disposeBag = objc_getAssociatedObject(self, &hasDisposeBagKey) as? DisposeBag {
                return disposeBag
            }
            
            let disposeBag = DisposeBag()
            objc_setAssociatedObject(self, &hasDisposeBagKey, disposeBag, .OBJC_ASSOCIATION_RETAIN)
            return disposeBag
        }
        set {
            objc_setAssociatedObject(self, &hasDisposeBagKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

extension NSObject: HasDisposeBag {}
