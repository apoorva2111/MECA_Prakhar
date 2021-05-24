

import Foundation
import Alamofire
import KRProgressHUD


class APIClient {
//Login
    static func webServicesToSignIn(params:[String:Any],completion:@escaping(LoginUserModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + login
        AF.request(url, method: .post, parameters: params)
            .responseJSON { response in
                print("login response ...\(response)")
                guard let dataResponse = response.data else {
                    print("Response Error")
                    GlobalObj.displayLoader(true, show: false)
                    return }
                
                do{
                    let objRes: LoginUserModel = try JSONDecoder().decode(LoginUserModel.self, from: dataResponse)
//                    completion(objRes)
                    switch response.result{
                                   case .success( _):
                                    
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }
            }

}
    
    //Profileedit
        static func webServicesTochangeprofileedit(params:[String:Any], header: [String:String],image: UIImage,completion:@escaping(Profileupdatemodel) -> Void){
            if !NetworkReachabilityManager()!.isReachable{
                            GlobalObj.displayLoader(true, show: false)
            
                                  GlobalObj.showNetworkAlert()
                                  return
                        }
            let url = BaseURL + profileedit
            let httpHeaders = HTTPHeaders(header)
            AF.upload(multipartFormData: { multiPart in
                for p in params {
                    multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
                }
                multiPart.append(image.jpegData(compressionQuality: 0.4)!, withName: "newavatar", fileName: "profile_image.jpg", mimeType: "image/jpg")

            }, to: url, method: .post, headers: httpHeaders) .uploadProgress(queue: .main, closure: { progress in
                print("Upload Progress: \(progress.fractionCompleted)")
            }).responseJSON(completionHandler: { data in
                print("upload finished: \(data)")
                DispatchQueue.main.async {
                    KRProgressHUD.dismiss()
                }
            }).response { (response) in
                print("profileedit datas\(response)")
                
                guard let dataResponse = response.data else {
                        print("Response Error")
                        GlobalObj.displayLoader(true, show: false)
                        return
                }
                do{
                        let objRes: Profileupdatemodel = try JSONDecoder().decode(Profileupdatemodel.self, from: dataResponse)
    //                    completion(objRes)
                        switch response.result{
                                       case .success( _):

                                               completion(objRes)
                                       case .failure(let error):
                                           print(error)
                                        GlobalObj.displayLoader(true, show: false)

                                       }
                    }catch let error{
                        print(error)
                        GlobalObj.displayLoader(true, show: false)

                    }

//                switch response.result {
//                case .success(let resut):
//                    print("upload success result: \(resut)")
//                    DispatchQueue.main.async {
//                        KRProgressHUD.dismiss()
//                    }
//                case .failure(let err):
//                    print("upload err: \(err)")
//                    DispatchQueue.main.async {
//                        KRProgressHUD.dismiss()
//                    }
//                }
            }
        }
    
   //Registration
    static func webServiceForSignUp(params:[String:Any],completion:@escaping(Any) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)
            GlobalObj.showNetworkAlert()
            return
        }
        let url = BaseURL + register
        AF.request(url, method: .post, parameters: params)
            .responseJSON { response in
//                completion(response)
                switch response.result{
                case .success( _):
                    completion(response.value!)
                case .failure(let error):
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }
            }
    }
    
    //DistributorList
   
    static func webServicesForDistributorList(params:[String:Any],completion:@escaping(Any) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)
                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + distributor
        AF.request(url, method: .get, parameters: params)
            .responseJSON { response in
            
                switch response.result{
                case .success( _):
                    completion(response.value!)
                case .failure(let error):
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }

               
            }
}

    //Division List
    static func webServicesForDivisionList(Division_Id:String,params:[String:Any],completion:@escaping(Any) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)
                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + divisionList+Division_Id
        AF.request(url, method: .get, parameters: params)
            .responseJSON { response in
            
                switch response.result{
                case .success( _):
                    completion(response.value!)
                case .failure(let error):
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }

               
            }
}

    //Home Feed
    
    static func wevserviceForHomeFeed(completion:@escaping(HomeModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + homeFeed
       
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                
                guard let dataResponse = response.data else {
                    print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                    return }
                
                do{
                    let objRes: HomeModel = try JSONDecoder().decode(HomeModel.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }
            }
    }
    
    
    //MEBIT Home
    static func webserviceForMEBITFeed(completion:@escaping(MEBITModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)
                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + mebitFeed
       
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                
                guard let dataResponse = response.data else {
                    print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                    return }
                
                do{
                    let objRes: MEBITModel = try JSONDecoder().decode(MEBITModel.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }
            }
    }
 //Event Info
	static func webserviceForEventInfo(eventID:String, isEvent: Bool,completion:@escaping(EventInfoModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)
				GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + eventInfo + eventID

        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                
                guard let dataResponse = response.data else {
                    print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                    return }
                
                do{
                    let objRes: EventInfoModel = try JSONDecoder().decode(EventInfoModel.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)
                }
            }
    }
    
    //Kaizen info
	static func webserviceForKaizenInfo(eventId: String = "5",completion:@escaping(KaizenInfoModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + kaizenInfo + eventId
       
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                
                guard let dataResponse = response.data else {
                    print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                    return }
                
                do{
                    let objRes: KaizenInfoModel = try JSONDecoder().decode(KaizenInfoModel.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)
                }
            }
    }
    
    //New Car
    static func webserviceForNewCarSale(limit: String,page: String, params:[String:Any],completion:@escaping(NewCarKaizenModel) -> Void){
           if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                     GlobalObj.showNetworkAlert()
                     return
           }
           let url = BaseURL + kaizenList + limit + "/" + page
          
           var headers = HTTPHeaders()

           let accessToken = userDef.string(forKey: UserDefaultKey.token)
            headers = ["Authorization":"Bearer \(accessToken ?? "")"]
