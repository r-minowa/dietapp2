//
//  AppDelegate.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/05/14.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftDate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print("RealmURL = \(Realm.Configuration.defaultConfiguration.fileURL!)")
        
        // SwiftDateの初期設定
        let japan = Region(calendar: Calendars.gregorian, zone: Zones.asiaTokyo, locale: Locales.japanese)
        SwiftDate.defaultRegion = japan
        
        let today = Date()

/*        // 時間確認用
        let dateString = "2020/06/14 12:00"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let hoge = formatter.date(from: dateString)!
*/
        
        // 今日が登録された土曜日よりも前かどうか
        if today > UserDefaultManager.shared.nextSaturday {
            UserDefaultManager.shared.isShowPopUp = false   // ポップアップ表示する
            UserDefaultManager.shared.nextSaturday = Date.today().next(.saturday).dateAtEndOf(.day)
        }
        
        // 目標歩数の日付判定用
        if today > UserDefaultManager.shared.endToday {
            UserDefaultManager.shared.endToday = today.dateAtEndOf(.day)
            UserDefaultManager.shared.isShowStepsAlart = false  // アラート表示する
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
