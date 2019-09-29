//
//  Singleton.swift
//
//
//  Created by 高炼 on 2019/3/13.
//  Copyright © 2019 BaiYiYuan. All rights reserved.
//

import Foundation

protocol Singleton: AnyObject {
    static func shared() -> Self
    static func setShared(_ obj: Self) -> Void
    static func createSingleton() -> Any
}

private var singletonKey = ""

extension Singleton {
    static func shared() -> Self {
        if _share_instance == nil {
            _share_instance = castOrFatalError(createSingleton())
        }
        
        return _share_instance
    }
    
    static func setShared(_ obj: Self) -> Void {
        _share_instance = obj
    }
}

extension Singleton {
    fileprivate static var _share_instance: Self! {
        get {
            return objc_getAssociatedObject(self, &singletonKey) as? Self
        }
        set {
            objc_setAssociatedObject(self, &singletonKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

fileprivate func castOrFatalError<T>(_ value: Any) -> T {
    if let castValue = value as? T {
        return castValue
    } else {
        fatalError("Can't cast \(value) to \(T.self)")
    }
}