//           AF.request(url, method: .post, headers: headers)
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
               .responseJSON { response in
                print(response)
                   guard let dataResponse = response.data else {
                       print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                       return }

                   do{
                       let objRes: NewCarKaizenModel = try JSONDecoder().decode(NewCarKaizenModel.self, from: dataResponse)
                       switch response.result{
                                      case .success( _):
                                              completion(objRes)
                                      case .failure(let error):
                                          print(error)
                                        GlobalObj.displayLoader(true, show: false)

                                      }
                   }catch let error{
                       print(error)
                    GlobalObj.displayLoader(true, show: false)

                   }
               }
       }

    
    //MEBIT List
    static func webserviceForMEBITList(completion:@escaping(MedbiListModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + mebitFeed
       
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                
                guard let dataResponse = response.data else {
                    print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                    return }
                
                do{
                    let objRes: MedbiListModel = try JSONDecoder().decode(MedbiListModel.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }
            }
    }
    
    //Category list
    static func webserviceForCategoryList(completion:@escaping(MEBITCat_Model) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + categories
       
      //  var headers = HTTPHeaders()
       // let accessToken = userDef.string(forKey: UserDefaultKey.token)
        // headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: [:])
            .responseJSON { response in
                print(response)
                guard let dataResponse = response.data else {
                    print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                    return }
                
                do{
                    let objRes: MEBITCat_Model = try JSONDecoder().decode(MEBITCat_Model.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }
            }
    }
    
    
   // CategoryList Bottom
    static func webserviceForCategory(limit:String,page:String,params:[String:Any],completion:@escaping(CatListModel) -> Void){
           if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                     GlobalObj.showNetworkAlert()
                     return
           }
           let url = BaseURL + eventList + limit + "/" + page
          
           var headers = HTTPHeaders()

           let accessToken = userDef.string(forKey: UserDefaultKey.token)
            headers = ["Authorization":"Bearer \(accessToken ?? "")"]
//           AF.request(url, method: .post, headers: headers)
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
               .responseJSON { response in
                print(response)
                   guard let dataResponse = response.data else {
                       print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                       return }

                   do{
                       let objRes: CatListModel = try JSONDecoder().decode(CatListModel.self, from: dataResponse)
                       switch response.result{
                                      case .success( _):
                                              completion(objRes)
                                      case .failure(let error):
                                          print(error)
                                        GlobalObj.displayLoader(true, show: false)

                                      }
                   }catch let error{
                       print(error)
                    GlobalObj.displayLoader(true, show: false)

                   }
               }
       }
    
    //GRLinkList
    
    static func webserviceForGRLinkList(limit: String,page: String, params:[String:Any],completion:@escaping(LinkModel) -> Void){
           if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                     GlobalObj.showNetworkAlert()
                     return
           }
           let url = BaseURL + GRlinks + limit + "/" + page
          
           var headers = HTTPHeaders()

           let accessToken = userDef.string(forKey: UserDefaultKey.token)
            headers = ["Authorization":"Bearer \(accessToken ?? "")"]
//           AF.request(url, method: .post, headers: headers)
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
               .responseJSON { response in
                print(response)
                   guard let dataResponse = response.data else {
                       print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                       return }

                   do{
                       let objRes: LinkModel = try JSONDecoder().decode(LinkModel.self, from: dataResponse)
                       switch response.result{
                                      case .success( _):
                                              completion(objRes)
                                      case .failure(let error):
                                          print(error)
                                        GlobalObj.displayLoader(true, show: false)

                                      }
                   }catch let error{
                       print(error)
                    GlobalObj.displayLoader(true, show: false)

                   }
               }
       }
    
    //Hydrogen Info
           static func webserviceForHydrogenInfo(eventId: String = "5",completion:@escaping(KaizenInfoModel) -> Void){
            if !NetworkReachabilityManager()!.isReachable{
                GlobalObj.displayLoader(true, show: false)

                      GlobalObj.showNetworkAlert()
                      return
            }
            let url = BaseURL + HydrogenInfo + eventId
           
            var headers = HTTPHeaders()

            let accessToken = userDef.string(forKey: UserDefaultKey.token)
             headers = ["Authorization":"Bearer \(accessToken ?? "")"]
            AF.request(url, method: .get, headers: headers)
                .responseJSON { response in
                    print("Response \(response)")
                    guard let dataResponse = response.data else {
                        print("Response Error")
                        return }
                    
                    do{
                        let objRes: KaizenInfoModel = try JSONDecoder().decode(KaizenInfoModel.self, from: dataResponse)
                        switch response.result{
                                       case .success( _):
                                               completion(objRes)
                                       case .failure(let error):
                                           print(error)
                                        GlobalObj.displayLoader(true, show: false)

                                       }
                    }catch let error{
                        print(error)
                        GlobalObj.displayLoader(true, show: false)
                    }
                }
        }
    //GRHomeList
    
    static func webserviceForGRHomeList(limit: String,page: String,Type:String,params:[String:Any],isFromGRHome:Bool, completion:@escaping(GRHomeLisModel) -> Void){
           if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                     GlobalObj.showNetworkAlert()
                     return
           }
        var url = ""
        if isFromGRHome {
             url = BaseURL + GRHomeList + limit + "/" + page
        }else{
             url = BaseURL + GRHomeList + limit + "/" + page + "/" +  Type
        }
        
           
          
           var headers = HTTPHeaders()

           let accessToken = userDef.string(forKey: UserDefaultKey.token)
            headers = ["Authorization":"Bearer \(accessToken ?? "")"]
