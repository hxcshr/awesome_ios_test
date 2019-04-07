//
//  MVVMViewController.swift
//  GitHub_Pod_Test
//
//  Created by 何学成 on 2019/4/6.
//  Copyright © 2019 com.qudao. All rights reserved.
//

import UIKit
import Cartography

class MVVMViewController: UIViewController {

    let viewModel = MVVMViewModel() // view 层持有 viewModel
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "天行数据"
        view.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 112
        tableView.register(MVVMTableViewCell.self, forCellReuseIdentifier: "cell")
        constrain(view, tableView) { (view, tableView) in
            tableView.edges == view.edges
        }
        

        viewModel.dataSourceObservable.bind(to: tableView.rx.items(cellIdentifier: "cell")) {
            (_ , dd, cell) in
            let cell = cell as! MVVMTableViewCell
            cell.configData(model: dd)
        }.disposed(by: viewModel.disposeBag)

    }
}
