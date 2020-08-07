//
//  DetailViewController.swift
//  MobileAxxessAssignment
//
//  Created by Priya Ranjan on 04/08/20.
//  Copyright © 2020 Priya Ranjan. All rights reserved.
//


import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    var listData:ListData?
    var isUISetupConstraintsDone = false
    let contentView = UIView()
    lazy var dataScrollView:UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    //for image data
    lazy var detailImageView:UIImageView = {
        let detailImageView = UIImageView()
        return detailImageView
    }()
    
    //for text data
    lazy var lblData:UILabel = {
        let lblData = UILabel()
         lblData.numberOfLines = 0
               lblData.lineBreakMode = .byClipping
        return lblData
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        self.view.addSubview(dataScrollView)
        self.dataScrollView.addSubview(contentView)
        
        setDataOnUI()
        // Do any additional setup after loading the view.
        view.setNeedsUpdateConstraints()
    }
    
    
    //MARK: - Set Data at here
    func setDataOnUI() {
        
        if(listData?.type == TypeEnum.text || listData?.type == TypeEnum.other){
            self.contentView.addSubview(lblData)
            lblData.numberOfLines = 0
            lblData.text = listData?.data
        }else{
            self.contentView.addSubview(detailImageView)
            
            if let imageUrl = URL(string: (listData?.data ?? "")) {
                self.detailImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
            }
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
    
    
    override func updateViewConstraints() {
        if (!isUISetupConstraintsDone) {
            dataScrollView.snp.makeConstraints { make in
                make.edges.equalTo(view).inset(UIEdgeInsets.zero)
            }
            contentView.snp.makeConstraints { make in
                make.edges.equalTo(dataScrollView).inset(UIEdgeInsets.zero)
                make.width.equalTo(dataScrollView)
            }
            
            if(listData?.type == TypeEnum.text || listData?.type == TypeEnum.other){
                lblData.snp.makeConstraints { make in
                    make.top.equalTo(contentView).inset(20)
                    make.leading.equalTo(contentView).inset(20)
                    make.trailing.equalTo(contentView).inset(20)
                    make.bottom.equalTo(contentView).inset(20)
                }
            }else{
                detailImageView.snp.makeConstraints { (make) in
                    make.top.leading.trailing.equalTo(self.contentView).inset(10)
                    make.height.equalTo(200)
                }
            }
           
            isUISetupConstraintsDone = true
        }
        super.updateViewConstraints()
    }
}


