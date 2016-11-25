//
//  AppDelegate.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/8.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UITabBarControllerDelegate {

    var window: UIWindow?
    var rootTabbar: HHTabBarController?
    
    let manager = NetworkReachabilityManager(host: "www.baidu.com")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Thread.sleep(forTimeInterval: 1.0)//启动延时1秒
        
        //解决键盘遮挡问题
        IQKeyboardManager.sharedManager().enable = true
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        
        rootTabbar = HHTabBarController()
        rootTabbar?.delegate = self
        self.window?.rootViewController = rootTabbar
        self.window?.makeKeyAndVisible()
        
        //监听网络
        self.listeningNetStatus()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

   
    //MARK: - UITabBarControllerDelegate，控制tabbar的点击
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        //如果未登录
        if !UserHelper.isLogin() {
            if viewController.tabBarItem.title == "我的"{
                let loginVC = LoginViewController()
                loginVC.isPush = false
                //使登录界面的nav可以显示出来
               let loginNav = HHNavigationController(rootViewController: loginVC)
              tabBarController.selectedViewController?.present(loginNav, animated: true, completion: nil)
                return false
            }else {
                return true
            }
        }
      return true
  }
    
    //网络状态
    func listeningNetStatus(){
        self.manager?.listener = { status in
            
            switch status {
            case .unknown:
                self.rootTabbar?.showHintInKeywindow(hint: "未知网络连接",yOffset: SCREEN_HEIGHT/2 - 100*UIRate)
            case .notReachable:
                self.rootTabbar?.showHintInKeywindow(hint: "无网络连接",yOffset: SCREEN_HEIGHT/2 - 100*UIRate)
            case .reachable(.ethernetOrWiFi):
                self.rootTabbar?.showHintInKeywindow(hint: "WiFi连接",yOffset: SCREEN_HEIGHT/2 - 100*UIRate)
            case .reachable(.wwan):
                self.rootTabbar?.showHintInKeywindow(hint: "数据网络连接",yOffset: SCREEN_HEIGHT/2 - 100*UIRate)
            }
        }
        self.manager?.startListening()
    }

    
}