//           AF.request(url, method: .post, headers: headers)
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
               .responseJSON { response in
                print(response)
                   guard let dataResponse = response.data else {
                       print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                       return }

                   do{
                       let objRes: GRHomeLisModel = try JSONDecoder().decode(GRHomeLisModel.self, from: dataResponse)
                       switch response.result{
                                      case .success( _):
                                              completion(objRes)
                                      case .failure(let error):
                                          print(error)
                                        GlobalObj.displayLoader(true, show: false)

                                      }
                   }catch let error{
                       print(error)
                    GlobalObj.displayLoader(true, show: false)

                   }
               }
       }
  
    //GR Detail
    
    static func wevserviceForGRDetailFeed(feedId:String,completion:@escaping(GRDetailModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + GRDetail + feedId
       
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                print(response)
                guard let dataResponse = response.data else {
                    print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                    return }
                
                do{
                    let objRes: GRDetailModel = try JSONDecoder().decode(GRDetailModel.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }
            }
    }
    
    //SDGS List
    static func webserviceForSDGSlistapi(limit: String,page: String, params:[String:Any],completion:@escaping(Maasallvalue) -> Void){
           if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                     GlobalObj.showNetworkAlert()
                     return
           }
           let url = BaseURL + SdgsList + limit + "/" + page
          print("kaizen\(url)")
           var headers = HTTPHeaders()

           let accessToken = userDef.string(forKey: UserDefaultKey.token)
            headers = ["Authorization":"Bearer \(accessToken ?? "")"]
//           AF.request(url, method: .post, headers: headers)
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
               .responseJSON { response in
                print(response)
                   guard let dataResponse = response.data else {
                       print("Response Error")
                       return }

                   do{
                       let objRes: Maasallvalue = try JSONDecoder().decode(Maasallvalue.self, from: dataResponse)
                       switch response.result{
                                      case .success( _):
                                              completion(objRes)
                                      case .failure(let error):
                                          print(error)
                                        GlobalObj.displayLoader(true, show: false)

                                      }
                   }catch let error{
                       print(error)
                    GlobalObj.displayLoader(true, show: false)

                   }
               }
       }
    
    //Sdgs Info
       static func webserviceForSdgsInfo(eventId: String = "5",completion:@escaping(KaizenInfoModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + SdgsInfo + eventId
       
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                print("Response \(response)")
                guard let dataResponse = response.data else {
                    print("Response Error")
                    return }
                
                do{
                    let objRes: KaizenInfoModel = try JSONDecoder().decode(KaizenInfoModel.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)
                }
            }
    }
    
    //Maas Info
       static func webserviceForMaasInfo(eventId: String = "5",completion:@escaping(KaizenInfoModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + MaasInfo + eventId
       
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                print("Response \(response)")
                guard let dataResponse = response.data else {
                    print("Response Error")
                    return }
                
                do{
                    let objRes: KaizenInfoModel = try JSONDecoder().decode(KaizenInfoModel.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)
                }
            }
    }
    
    //maas list
    
    static func webserviceForMaas(limit: String,page: String, params:[String:Any],completion:@escaping(Maasallvalue) -> Void){
           if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                     GlobalObj.showNetworkAlert()
                     return
           }
           let url = BaseURL + MaasList + limit + "/" + page
        print("Maas \(url)")
           var headers = HTTPHeaders()

           let accessToken = userDef.string(forKey: UserDefaultKey.token)
            headers = ["Authorization":"Bearer \(accessToken ?? "")"]
