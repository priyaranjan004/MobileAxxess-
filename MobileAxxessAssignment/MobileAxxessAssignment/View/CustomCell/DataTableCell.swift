//
//  DataTableCell.swift
//  MobileAxxessAssignment
//
//  Created by Priya Ranjan on 04/08/20.
//  Copyright © 2020 Priya Ranjan. All rights reserved.
//

import UIKit
import SnapKit

class DataTableCell: UITableViewCell {
    let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 18.0)
        lbl.textColor = .darkGray
        return lbl
    }()
    
    let lblType: UILabel = {
        let lblType = UILabel()
        lblType.textColor = .lightGray
        return lblType
    }()
    
    let lblDate: UILabel = {
        let lblDate = UILabel()
        lblDate.textColor = .lightGray
        return lblDate
    }()
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      //  self.contentView.backgroundColor = UIColor(red: 153/255, green: 102/255, blue: 51/255, alpha: 1)
        lblTitle.numberOfLines = 2
        self.contentView.addSubview(lblTitle)
        lblTitle.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self.contentView).inset(10)
            make.height.equalTo(50)
        }
        
        self.contentView.addSubview(lblDate)
        lblDate.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.contentView).inset(10)
            make.height.equalTo(21)
            make.top.equalTo(lblTitle.snp.bottom).offset(5)
        }
       
        self.contentView.addSubview(lblType)
        lblType.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.contentView).inset(10)
            make.height.equalTo(21)
            make.top.equalTo(lblDate.snp.bottom).offset(5)
        }
        self.contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setDataOnUI(listData:ListData){
        lblTitle.text = listData.data
        if let dateStr = listData.date{
            lblDate.text = String("Date: - \(dateStr)")
        }
        lblType.text = String("Type: - \(listData.type)")
    }
    
}
