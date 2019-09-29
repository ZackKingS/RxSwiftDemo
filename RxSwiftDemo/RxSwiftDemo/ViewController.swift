//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by 柏超曾 on 2019/9/29.
//  Copyright © 2019 柏超曾. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var phoneLabel: UITextField!
    
    @IBOutlet weak var pswLabel: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let viewModel = IHLoginViewModel(
            event: loginButton.rx.tap.asSignal(),
            phone: phoneLabel.rx.text.orEmpty.asDriver(),
            password: pswLabel.rx.text.orEmpty.asDriver())
        
        
        
        viewModel.userInput.drive().disposed(by: disposeBag)
        viewModel.result.drive(onNext: { (account, json) in
            if let account = account {
            
                print("------account----")
              
            } else {

            }
        }).disposed(by: disposeBag)
    }

    
    
    @IBAction func login(_ sender: Any) {
        
        
        
    }
    

}

