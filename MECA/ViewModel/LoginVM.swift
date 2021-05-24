
import UIKit

class LoginVM: NSObject {
  
    var actualController:UIViewController?
    
    init(controller:UIViewController?) {
        self.actualController = controller
    }
}

//MARK:- Call Webserviece an all methords
extension LoginVM{
   
    
    func callLoginWebservice(email:String,password:String) {
        GlobalObj.displayLoader(true, show: true)
        let param = ["email":email,
                     "password":password]
        APIClient.webServicesToSignIn(params: param) { (response) in
            print(response)
            if response.status == 1{
                GlobalObj.displayLoader(true, show: false)
                userDef.set(response.token, forKey: UserDefaultKey.token)
                if (((response.avatar)?.contains("public/upload/distributors/users/")) != nil){
                    let img = BaseURL + (response.avatar ?? "")
                    userDef.setValue(img, forKey: UserDefaultKey.avatar)
                }else{
                    let img = BaseURL + "public/upload/distributors/users/" + (response.avatar ?? "")
                    userDef.setValue(img, forKey: UserDefaultKey.avatar)
                }
                userDef.setValue(response.id, forKey: UserDefaultKey.userId)
                
                userDef.synchronize()
                UserDefaults.standard.set(true, forKey: "ISLOGGEDIN")
                let mainVC = FlowController().instantiateViewController(identifier: "HomeNav", storyBoard: "Home")
                UIApplication.shared.windows.first?.rootViewController = mainVC
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            
            }else{
              
                    UserDefaults.standard.set(false, forKey: "ISLOGGEDIN")
                GlobalObj.displayLoader(true, show: false)
                GlobalObj.showAlertVC(title: "Alert", message: "Invalid email or password", controller: (self.actualController as! LoginVC).self)
            }
        }
    }
}
