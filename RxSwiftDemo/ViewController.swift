//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by Ahmed Ali Henawey on 17/01/2018.
//  Copyright © 2018 Ahmed Ali Henawey. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Worker()
            .request()
            .mapObject([String: [Time]].self)
            .strip()
            .subscribe(onNext: { (model) in
                print(model)
            }, onError: { (error) in
                print(error.localizedDescription)
            }).disposed(by: bag)
    }
}
