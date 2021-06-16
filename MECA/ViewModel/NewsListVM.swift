//
import UIKit

class NewsListVM: BaseCollectionViewVM{
    var arrCatList = [NewsListData]()

    override init(controller: UIViewController?) {
        
        super.init(controller: controller)
        actualController = controller
        nibItem = "InstagramImageCVCell"
        identifierItem = "InstagramImageCVCell"
        
    }
    
    override func getItemForRowAt(_ indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        
//        if (actualController as! NewsListVC).clickOn == "Ourpick"{
//            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "OverPicksCVCell", for: indexPath) as! OverPicksCVCell
//            cell.setCell(objDict: (actualController as! NewsListVC).arrOurPick[indexPath.row])
//            return cell
//        }else{
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestNewsCVCell", for: indexPath) as! LatestNewsCVCell
            cell.setListCell(objDict: arrCatList[indexPath.row])
            return cell
       // }
    }
    override func getNumbersOfItemsForSection(_ section:Int)->Int{
//        if (actualController as! NewsListVC).clickOn == "Ourpick"{
//            return (actualController as! NewsListVC).arrOurPick.count
//     }else{
        return arrCatList.count
    // }
        
    }
    
    func didSelectRowAt(_ indexPath: IndexPath, collectionView: UICollectionView) {
        let obj = arrCatList[indexPath.row]
        let vc = FlowController().instantiateViewController(identifier: "NewsDetailVC", storyBoard: "NewsRC") as! NewsDetailVC
        vc.newsID = String(obj.id!)
        (actualController as! NewsListVC).navigationController?.pushViewController(vc, animated: true)

        
    }
    
    func getSizeForItem(_ collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize {
        print(collectionView.frame.size.width)
       
        if (actualController as! NewsListVC).clickOn == "Ourpick"{
            return CGSize(width: collectionView.frame.size.width, height: 180)

        }else{
            return CGSize(width: collectionView.frame.size.width, height:  280)

        }
    }
    
    //NewsListWithCat
    func callWebserviceForNewListWithCat(keyword:String,category:String,subcategory:String,page:String)  {
        GlobalObj.displayLoader(true, show: true)
        let param : [String:Any] = ["keyword":keyword,
                                    "category":category,
                                    "subcategory":subcategory]
        print(param)
        APIClient.webserviceForNewsListWithCat(limit: "10", page: page, params: param) { (result) in
            GlobalObj.displayLoader(true, show: false)
            if let repo = result.resp_code{
             GlobalObj.displayLoader(true, show: false)
            
             if repo == 200 {
                 if (self.actualController as! NewsListVC).checkPagination == "get"{
                    self.arrCatList.removeAll()

                     if let arrList = result.data{
                         print(arrList)

                         for obj in arrList {
                             self.arrCatList.append(obj)
                         }
                         if self.arrCatList.count>0 {
                            (self.actualController as! NewsListVC).listCollection.delegate = (self.actualController as! NewsListVC).self
                            (self.actualController as! NewsListVC).listCollection.dataSource = (self.actualController as! NewsListVC).self

                            (self.actualController as! NewsListVC).listCollection.reloadData()
                            (self.actualController as! NewsListVC).listCollection.isHidden = false
                         }else{
                            (self.actualController as! NewsListVC).listCollection.delegate = nil
                            (self.actualController as! NewsListVC).listCollection.dataSource = nil
                            (self.actualController as! NewsListVC).listCollection.isHidden = true

                         }
                     }
                 }else{
//
                     if let arrList = result.data{
                         print(arrList)

                         for obj in arrList {
                             self.arrCatList.append(obj)
                         }
                        if arrList.count>0 {
                            (self.actualController as! NewsListVC).listCollection.reloadData()
                            (self.actualController as! NewsListVC).listCollection.isHidden = false
                         }
                     }
                 }
                 
                 
             }else{
                 GlobalObj.displayLoader(true, show: false)
             }
         }else{

            (self.actualController as! NewsListVC).showToast(message: "Somwthing Went Wrong")
             GlobalObj.displayLoader(true, show: false)
         }
        }
    }
}
