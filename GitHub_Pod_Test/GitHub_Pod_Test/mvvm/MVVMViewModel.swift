//
//  MVVMViewModel.swift
//  GitHub_Pod_Test
//
//  Created by 何学成 on 2019/4/6.
//  Copyright © 2019 com.qudao. All rights reserved.
//

import UIKit
import RxSwift
import HandyJSON

class MVVMViewModel {
    
    let dataSourceObservable :Observable<[MVVMModel]>
    
    let disposeBag = DisposeBag()
    
    init() {
        
        let urlStr = "https://api.tianapi.com/meinv/?key=20dd4620e06b0e108d3e081bb981f710&num=20"
        let url = URL(string: urlStr)
        let request = URLRequest(url: url!)
        
        dataSourceObservable = URLSession.shared.rx.json(request: request).map { (result) -> [MVVMModel] in
            if let data = result as? [String: Any],
                let channels = data["newslist"] as? [[String: Any]] {
                let tmparr = [MVVMModel].deserialize(from: channels)
                return tmparr as! [MVVMModel]
            }else {
                return []
            }
        }
        
    }
    
    
    
}
