//
//  File.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/9/27.
//  Copyright © 2016年 chh. All rights reserved.
//

import UIKit

///屏幕尺寸（宽）
let SCREEN_WIDTH = UIScreen.main.bounds.width
///屏幕尺寸（高）
let SCREEN_HEIGHT = UIScreen.main.bounds.height
///适配比例
let UIRate = SCREEN_WIDTH/375.0

///RGB颜色，透明的默认为1.0
func UIColorRGBA(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1.0) -> UIColor{
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
}

///Hex十六进制颜色，透明度默认为1.0
func UIColorHex(_ hex: String, _ alpha: CGFloat = 1.0) -> UIColor{
    var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
    if (cString.hasPrefix("#")) {
        cString = (cString as NSString).substring(from: 1)
    }
    let rString = (cString as NSString).substring(to: 2)
    let gString = ((cString as NSString).substring(from:2) as NSString).substring(to:2)
    let bString = ((cString as NSString).substring(from:4) as NSString).substring(to: 2)
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    
    Scanner(string: rString).scanHexInt32(&r)
    Scanner(string: gString).scanHexInt32(&g)
    Scanner(string: bString).scanHexInt32(&b)
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha))
}

///默认背景颜色
let defaultBackgroundColor: UIColor = UIColorHex("f3f3f3")
///默认分割线的颜色
let defaultDivideLineColor: UIColor = UIColorHex("e1e1e1")

///系统常规字体大小
func UIFontSize(size: CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: size)
}

///系统粗体大小
func UIFontBoldSize(size: CGFloat) -> UIFont{
    return UIFont.boldSystemFont(ofSize: size)
}

///自定义打印日志
func PrintLog<T>(_ message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line){
    //文件名、方法、行号、打印信息
    //        print("\(fileName as NSString)\n方法:\(methodName)\n行号:\(lineNumber)\n打印信息\(message)");
    print("方法:\(methodName)  行号:\(lineNumber)\n打印信息:\(message)");
}

///富文本，改变字体颜色
func changeTextColor(text: String, color: UIColor, range: NSRange) -> NSAttributedString {
    let attributeStr = NSMutableAttributedString(string: text)
    attributeStr.addAttribute(NSForegroundColorAttributeName, value:color , range: range)
    
    return attributeStr
}


