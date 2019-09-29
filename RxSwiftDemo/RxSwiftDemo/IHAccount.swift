//
//  IHAccount.swift
//  InternetHospital
//
//  Created by Trinity on 2019/5/27.
//  Copyright © 2019 GaoLian. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyJSON

protocol DictionaryValue {
    var value: Any { get }
}

extension Int: DictionaryValue { var value: Any { return self } }
extension Float: DictionaryValue { var value: Any { return self } }
extension String: DictionaryValue { var value: Any { return self } }
extension Bool: DictionaryValue { var value: Any { return self } }

extension DictionaryValue {
    var value: Any {
        let mirror = Mirror(reflecting: self)
        var result = [String: Any]()
        for child in mirror.children {
            // 如果无法获得正确的 key，报错
            guard let key = child.label else {
                fatalError("Invalid key in child: \(child)")
            }
            // 如果 value 无法转换为 DictionaryValue，报错
            if let value = child.value as? DictionaryValue {
                result[key] = value.value
            } else {
                fatalError("Invalid value in child: \(child)")
            }
        }
        return result
    }
}

extension IHURL {
    static let login = IHURL(rawValue: "api/user/login")
    static let register = IHURL(rawValue: "api/user/register")
    static let getSMSCode = IHURL(rawValue: "api/user/getSmsAuthCode")
    static let resetPassword = IHURL(rawValue: "api/user/pwd_forget")
    static let updatePassword = IHURL(rawValue: "api/user/update_passwd")
    static let autoLogin = IHURL(rawValue: "api/user/login/auto")
}

enum IHUserType: String, Codable {
    case administrator = "0"
    case patient = "1"
    case doctor = "2"
}

class IHAccount:  Codable, ReactiveCompatible ,DictionaryValue{
    var login_name: JSON?
    var medicare_card: JSON?
    var patient_type: JSON?
    var phone: JSON?
    var near_login_time: JSON?
    var cert_front_key: JSON?
    var patient_id: JSON?
    var sex: JSON?
    var cert_front: JSON?
    var nation_name: JSON?
    var is_effective: JSON?
    var medicare_card_image: JSON?
    var head_portrait: JSON?
    var device_token: JSON?
    var isreal: JSON?
    var card_no: JSON?
    var user_type: IHUserType?
    var cert_back_key: JSON?
    var cert_id: JSON? //身份证
    var cert_back: JSON?
    var patient_name: JSON?
    var cookies: JSON?
    
    var netease_token: JSON?
    var netease_id: JSON?
    
    static var shared: IHAccount? {
        didSet {
            shared?.loginNIM()
        }
    }
}

extension IHAccount {
    func loginNIM() {
        if let account = netease_id?.string,
            let token = netease_token?.string {
//            NIMSDK.shared().loginManager.login(account, token: token) { (error) in
//                if let error = error {
//                    print(error)
//                } else {
//                    print("云信登录成功")
//
//                }
//            }
        }
    }
}

extension IHAccount: AlamofireUtilities {
}

extension Reactive where Base: IHAccount {
    
    static func register(phone: String, password: String, verifyCode: String) -> Observable<Model<Bool>> {
        return IHAccount.post(.register, params: [String: Any]().mutate { params in
            params["login_name"] = phone
            params["login_passwd"] = password
            params["phone_verify_code"] = verifyCode
        }).rx.swiftyJSON().map({ (json) -> Model<Bool> in
            return (json.isSuccessed, json)
        })
    }
    
    static func login(phone: String, password: String) -> Observable<Model<IHAccount>> {
        return IHAccount.post(.login, params: [String: Any]().mutate { params in
            params["login_name"] = phone
            params["login_passwd"] = password
            params["user_type"] = IHUserType.patient.rawValue
        }).rx.codable(of: IHAccount.self, keyPath: "data")
            .do(onNext: { (account, json) in
                
                //拿到netease_token  netease_id 后 登陆云信
                IHAccount.shared = account
            })
    }
    
    static func resetPassword(phone: String, password: String, verifyCode: String) -> Observable<Model<Bool>> {
        return IHAccount.post(.resetPassword, params: [String: Any]().mutate { params in
            params["login_name"] = phone
            params["new_passwd"] = password
            params["phone_verify_code"] = verifyCode
            params["user_type"] = IHUserType.patient.rawValue
        }).rx.swiftyJSON().map({ (json) -> Model<Bool> in
            return (json.isSuccessed, json)
        })
    }
    
    static func getSMSCode(phone: String , is_forget: String) -> Observable<Model<Bool>> {
        return IHAccount.post(.getSMSCode, params: [String: Any]().mutate { params in
            params["phone"] = phone
            params["is_forget"] = is_forget
        }).rx.swiftyJSON().map({ (json) -> Model<Bool> in
            return (json.isSuccessed, json)
        })
    }
    
    static func updatePassword(old: String, new: String) -> Observable<Model<Bool>> {
        return IHAccount.post(.updatePassword, params: [String: Any]().mutate { params in
            params["old_passwd"] = old
            params["new_passwd"] = new
        }).rx.swiftyJSON().map { (json) -> Model<Bool> in
            return (json.isSuccessed, json)
        }
    }
    
    static func logout() -> Observable<Model<Bool>> {
        return Observable<Model<Bool>>.just((true, JSON()))
            .do(onNext: { (success, json) in
                //1.cookies
                HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
                
               
            })
    }
    
    static func autoLogin() -> Observable<Model<IHAccount>> {
        return IHAccount.post(.autoLogin)
            .rx.codable(of: IHAccount.self, keyPath: "data")
            .do(onNext: { (account, json) in
                //拿到netease_token  netease_id 后 登陆云信
                IHAccount.shared = account
            })
    }
    
    
    
}
