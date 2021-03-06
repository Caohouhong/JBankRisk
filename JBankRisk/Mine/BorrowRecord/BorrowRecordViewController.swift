//
//  BorrowRecordViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/3.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class BorrowRecordViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var dataArray = [JSON]()
    
    //是否有数据
    var isHaveData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: -基本UI
    func setupUI(){
        self.navigationItem.title = "借款记录"
        self.view.backgroundColor = defaultBackgroundColor
        
        if isHaveData {
            setupNormalUI()
            //刷新
            self.aTableView.addPullRefreshHandler({[weak self] _ in
                self?.requestData()
            })
            self.aTableView.startPullRefresh()
            
        }else{
           self.setupDefaultUI()
        }
    }
    
    func setupDefaultUI(){
        self.view.addSubview(defaultView)
        
        defaultView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - TopFullHeight)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view)
        }

        //去申请回调
        defaultView.onClickApplyAction = {[unowned self] _ in
            if UserHelper.getUserRole() == nil {
                UserHelper.setUserRole(role: "白领")
            }
            let borrowMoneyVC = BorrowMoneyViewController()
            borrowMoneyVC.currentIndex = 0
            self.navigationController?.pushViewController(borrowMoneyVC, animated: false)
        }
    }
    
    func setupNormalUI(){
        self.view.addSubview(aTableView)
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - TopFullHeight)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view)
        }
        self.initHeader()
    }
    
    //header
    func initHeader(){
        let headerHoldView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 206*UIRate))
        headerHoldView.backgroundColor = UIColorHex("000000")
        
        self.aTableView.tableHeaderView = headerHoldView
        
        headerHoldView.addSubview(topImageView)
        self.topImageView.addSubview(totalTextLabel)
        self.topImageView.addSubview(moneyLabel)
        
        headerHoldView.addSubview(iconHoldView)
        self.iconHoldView.addSubview(iconImageView)
        self.iconHoldView.addSubview(recodeTextLabel)
        self.iconHoldView.addSubview(divideLine1)

        topImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(156*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(0)
        }
        
        totalTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(40*UIRate)
        }
        
        moneyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(totalTextLabel.snp.bottom).offset(23*UIRate)
        }
        
        iconHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(50*UIRate)
            make.top.equalTo(topImageView.snp.bottom)
            make.centerX.equalTo(self.view)
        }
        
        recodeTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30*UIRate)
            make.centerY.equalTo(topImageView.snp.bottom).offset(25*UIRate)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(20*UIRate)
            make.right.equalTo(recodeTextLabel.snp.left)
            make.centerY.equalTo(recodeTextLabel)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(topImageView.snp.bottom).offset(50*UIRate)
        }
    }
    
       /********/
    //借款纪录缺省页
    private lazy var defaultView: BorrowDefaultView = {
        let holdView = BorrowDefaultView(viewType: BorrowDefaultView.BorrowDefaultViewType.borrowRecord)
        return holdView
    }()
    
    //图片
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_banner_image2_375x156")
        return imageView
    }()
    
    private lazy var totalTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "累计成功借款(元)"
        return label
    }()
    
    private lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 30*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "0.00"
        return label
    }()
    
    private lazy var iconHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()

    //图片
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_bm_record_20x20")
        return imageView
    }()
    
    private lazy var recodeTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "借款记录"
        return label
    }()

    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(BorrowRecordTableViewCell.self, forCellReuseIdentifier: "borrowCellID")
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "borrowCellID") as! BorrowRecordTableViewCell
        
        cell.leftTextLabel.text = dataArray[indexPath.row]["orderName"].stringValue
        cell.rightTextLabel.text = dataArray[indexPath.row]["status"].stringValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //录入中 进入借款流程
        if dataArray[indexPath.row]["status"].stringValue == "录入中" {
            let borrowMoneyVC = BorrowMoneyViewController()
            self.navigationController?.pushViewController(borrowMoneyVC, animated: false)
        }else {
            let borrowStatusVC = BorrowStatusVC()
            borrowStatusVC.orderId = dataArray[indexPath.row]["orderId"].stringValue
            self.navigationController?.pushViewController(borrowStatusVC, animated: true)
        }
    }

    //MARK: - 请求数据
    func requestData(){
        var params = NetConnect.getBaseRequestParams()
        params["userId"] = UserHelper.getUserId()
        params["pFlag"] = "1"//固定值，用来区分返回的金额数值
        
        NetConnect.pc_borrow_record(parameters: params, success: { response in
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
            self.refreshUI(json: json)
            
            self.aTableView.stopPullRefreshEver()
            
        }, failure:{ error in
            self.aTableView.stopPullRefreshEver()
            self.showHint(in: self.view, hint: "网络请求失败")
        })
    }
    
    //刷新界面
    func refreshUI(json: JSON){
        let money = json["totalMoney"].doubleValue
        self.moneyLabel.text = toolsChangeMoneyStyle(amount: money)
        self.dataArray.removeAll()
        self.dataArray = json["orderList"].arrayValue
        self.aTableView.reloadData()
    }

}
