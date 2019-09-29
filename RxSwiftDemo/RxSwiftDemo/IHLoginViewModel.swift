//
//  IHLoginViewModel.swift
//  InternetHospital
//
//  Created by Trinity on 2019/5/27.
//  Copyright © 2019 GaoLian. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyJSON

class IHLoginViewModel: NSObject {
    var isLoading: Driver<Bool> = .empty()
    var isLoginEnable: Driver<Bool> = .empty()
    var result: Driver<Model<IHAccount>> = .empty()
    var userInput: Driver<Void> = .empty()
    
    init(event: Signal<Void>,
         phone: Driver<String>,
         password: Driver<String>) {
        let isPhoneValid = phone.map { $0.matches(.phone) }
        let isPasswordValid = password.map { $0.matches(.custom("[0-9]{6}")) }
        
        let isLoading = ActivityIndicator()
        self.isLoading = isLoading.asDriver()
        
        isLoginEnable = Driver.combineLatest(isLoading, isPhoneValid, isPasswordValid).map { !$0 && $1 && $2 }
        
        result = event.withLatestFrom(isLoginEnable).filter { $0 }
            .withLatestFrom(Driver.combineLatest(phone, password))
            .flatMapLatest({ (phone, password) -> Driver<Model<IHAccount>> in
                return IHAccount.rx.login(phone: phone, password: password)
                    .trackActivity(isLoading)
                    .asDriver(onErrorJustReturn: (nil, JSON()))
            })
        
        userInput = event.asDriver(onErrorJustReturn: ())
            .withLatestFrom(Driver.combineLatest(isPhoneValid, isPasswordValid))
            .do(onNext: { (phoneValid, passwordValid) in
                guard phoneValid else {
//                    showDanger("请输入正确手机号")
                    return
                }
                
                guard passwordValid else {
//                    showDanger("请输入6位数字密码")
                    return
                }
            }).map { _ -> Void in }
    }
    
   
}
