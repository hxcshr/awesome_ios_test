
//
//  PromiseKitViewController.swift
//  GitHub_Pod_Test
//
//  Created by mengkezheng on 2019/3/26.
//  Copyright © 2019 com.qudao. All rights reserved.
//

import UIKit
import PromiseKit

class PromiseKitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        firstly {
            URLSession.shared.dataTask(.promise, with: URLRequest(url: URL(string: "https://www.baidu.com")!)).validate()
        }.done { (data: Data, response: URLResponse) in
            print(data,response)
        }.catch { (error) in
            print(error)
        }
    }
}
