//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by 柏超曾 on 2019/9/29.
//  Copyright © 2019 柏超曾. All rights reserved.
//

import UIKit

import UIKit
import RxSwift
import RxCocoa
import SwiftyJSON



class ViewController: UIViewController {

    @IBOutlet weak var phoneLabel: UITextField!
    @IBOutlet weak var pswLabel: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        

        
//        Observable.of(1, 2, 3)
//            .map { $0 * 10}
//            .subscribe(onNext: { print($0) })
//            .disposed(by: disposeBag)
        
        
     
        
        let viewModel = IHLoginViewModel(
            event: loginButton.rx.tap.asSignal(),
            phone: phoneLabel.rx.text.orEmpty.asDriver(),
            password: pswLabel.rx.text.orEmpty.asDriver()
        )
        
        viewModel.result.drive(onNext: { ( account  , json ) in
            
            if let account = account {
                print("------account----\(account.login_name?.stringValue ?? "")")
            }else{
                
            }
            
        }).disposed(by: disposeBag)
        
    }

    @IBAction func login(_ sender: Any) {
        
    }
}

