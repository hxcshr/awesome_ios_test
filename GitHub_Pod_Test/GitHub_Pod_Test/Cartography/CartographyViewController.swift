//
//  CartographyViewController.swift
//  GitHub_Pod_Test
//
//  Created by mengkezheng on 2019/3/26.
//  Copyright © 2019 com.qudao. All rights reserved.
//

import UIKit
import Cartography

class CartographyViewController: UIViewController {

    let redView = UIView()
    let greenView = UIView()
    let blueView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(redView)
        view.addSubview(greenView)
        view.addSubview(blueView)
        
        redView.backgroundColor = UIColor.red
        greenView.backgroundColor = UIColor.green
        blueView.backgroundColor = UIColor.blue
        
        constrain(redView) { (redView) in
            redView.width == 100
            redView.height == 100
        }
        
        constrain(view,redView) { (view,redView) in
            redView.left == view.left + 16
            redView.top == view.top + 44 + 16 + UIApplication.shared.statusBarFrame.size.height
        }
        
        constrain(redView,greenView,blueView) { (redView,greenView,blueView) in
            greenView.left == redView.right + 16
            greenView.top == redView.bottom + 16
            greenView.width == redView.width
            greenView.height == redView.height
            
            blueView.left == greenView.right + 16
            blueView.top == greenView.bottom + 16
            blueView.width == redView.width
            blueView.height == redView.height

        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
