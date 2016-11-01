//
//  IdentityViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/10/31.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class IdentityViewController: UIViewController {

    var mTimer: Timer!
    var seconds: Int = 60
    var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

       self.setupUI()
       getCurrentIndex()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    func getCurrentIndex(){
        
        roleLabel.text = UserHelper.getUserRole()
        switch UserHelper.getUserRole() {
        case "学生":
            currentIndex = 0
        case "白领":
            currentIndex = 1
        case "自由族":
            currentIndex = 2
        default:
            break
        }
    }

    func setupUI(){
        self.title = "身份信息"
        self.view.backgroundColor = defaultBackgroundColor
        
        self.view.addSubview(topHoldView)
        self.topHoldView.addSubview(divideLine11)
        self.topHoldView.addSubview(divideLine12)
        self.topHoldView.addSubview(selectRoleLabel)
        self.topHoldView.addSubview(roleLabel)
        self.topHoldView.addSubview(arrowImageView)
        self.topHoldView.addSubview(selectRoleBtn)
        /******/
        self.view.addSubview(centerHoldView)
        self.centerHoldView.addSubview(divideLine21)
        self.centerHoldView.addSubview(divideLine22)
        self.centerHoldView.addSubview(divideLine23)
        self.centerHoldView.addSubview(phoneTextLabel)
        self.centerHoldView.addSubview(randCodeLabel)
        self.centerHoldView.addSubview(phoneNumField)
        
        self.centerHoldView.addSubview(clearImage)
        self.centerHoldView.addSubview(clearBtn)
        self.centerHoldView.addSubview(shuDivideLine)
        self.centerHoldView.addSubview(sendCodeBtn)
        self.centerHoldView.addSubview(codeTextField)
        /********/
        self.view.addSubview(idCardholdView)
        self.idCardholdView.addSubview(divideLine31)
        self.idCardholdView.addSubview(divideLine32)
        self.idCardholdView.addSubview(idImageView)
        self.idCardholdView.addSubview(idTextLabel1)
        self.idCardholdView.addSubview(idTextLabel2)
        self.idCardholdView.addSubview(idArrowImageView)
        self.idCardholdView.addSubview(idCardBtn)
        /*********/
        self.view.addSubview(bottomHoldView)
        self.bottomHoldView.addSubview(divideLine41)
        self.bottomHoldView.addSubview(divideLine42)
        self.bottomHoldView.addSubview(divideLine43)
        self.bottomHoldView.addSubview(nameTextLabel)
        self.bottomHoldView.addSubview(idNumLabel)
        
        /********/
        self.view.addSubview(nextStepBtn)
        
        topHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(60*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(10*UIRate + 64)
        }
        
        divideLine11.snp.makeConstraints { (make) in
            make.width.equalTo(topHoldView)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(topHoldView)
            make.top.equalTo(topHoldView)
            
        }
        
        divideLine12.snp.makeConstraints { (make) in
            make.width.equalTo(topHoldView)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(topHoldView)
            make.bottom.equalTo(topHoldView)
            
        }
        selectRoleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15*UIRate)
            make.centerY.equalTo(topHoldView)
        }

        roleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(100*UIRate)
            make.centerY.equalTo(selectRoleLabel)
        }

        arrowImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7*UIRate)
            make.height.equalTo(12*UIRate)
            make.right.equalTo(self.view.snp.right).offset(-15*UIRate)
            make.centerY.equalTo(selectRoleLabel)
            
        }
        
        selectRoleBtn.snp.makeConstraints { (make) in
            make.size.equalTo(topHoldView)
            make.center.equalTo(topHoldView)
        }

        /******/
        centerHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(100*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(topHoldView.snp.bottom).offset(10*UIRate)
        }
        
        divideLine21.snp.makeConstraints { (make) in
            make.width.equalTo(centerHoldView)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(centerHoldView)
            make.top.equalTo(centerHoldView)
            
        }
        
        divideLine22.snp.makeConstraints { (make) in
            make.width.equalTo(centerHoldView)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(centerHoldView)
            make.centerY.equalTo(centerHoldView)
            
        }
        
        divideLine23.snp.makeConstraints { (make) in
            make.width.equalTo(centerHoldView)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(centerHoldView)
            make.bottom.equalTo(centerHoldView)
        }

        phoneTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15*UIRate)
            make.centerY.equalTo(centerHoldView).offset(-25*UIRate)
        }
        
        randCodeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(phoneTextLabel)
           make.centerY.equalTo(centerHoldView).offset(25*UIRate)
        }

        phoneNumField.snp.makeConstraints { (make) in
            make.width.equalTo(150*UIRate)
            make.left.equalTo(100*UIRate)
            make.centerY.equalTo(phoneTextLabel)
            
        }

        clearImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(15*UIRate)
            make.right.equalTo(centerHoldView.snp.right).offset(-102*UIRate)
            make.centerY.equalTo(phoneTextLabel)
        }

        clearBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(clearImage).inset(UIEdgeInsetsMake(-10, -10, -10, -5))
        }
        shuDivideLine.snp.makeConstraints { (make) in
            make.width.equalTo(0.5*UIRate)
            make.height.equalTo(20*UIRate)
            make.left.equalTo(centerHoldView.snp.right).offset(-97*UIRate)
            make.centerY.equalTo(clearImage)
        }
        
        sendCodeBtn.snp.makeConstraints { (make) in
            make.width.equalTo(95*UIRate)
            make.height.equalTo(50*UIRate)
            make.right.equalTo(centerHoldView)
            make.centerY.equalTo(phoneTextLabel)
        }

        codeTextField.snp.makeConstraints { (make) in
            make.left.equalTo(100*UIRate)
            make.centerY.equalTo(randCodeLabel)
        }

        /******/
        idCardholdView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(60*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(centerHoldView.snp.bottom).offset(10*UIRate)
        }
        
        divideLine31.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(idCardholdView)
        }
        
        divideLine32.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(idCardholdView)
        }
        
        idImageView.snp.makeConstraints { (make) in
            make.width.equalTo(65*UIRate)
            make.height.equalTo(43*UIRate)
            make.left.equalTo(15*UIRate)
            make.centerY.equalTo(idCardholdView)
        }

        idTextLabel1.snp.makeConstraints { (make) in
            make.top.equalTo(13*UIRate)
            make.left.equalTo(100*UIRate)
        }

        idTextLabel2.snp.makeConstraints { (make) in
            make.left.equalTo(idTextLabel1)
            make.top.equalTo(idTextLabel1.snp.bottom).offset(5*UIRate)
        }

        idArrowImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7*UIRate)
            make.height.equalTo(12*UIRate)
            make.right.equalTo(idCardholdView.snp.right).offset(-15*UIRate)
            make.centerY.equalTo(idCardholdView)
        }
        
        idCardBtn.snp.makeConstraints { (make) in
            make.size.equalTo(idCardholdView)
            make.center.equalTo(idCardholdView)
        }
       /**********/
        bottomHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(92*UIRate)
            make.top.equalTo(idCardholdView.snp.bottom).offset(-2*UIRate)
            make.centerX.equalTo(self.view)
        }

        divideLine41.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 100*UIRate)
            make.height.equalTo(0.5*UIRate)
            make.left.equalTo(100*UIRate)
            make.top.equalTo(bottomHoldView).offset(2*UIRate)
        }
        
        divideLine42.snp.makeConstraints { (make) in
            make.size.equalTo(divideLine41)
            make.left.equalTo(100*UIRate)
            make.centerY.equalTo(divideLine41).offset(45*UIRate)
        }
        
        divideLine43.snp.makeConstraints { (make) in
            make.width.equalTo(bottomHoldView)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(bottomHoldView)
            make.bottom.equalTo(bottomHoldView)        }

        nameTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(100*UIRate)
            make.centerY.equalTo(divideLine41).offset(22.5*UIRate)
        }

        idNumLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameTextLabel)
            make.centerY.equalTo(nameTextLabel).offset(45*UIRate)
        }
        
        nextStepBtn.snp.makeConstraints { (make) in
            make.width.equalTo(345*UIRate)
            make.height.equalTo(44*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-10*UIRate)
        }

        
    }
    
    private lazy var topHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //分割线
    private lazy var divideLine11: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    //分割线
    private lazy var divideLine12: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    private lazy var selectRoleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "选择角色"
        return label
    }()
    
    private lazy var roleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()

    //图片
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_right_arrow_7x12")
        return imageView
    }()
    
    private lazy var selectRoleBtn: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectRoleBtnAction), for: .touchUpInside)
        return button
    }()
    
    /******/
    private lazy var centerHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //分割线
    private lazy var divideLine21: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    //分割线
    private lazy var divideLine22: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    //分割线
    private lazy var divideLine23: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    private lazy var phoneTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "手机号码"
        return label
    }()

    private lazy var randCodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "验证码"
        return label
    }()

    
    ///手机号码输入框
    private lazy var phoneNumField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入手机号码"
        textField.keyboardType = .numberPad
        textField.tag = 10000
        textField.addTarget(self, action: #selector(textFieldAction(_:)), for: .editingChanged)
        return textField
    }()
    
    ///清除按钮
    private lazy var clearImage: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(named: "login_btn_clear_15x15")
        return imageView
    }()
    
    private lazy var clearBtn: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(clearBtnAction), for: .touchUpInside)
        return button
    }()
    
    //分割线
    private lazy var shuDivideLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColorHex("666666", 0.8)
        return lineView
    }()

    
    ///验证码输入框
    private lazy var codeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入验证码"
        textField.keyboardType = .numberPad
        textField.tag = 10001
        textField.addTarget(self, action: #selector(textFieldAction(_:)), for: .editingChanged)
        return textField
    }()
    
    ///发送验证码按钮
    private lazy var sendCodeBtn: UIButton = {
        let button = UIButton()
        button.setTitle("获取验证码", for: UIControlState.normal)
        button.titleLabel?.font = UIFontSize(size: 15*UIRate)
        button.setTitleColor(UIColorHex("00b2ff"), for: .normal)
        button.addTarget(self, action: #selector(sendCodeBtnAction), for: .touchUpInside)
        return button
    }()
    
    /************/
    private lazy var idCardholdView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //分割线
    private lazy var divideLine31: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
 
    //分割线
    private lazy var divideLine32: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    //图片
    private lazy var idImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bm_idCard_undo_65x43")
        return imageView
    }()
    
    private lazy var idTextLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "身份证自动识别"
        return label
    }()

    private lazy var idTextLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("d4d4d4")
        label.text = "实名认证更快捷"
        return label
    }()

    //尖头
    private lazy var idArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_right_arrow_7x12")
        return imageView
    }()
    
    
    private lazy var idCardBtn: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(idCardBtnAction), for: .touchUpInside)
        return button
    }()
    
    /*********/
    private lazy var bottomHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //分割线
    private lazy var divideLine41: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    //分割线
    private lazy var divideLine42: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    //分割线
    private lazy var divideLine43: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    private lazy var nameTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "hah"
        return label
    }()

    private lazy var idNumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "hah"
        return label
    }()

    //／确认按钮
    private lazy var nextStepBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "login_btn_grayred_345x44"), for: .normal)
        button.isUserInteractionEnabled = false
        button.setTitle("下一步", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(nextStepBtnAction), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Action
    func textFieldAction(_ textField: UITextField){
        //tag: 10000手机号  10001:验证码
        if textField.tag == 10000 {
            //限制输入的长度，最长为11位
            if (textField.text?.characters.count)! > 11{
                let index = textField.text?.index((textField.text?.startIndex)!, offsetBy: 11)//到offsetBy的前一位
                textField.text = textField.text?.substring(to: index!)
            }
            
            if (textField.text?.characters.count)! > 0{
                clearImage.isHidden = false
            }else {
                clearImage.isHidden = true
            }
            
        }else {
            //限制输入的长度，最长为4位
            if (textField.text?.characters.count)! > 4{
                let index = textField.text?.index((textField.text?.startIndex)!, offsetBy: 4)//到offsetBy的前一位
                textField.text = textField.text?.substring(to: index!)
            }
        }
    }
    
    //MARK:- Action
    func selectRoleBtnAction(){
        
        let popupView =  PopupSelectRoleView(currentIndex: self.currentIndex)
        let popupController = CNPPopupController(contents: [popupView])!
        popupController.theme.presentationStyle = .slideInFromRight
        popupController.theme.dismissesOppositeDirection = false
        popupController.present(animated: true)
        popupView.onClickCloseBtn = { _ in
            popupController.dismiss(animated: true)
        }
        popupView.onClickSelect = { role in
            popupController.dismiss(animated: true)
            UserHelper.setUserRole(role: role.rawValue)
            self.getCurrentIndex()
        }
    }
    
    func clearBtnAction(){
        phoneNumField.text = ""
        clearImage.isHidden = true
    }
    
    //发送验证码按钮
    func sendCodeBtnAction(){
        
        let phoneNum = phoneNumField.text!
        guard (phoneNumField.text?.characters.count)! == 11 else {
            self.showHint(in: self.view, hint: "请输入正确的手机号码")
            return
        }
        self.startCount()
        self.sendRandomCodeTo(number: phoneNum)
    }
    
    func nextStepBtnAction(){
        
    }
    
    func idCardBtnAction(){
        
    }
    
    
    //MARK: - Timer
    func startCount(){
        seconds = 60
        sendCodeBtn.isUserInteractionEnabled = false
        mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown(_:)), userInfo: nil, repeats: true)
    }
    
    //时间倒计时
    func countDown(_ timer: Timer){
        if seconds > 0{
            seconds -= 1
            sendCodeBtn.setTitle("\(seconds)s后重发", for: .normal)
            sendCodeBtn.setTitleColor(UIColorHex("666666"), for: .normal)
        }else if seconds == 0{
            timer.invalidate()
            sendCodeBtn.isUserInteractionEnabled = true
            sendCodeBtn.setTitle("重新发送", for: UIControlState.normal)
            sendCodeBtn.setTitleColor(UIColorHex("00b2ff"), for: .normal)
        }
        
    }
    
    ///发送验证码
    func sendRandomCodeTo(number: String){
        var params = NetConnect.getBaseRequestParams()
        params["mobile"] = number
        NetConnect.rl_randomCode(parameters: params, success:
            { response in
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                PrintLog("验证码发送成功")
        }, failure: {error in
        })
    }


}
