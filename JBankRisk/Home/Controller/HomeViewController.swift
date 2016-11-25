//
//  HomeViewController.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/8.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//  首页

import UIKit
import SnapKit
import SwiftyJSON
import Alamofire

let homeCellID = "HomeTableViewCell"

class HomeViewController: UIViewController, UIGestureRecognizerDelegate{
    
    var bannerView: CyclePictureView! //图片轮播
    var imageArray:[String]? = [""] //储存所有照片
    
    //cell数据
    var cellDataArray: [Dictionary<String,String>]? = [["":""],["":""],["":""]]

    //判断进行到哪一步
    var flagIndex = 0
    
    //还款状态判断
    var mJstatus = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        //启动滑动返回（swipe back）
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        //读取缓存
        self.getDataFromCache()
        setup()
        initBannerImage()
        
        requestUpdataVersion()
        
    }
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
         self.requestHomeData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
         self.navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //是否允许手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer) {
            //只有二级以及以下的页面允许手势返回
            return (self.navigationController?.viewControllers.count)! > 1
        }
        return true
    }
    
    //基本设置
    func setup(){
        self.view.addSubview(aTableView)
        aTableView.snp.makeConstraints { (mark) in
            mark.width.equalTo(self.view)
            mark.height.equalTo(SCREEN_HEIGHT - 49)
            mark.top.equalTo(0)
        }
        
        self.aTableView.addPullRefreshHandler({ [weak self] in
            self?.requestHomeData()
             self?.aTableView.stopPullRefreshEver()
        })
    }
    
   private lazy var aTableView: UITableView = {
       
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: homeCellID)
        //tableView 单元格分割线的显示
        if tableView.responds(to:#selector(setter: UITableViewCell.separatorInset)) {tableView.separatorInset = .zero
         }
        
        if tableView.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            tableView.layoutMargins = .zero
        }
        return tableView
    }()
    
    //MARK: - 初始化banner轮播图
    func initBannerImage(){
        
        //图片轮播
        bannerView = CyclePictureView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 220*UIRate), imageArray:imageArray!)
