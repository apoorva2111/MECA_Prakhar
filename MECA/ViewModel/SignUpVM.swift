//
//  SignUpVM.swift
//  MECA
//
//  Created by Apoorva Gangrade on 21/03/21.
//

import UIKit

class SignUpVM: NSObject {
    var actualController:UIViewController?
    
    init(controller:UIViewController?) {
        self.actualController = controller
    }
}

extension SignUpVM{
    func callSignUpWebservice(param:[String:Any]) {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webServiceForSignUp(params: param) { (response) in
            print(response)
        }
    }
}