//           AF.request(url, method: .post, headers: headers)
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
               .responseJSON { response in
                print(response.result)
                   guard let dataResponse = response.data else {
                       print("Response Error")
                       return }

                   do{
                    print("dataResponse \(dataResponse)")
                       let objRes: Maasallvalue = try JSONDecoder().decode(Maasallvalue.self, from: dataResponse)
                    print("objRes \(objRes)")
                       switch response.result{
                                      case .success( _):
                                              completion(objRes)
                                      case .failure(let error):
                                          print(error)
                                        GlobalObj.displayLoader(true, show: false)

                                      }
                   }catch let error{
                       print(error)
                    GlobalObj.displayLoader(true, show: false)

                   }
               }
       }
    //Hydrogen list
        
        static func webserviceForHydrogen(limit: String,page: String, params:[String:Any], completion:@escaping(Hydrogenallvalue) -> Void){
               if !NetworkReachabilityManager()!.isReachable{
                GlobalObj.displayLoader(true, show: false)

                         GlobalObj.showNetworkAlert()
                         return
               }
            //10/1
               let url = BaseURL + HydrogenList + limit + "/" + page
            print("Maas \(url)")
               var headers = HTTPHeaders()

               let accessToken = userDef.string(forKey: UserDefaultKey.token)
                headers = ["Authorization":"Bearer \(accessToken ?? "")"]
    //           AF.request(url, method: .post, headers: headers)
            AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
                   .responseJSON { response in
                    print(response.result)
                       guard let dataResponse = response.data else {
                           print("Response Error")
                           return }

                       do{
                        print("dataResponse \(dataResponse)")
                           let objRes: Hydrogenallvalue = try JSONDecoder().decode(Hydrogenallvalue.self, from: dataResponse)
                        print("objRes \(objRes)")
                           switch response.result{
                                          case .success( _):
                                                  completion(objRes)
                                          case .failure(let error):
                                              print(error)
                                            GlobalObj.displayLoader(true, show: false)

                                          }
                       }catch let error{
                           print(error)
                        GlobalObj.displayLoader(true, show: false)

                       }
                   }
           }
    
    
    //Like post
     static func webServiceForLikePost(params:[String:Any],completion:@escaping(Any) -> Void){
         if !NetworkReachabilityManager()!.isReachable{
             GlobalObj.displayLoader(true, show: false)
             GlobalObj.showNetworkAlert()
             return
         }
         let url = BaseURL + likeUpdate
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]

         AF.request(url, method: .post, parameters: params, headers: headers)
             .responseJSON { response in
 //                completion(response)
                 switch response.result{
                 case .success( _):
                     completion(response.value!)
                 case .failure(let error):
                     print(error)
                     GlobalObj.displayLoader(true, show: false)

                 }
             }
     }
    
    
    //Comment List
    
    static func wevserviceForCommentList(module:String, item:String, completion:@escaping(CommentListModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + CommentList + module + "/" + item
       
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                print(response)
                guard let dataResponse = response.data else {
                    print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                    return }
                
                do{
                    let objRes: CommentListModel = try JSONDecoder().decode(CommentListModel.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }
            }
    }
    
    
    //Chat List
        static func webServicesToChatlist(params:[String:Any],completion:@escaping(Chatlistmodel) -> Void){
            if !NetworkReachabilityManager()!.isReachable{
                GlobalObj.displayLoader(true, show: false)

                      GlobalObj.showNetworkAlert()
                      return
            }
            let url = BaseURL + chatlist
            print("chat url....\(url)")
            print("chat param....\(params)")
            var headers = HTTPHeaders()
            let accessToken = userDef.string(forKey: UserDefaultKey.token)
             headers = ["Authorization":"Bearer \(accessToken ?? "")"]
            AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
                .responseJSON { response in
                    print("chat datas\(response)")
                    guard let dataResponse = response.data else {
                        print("Response Error")
                        GlobalObj.displayLoader(true, show: false)
                        return }
                    
                    do{
                        let objRes: Chatlistmodel = try JSONDecoder().decode(Chatlistmodel.self, from: dataResponse)
    //                    completion(objRes)
                        switch response.result{
                                       case .success( _):
                                        
                                               completion(objRes)
                                       case .failure(let error):
                                           print(error)
                                        GlobalObj.displayLoader(true, show: false)

                                       }
                    }catch let error{
                        print(error)
                        GlobalObj.displayLoader(true, show: false)

                    }
                }

    }
   
    
    //get profile
    
    static func webserviceForgetprofile(completion:@escaping(Getprofile) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)
            GlobalObj.showNetworkAlert()
            return
        }
        let url = BaseURL + getuserprofile
        print("url\(url)")
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                print("get profile response\(response)")
                guard let dataResponse = response.data else {
                    print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                    return }
                
                do{
                    let objRes: Getprofile = try JSONDecoder().decode(Getprofile.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }
            }
        
    }
    //Change password
        static func webServicesTochangepassword(params:[String:Any],completion:@escaping(Changepassword) -> Void){
            if !NetworkReachabilityManager()!.isReachable{
                GlobalObj.displayLoader(true, show: false)

                      GlobalObj.showNetworkAlert()
                      return
            }
            let url = BaseURL + changepassword
            print("Chnagepassword url\(url)")
            var headers = HTTPHeaders()

            let accessToken = userDef.string(forKey: UserDefaultKey.token)
             headers = ["Authorization":"Bearer \(accessToken ?? "")"]
            AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
                .responseJSON { response in
                    print("Chnagepassword datas\(response)")
                    guard let dataResponse = response.data else {
                        print("Response Error")
                        GlobalObj.displayLoader(true, show: false)
                        return }
                    
                    do{
                        let objRes: Changepassword = try JSONDecoder().decode(Changepassword.self, from: dataResponse)
    //                    completion(objRes)
                        switch response.result{
                                       case .success( _):

                                               completion(objRes)
                                       case .failure(let error):
                                           print(error)
                                        GlobalObj.displayLoader(true, show: false)

                                       }
                    }catch let error{
                        print(error)
                        GlobalObj.displayLoader(true, show: false)

                    }
                }

    }
    
    
    
    //Support Api
    
    
    static func webserviceForSupport(completion:@escaping(Supportmodel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)
            GlobalObj.showNetworkAlert()
            return
        }
        let url = BaseURL + supportlist
        print("Support Api url\(url)")
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                print("Support Api response\(response)")
                guard let dataResponse = response.data else {
                    print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                    return }
                
                do{
                    let objRes: Supportmodel = try JSONDecoder().decode(Supportmodel.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }
            }
        
    }
    
    
    //calendar Api
    
    
    static func webserviceForCalendar(month:String,year:String,completion:@escaping(calendarlistdata) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)
            GlobalObj.showNetworkAlert()
            return
        }
        let url = BaseURL + calendarlist + month + "/" + year
        print("calendar Api url\(url)")
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                print("calendar Api response\(response)")
                guard let dataResponse = response.data else {
                    print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                    return }
                
                do{
                    let objRes: calendarlistdata = try JSONDecoder().decode(calendarlistdata.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }
            }
        
    }
    
    //Like List
    
    static func wevserviceForLikeList(module:String, item:String, completion:@escaping(Like_ListModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + likesList + module + "/" + item
       
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                print(response)
                guard let dataResponse = response.data else {
                    print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                    return }
                
                do{
                    let objRes: Like_ListModel = try JSONDecoder().decode(Like_ListModel.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }
            }
    }
    
    //Delete post
    static func webServiceForDeleteComment(commentId : String ,completion:@escaping(Any) -> Void){
         if !NetworkReachabilityManager()!.isReachable{
             GlobalObj.displayLoader(true, show: false)
             GlobalObj.showNetworkAlert()
             return
         }
         let url = BaseURL + DeleteComment + commentId
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]

        AF.request(url, method: .delete, parameters: [:], headers: headers)
             .responseJSON { response in
 //                completion(response)
                 switch response.result{
                 case .success( _):
                     completion(response.value!)
                 case .failure(let error):
                     print(error)
                     GlobalObj.displayLoader(true, show: false)

                 }
             }
     }
}