//        bannerView.delegate = self
        self.aTableView.tableHeaderView = bannerView
    }
    
    
    func requestHomeData(){
        //添加HUD
        self.showHud(in: self.view)
        var params = NetConnect.getBaseRequestParams()
        params["userId"] = UserHelper.getUserId() ?? ""
        NetConnect.bm_home_url(parameters: params, success:
            { response in
                //隐藏HUD
                self.hideHud()
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                //第一个为1，依次类推
                self.flagIndex = json["flag"].intValue
                //还款状态
                self.mJstatus = json["jstatus"].stringValue
                
                if UserHelper.getUserId() != nil {
                    
                     self.getTheUploadProgree(flag: json["flag"].stringValue,userType:json["userType"].stringValue)
                    
                    self.borrowStatusNotice()//进度弹窗
                }
                self.imageArray = json["bannnerList"].arrayObject as! [String]?
                
                self.cellDataArray = json["list"].arrayObject as? [Dictionary<String, String>]
                UserHelper.setHomeImageData(imageArray: self.imageArray!)
                UserHelper.setHomeCellDataArray(cellArray: self.cellDataArray!)
                self.showData()
                
        }, failure: {error in
            //隐藏HUD
            self.hideHud()
        })
    }
    
    func showData(){
        self.initBannerImage()
        self.aTableView.reloadData()
    }
    
    //读取首页缓存
    func getDataFromCache(){
        self.imageArray = UserHelper.getHomeImageData() ?? [""]
        self.cellDataArray = UserHelper.getHomeCellDataArray()
    }
    
    //老用户判断进程
    func getTheUploadProgree(flag: String, userType: String){
        //flag 进度  1－ 2- 3- 4- 5-   9完成
        if flag == "2"{
            UserHelper.setIdentity(isUpload: true)
        }else if flag == "3"{
            UserHelper.setIdentity(isUpload: true)
            UserHelper.setProduct(isUpload: true)
        }else if flag == "4"{
            UserHelper.setIdentity(isUpload: true)
            UserHelper.setProduct(isUpload: true)
            switch userType {// 1-学生 2- 白领 3－ 自由族 4-未选择
            case "1":
                UserHelper.setSchool(isUpload: true)
            case "2":
                UserHelper.setWork(isUpload: true)
            case "3":
                UserHelper.setContact(isUpload: true)
            default:
                break
            }
            
        }else if flag == "5"{
            UserHelper.setIdentity(isUpload: true)
            UserHelper.setProduct(isUpload: true)
            UserHelper.setContact(isUpload: true)
            
            switch userType {// 1-学生 2- 白领 3－ 自由族 4-未选择
            case "1":
                UserHelper.setSchool(isUpload: true)
            case "2":
                UserHelper.setWork(isUpload: true)
            default:
                break
            }

        }else if flag == "9" {
            
            switch userType {// 1-学生 2- 白领 3－ 自由族 4-未选择
            case "1":
                UserHelper.setSchool(isUpload: true)
            case "2":
                UserHelper.setWork(isUpload: true)
            default:
                break
            }
            UserHelper.setIdentity(isUpload: true)
            UserHelper.setProduct(isUpload: true)
            UserHelper.setContact(isUpload: true)
            UserHelper.setData(isUpload: true)
            UserHelper.setAllFinishIsUpload(isUpload: true)
        }
    }
    
    //进度弹窗
    func borrowStatusNotice(){
        
        guard self.mJstatus != "",
              self.mJstatus != UserHelper.getBorrowStatus()
        else {
            return
        }
        switch mJstatus {
            
        case "0","2","3","4","5","7","8","9":
            UserHelper.setBorrow(status: self.mJstatus)
            //根据status显示
            let popupView = PopupProgressView(status: self.mJstatus)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            
            popupView.onClickSure = {_ in
                popupController.dismiss(animated:true)
            }

        default:
            break
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource,CyclePictureViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeCellID) as! HomeTableViewCell
    
        cell.topTextLabel.text = cellDataArray?[indexPath.row]["show1"]
        cell.bottomTextLabel.text = cellDataArray?[indexPath.row]["show2"]
        switch indexPath.row {
        case 0:
            cell.leftImageView.image = UIImage(named: "home_loan_icon_50x50")
            cell.rightTextLabel.text = "我要借款"
            cell.rightImageView.image = UIImage(named: "home_right_arrow_7x12")
            break
        case 1:
            cell.leftImageView.image = UIImage(named: "home_progress_icon_50x50")
            cell.rightTextLabel.text = "进度查询"
            cell.rightImageView.image = UIImage(named: "home_right_arrow_7x12")
            break
        case 2:
            cell.leftImageView.image = UIImage(named: "home_repayment_icon_50x50")
            cell.rightTextLabel.text = "我要还款"
            cell.rightImageView.image = UIImage(named: "home_right_arrow_7x12")
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            //保证有userId 和 角色已选
            guard (UserHelper.getUserId() != nil) && (UserHelper.getUserRole() != nil) else {
                
                let popupView =  PopupSelectRoleView(currentIndex: -1)
                let popupController = CNPPopupController(contents: [popupView])!
                popupController.theme.presentationStyle = .slideInFromRight
                popupController.theme.dismissesOppositeDirection = false
                popupController.theme.animationDuration = 0.6
                popupController.present(animated: true)
                popupView.onClickCloseBtn = { _ in
                    popupController.dismiss(animated: true)
                }
                popupView.onClickSelect = { role in
                    popupController.dismiss(animated: true)
                    UserHelper.setUserRole(role: role.rawValue)
                    let borrowMoneyVC = BorrowMoneyViewController()
                    self.navigationController?.pushViewController(borrowMoneyVC, animated: false)
                }
                return
        }
            let borrowMoneyVC = BorrowMoneyViewController()
            borrowMoneyVC.currentIndex = self.flagIndex - 1
            self.navigationController?.pushViewController(borrowMoneyVC, animated: false)
            
        case 1:
            guard UserHelper.isLogin() else {
                let loginVC = LoginViewController()
                self.navigationController?.pushViewController(loginVC, animated: true)
                return
            }
            let repayDetailVC = BorrowStatusVC()
            //9 为不加载缺省页
            if self.flagIndex == 9 {
                repayDetailVC.isHaveData = true
            }else {
                repayDetailVC.isHaveData = false
            }
            self.navigationController?.pushViewController(repayDetailVC, animated: true)
        case 2:
            guard UserHelper.isLogin() else {
                let loginVC = LoginViewController()
                self.navigationController?.pushViewController(loginVC, animated: true)
                return
            }
            
               let repayDetailVC = RepayBillViewController()
               // 5-还款中 0-已完结
                if mJstatus == "5" || mJstatus == "0"{
                    repayDetailVC.isHaveData = true
                }else {
                    repayDetailVC.isHaveData = false
                }

                self.navigationController?.pushViewController(repayDetailVC, animated: true)
        default:
            break
        }
    }
    
    //设置分割线
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = .zero
        }
        if cell.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            cell.layoutMargins = .zero
        }
    }
    
    //请求版本更新
    func requestUpdataVersion(){
        
        var params = NetConnect.getBaseRequestParams()
        params["channel"] = "3"
        params["versionCode"] = APP_VERSION_CODE
        
        NetConnect.other_updata_version(parameters: params, success:
            { response in
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                    }
                
                //0-无更新 1-有更新 2-强制更新
                if json["vjstatus"].stringValue == "1" || json["vjstatus"].stringValue == "2" {
                    let popupView =  PopupNewVersionView(disText: json["updateDesc"].stringValue)
                    let popupController = CNPPopupController(contents: [popupView])!
                    popupController.present(animated: true)
                    popupView.onClickCancle = { _ in
                        
                        if json["vjstatus"].stringValue == "2" {
                            //强制更新，弹窗消不去
                        }else {
                             popupController.dismiss(animated: true)
                        }
                    }
                    //升级
                    popupView.onClickSure = { _ in
                        let appstoreUrl = json["updateUrl"].stringValue
                        let url = URL(string: appstoreUrl)
                        if let url = url {
                             UIApplication.shared.openURL(url)
                        }
                    }
                }
        }, failure: {error in
            
        })
    }
    
    
    //MARK: - CyclePictureViewDelegate的方法(点击跳转)
    func cyclePictureSkip(To index: Int) {
        //        let bannerUrlVC = BaseWebViewController()
        //        bannerUrlVC.requestUrl = self.urlArray?[index] as? String
        //        self.navigationController?.pushViewController(bannerUrlVC, animated: false
        //        )
    }
    
}
