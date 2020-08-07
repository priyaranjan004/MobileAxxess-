//
//  ViewController.swift
//  MobileAxxessAssignment
//
//  Created by Priya Ranjan on 04/08/20.
//  Copyright © 2020 Priya Ranjan. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var dataTableView:UITableView = {
        let dataTable = UITableView()
        dataTable.backgroundColor = .orange
        return dataTable
    }()

    let viewModel = DataViewModel(httpClient: HttpClient())
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setNavingationItems()
        initializeTableViewOnUI()
        self.title = "All Data"
        dataTableView.delegate = self
        dataTableView.dataSource = self
        dataTableView.register(DataTableCell.self, forCellReuseIdentifier: "cell")
        
//        dataTableView.rowHeight = UITableView.automaticDimension //not required because i have used now only two line of data
//        dataTableView.estimatedRowHeight = 2000
        
        viewModel.getAllDataFromDB()
        checkAndCallAPIForData()
        updateTableView()
       
    }
    
    //method to reflect data on ui wehenever change in model
    func updateTableView(){
        viewModel.callForUpdate = {[weak self] in
            DispatchQueue.main.async {
                self?.dataTableView.reloadData()
            }
        }
    }
    
    //method to check ef data not exist in db the call api
    func checkAndCallAPIForData(){
        if let dataList = viewModel.allData{
            if dataList.count == 0{
                viewModel.getAllDataFromAPI()
            }else{
                DispatchQueue.main.async {
                    self.dataTableView.reloadData()
                }
            }
        }else{
            viewModel.getAllDataFromAPI()
        }
    }
    
    func setNavingationItems(){
        let sortBtn   = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortTapped))
        navigationItem.rightBarButtonItems = [sortBtn]
    }
    
    func initializeTableViewOnUI(){
        self.view.addSubview(dataTableView)
        dataTableView.snp.makeConstraints { (make) in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         print("data table \(dataTableView)")
    }
    
    //MARK: - Logics
    @objc func sortTapped(){
        viewModel.sortData()
    }
}


//MARK:- UITableview delegate and datasource methods
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DataTableCell
        cell.setDataOnUI(listData: viewModel.allData![indexPath.row])
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (viewModel.getDataString(at: indexPath.row) != "") ? 125 : 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = getViewController(idenfifier: DetailViewControllerIdentifier, storyboadName: MainStoryboard) as! DetailViewController
        detailVC.listData = viewModel.getSelectdAt(index: indexPath.row)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

