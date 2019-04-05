//
//  POPViewController.swift
//  GitHub_Pod_Test
//
//  Created by mengkezheng on 2019/3/29.
//  Copyright © 2019 com.qudao. All rights reserved.
//

import UIKit
import pop

class POPViewController: UIViewController {
    let orangeView = UIView()
    let ani = POPSpringAnimation(propertyNamed: kPOPViewFrame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        orangeView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        orangeView.backgroundColor = UIColor.orange
        view.addSubview(orangeView)
        
        
        
        
        
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ani?.toValue = CGRect(x: 100, y: 500, width: 50, height: 50)
        ani?.springSpeed = 1;
        ani?.springBounciness = 1;
        orangeView.layer.pop_add(ani, forKey: "framekey")
    }
}
