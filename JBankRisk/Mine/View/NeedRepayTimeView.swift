//
//  NeedRepayTimeView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/13.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class NeedRepayTimeView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    let dataArray:[String] = ["全部应还","本月应还","近7日应还","今日应还"]
    
    var onClickCell:((_ title: String,_ index: Int)->())?
    //选中的cell
    var selectCell: Int = 0
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
    }
    
    ///初始化默认frame
    convenience init() {
        let frame = CGRect()
        self.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: CGFloat(dataArray.count)*45*UIRate)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.addSubview(aTableView)
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(self)
            make.centerX.equalTo(self)
            make.top.equalTo(0)
        }
        
        let indexPath = IndexPath(row: selectCell, section: 0)
        aTableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
        aTableView.deselectRow(at: indexPath, animated: true)
    }
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.register(RepayDetailTableViewCell.self, forCellReuseIdentifier: "CellID")
        
        //tableView 单元格分割线的显示
        tableView.separatorInset = UIEdgeInsets.zero
        return tableView
        
    }()
    //MARK: - UITableView Delegate&&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID") as! RepayDetailTableViewCell
       
        cell.arrowImageView.isHidden = true
        
        cell.textLabel?.text = dataArray[indexPath.row]
        if indexPath.row == selectCell {
            cell.checkImage.isHidden = false
        }else {
            cell.checkImage.isHidden = true
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectCell = indexPath.row
        self.aTableView.reloadData()
        if let onClickCell = onClickCell {
            onClickCell(dataArray[indexPath.row], indexPath.row + 1)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45*UIRate
    }
}
