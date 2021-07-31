

import UIKit
import IQKeyboardManagerSwift
import Firebase
import UserNotificationsUI
import SwiftyJSON
import FirebaseMessaging
import FirebaseInstanceID
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var notificationObject = [String:AnyObject]()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        
        if userDef.value(forKey: UserDefaultKey.token) != nil{
            let mainVC = FlowController().instantiateViewController(identifier: "HomeNav", storyBoard: "Home")
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.window?.rootViewController = mainVC
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.3

            UIView.transition(with: appDel.window!, duration: duration, options: options, animations: {}, completion:
            { completed in
                // maybe do something on completion here
            })
            appDel.window?.makeKeyAndVisible()

        }else{
            let mainVC = FlowController().instantiateViewController(identifier: "NavMain", storyBoard: "Main")
            userDef.removeObject(forKey: UserDefaultKey.token)
            userDef.synchronize()
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.window?.rootViewController = mainVC
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.3

            UIView.transition(with: appDel.window!, duration: duration, options: options, animations: {}, completion:
            { completed in
                // maybe do something on completion here
            })
            appDel.window?.makeKeyAndVisible()

        }
    
        if let notificationResponse = launchOptions?[.remoteNotification] as? UNNotificationResponse{
            
            let userInfo = notificationResponse.notification.request.content.userInfo
            
           // let jsonY = JSON(userInfo)
           // print("json-----\(jsonY)")
            
//            let notification = jsonY["notification"].stringValue
//            print(notification)
            
            //  var notificationDict = [String: AnyObject]()
//            if let data = notification.data(using: String.Encoding.utf8) {
//                do {
//                    let dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
//                    self.notificationObject = dictonary!
//
////                    NotificationCenter.default.post(name: .articleForNotification, object: self.notificationObject)
//
//                    let state = UIApplication.shared.applicationState
//
//                    if state ==  .inactive {
//
//                        self.notificationObject = dictonary!
//                        let title = dictonary?["publisher_name"] as! String
//                        let body = dictonary?["article_name"] as! String
//                        self.callLocalNotification(title: title, body: body)
//                      //  NotificationCenter.default.post(name: .addNotification, object: self.notificationObject)
//                    }
//
//                } catch let error as NSError {
//                    print(error)
//                }
//            }
        }
        self.registerForPushNotifications()
        application.registerForRemoteNotifications()
        return true
        
    }

//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//
//        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
//        print(token)
//    }
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//
//        print("i am not available in simulator :( \(error)")
//    }
}


extension AppDelegate  : UNUserNotificationCenterDelegate, MessagingDelegate{
    
    
    func registerForPushNotifications() {
        
        
        Messaging.messaging().delegate = self
        
        //        if #available(iOS 10.0, *) {
        //            // For iOS 10 display notification (sent via APNS)
        //            UNUserNotificationCenter.current().delegate = self
        //            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        //            UNUserNotificationCenter.current().requestAuthorization(
        //                options: authOptions,
        //                completionHandler: {_, _ in
        //                    // For iOS 10 data message (sent via FCM)
        //                    DispatchQueue.main.async {
        //                        UIApplication.shared.registerForRemoteNotifications()
        //                    }
        //
        //                    let action1 = UNNotificationAction(identifier: "actionTap", title: "Hayti", options: [.foreground])
        //                    let category = UNNotificationCategory(identifier: "CategoryIdentifier", actions: [action1], intentIdentifiers: [], options: [])
        //                    UNUserNotificationCenter.current().setNotificationCategories([category])
        //
        //                })
        //
        //        } else {
        //            let settings: UIUserNotificationSettings =
        //                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        //            UIApplication.shared.registerUserNotificationSettings(settings)
        //        }
        
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM)
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        
        
        self.updateFirestorePushTokenIfNeeded()
        // NotificationCenter.default.addObserver(self, selector: #selector(self.tokenRefreshNotification),name: NSNotification.Name.MessagingRegistrationTokenRefreshed, object: nil)
        
    }
    
    
    func updateFirestorePushTokenIfNeeded() {
        // if let token = Messaging.messaging().fcmToken {
        
            
            
            InstanceID.instanceID().instanceID { result, error in
                if let error = error {
                    print("Error fetching remote instange ID: \(error)")
                } else if let result = result {
                    
                    
                    
                    print("Remote instance ID token: \(result.token)")
                }
            }
            
            //InstanceID.instanceID()
        //        instance.deleteID { (error) in
        //          print(error.debugDescription)
        //        }
        
//        instance.instanceID { (result, error) in
//            if let error = error {
//                print("Error fetching remote instange ID: \(error)")
//            } else {
//                print("Remote instance ID token: \(String(describing: result?.token))")
//
//                let strToken = result?.token
//                print(strToken)
//                userDef.setValue(strToken!, forKey: "fcmToken")
//
//                //            if let device_token = userDef.object(forKey: "device_token") as? String{
//                //                APIClient.sendRefeshToken(device_id: device_token, refreshTokens: strToken!) { (response) in
//                //                    print(response)
//                //                }
//                //            }
//            }
//        }
            // Messaging.messaging().shouldEstablishDirectChannel = true
        
        
        
            //
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.hexString
        userDef.setValue(deviceTokenString, forKey: "device_token")
        userDef.synchronize()
    }
    
    
    //    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
    //        print(remoteMessage.appData)
    //    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print(fcmToken)
        userDef.setValue(fcmToken, forKey: "fcmToken")
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // let userInfo = notification.request.content.userInfo
        completionHandler([.alert,.sound])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        
        switch response.actionIdentifier {
        
        case UNNotificationDefaultActionIdentifier:
            
            
            
            //            let jsonY = JSON(userInfo)
            //            print("json-----\(jsonY)")
            //
            //            let notification = jsonY["notification"].stringValue
            //            print(notification)
            //
            //            var notificationDict = [String: AnyObject]()
            //            if let data = notification.data(using: String.Encoding.utf8) {
            //                do {
            //                    let dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            //                    notificationDict = dictonary!
            //                    NotificationCenter.default.post(name: .articleForNotification, object: notificationDict)
            //                } catch let error as NSError {
            //                    print(error)
            //                }
            //            }
            
            print(self.notificationObject)
          //  NotificationCenter.default.post(name: .articleForNotification, object: self.notificationObject)
            
            completionHandler()
        default:
            break;
            
        }
        
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print(userInfo)
        
        let jsonY = JSON(userInfo)
        print("json-----\(jsonY)")
        
        let notification = jsonY["notification"].stringValue
        print(notification)
        
        if let data = notification.data(using: String.Encoding.utf8) {
            do {
                let dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                self.notificationObject = dictonary!
                let title = dictonary?["publisher_name"] as! String
                let body = dictonary?["article_name"] as! String
                self.callLocalNotification(title: title, body: body)
               //// NotificationCenter.default.post(name: .addNotification, object: self.notificationObject)
            } catch let error as NSError {
                print(error)
            }
        }
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func callLocalNotification(title:String , body : String ){
        if #available(iOS 10.0, *){
            //UNUserNotificationCenter.current().delegate = self
            let content = UNMutableNotificationContent()
            let requestIdentifier = "actionTap"
            content.categoryIdentifier = "CategoryIdentifier"
            content.sound = UNNotificationSound.default
            content.title = title
            content.body = body
            let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1.0, repeats: false)
            let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error:Error?) in
                if error != nil{
                    print(error?.localizedDescription ?? 0)
                }
                print("Notification Register Success")
            }
        }
        
    }
}
extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
