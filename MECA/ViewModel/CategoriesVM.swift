
import UIKit

class CategoriesVM: BaseCollectionViewVM {

    var arrCat = ["News RC","MEBIT","MaaS","HYDROGEN","SDGS","GR","Training","One & Only"]
    var arrcatImg = [UIImage.init(named: "News"),UIImage.init(named: "MEBIT"),UIImage.init(named: "MaaS"),UIImage.init(named: "Hydrogen"),UIImage.init(named: "SDGs"),UIImage.init(named: "GR"),UIImage.init(named: "Training_category"),UIImage.init(named: "one_and_only Category")]

    var arrModule = [Modules]()
    
    override init(controller: UIViewController?) {
        super.init(controller: controller)
      actualController = controller
        callWebserviceCategory()

    }
    
    override func getItemForRowAt(_ indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
    
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectCategoryCollectionViewCell", for: indexPath) as! SelectCategoryCollectionViewCell
        cell.CategoryImageView.image = arrcatImg[indexPath.row]
        cell.CategoryLabel.text = arrCat[indexPath.row]
        return cell
    }
    func didSelectRowAt(_ indexPath: IndexPath, collectionView: UICollectionView) {
        
        if indexPath.row == 0 {
            let story = UIStoryboard(name: "NewsRC", bundle:nil)
                       let vc = story.instantiateViewController(withIdentifier: "NewsHomeVC") as! NewsHomeVC
            
            (actualController as! CategoriesViewController).navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 1{
            let story = UIStoryboard(name: "Category", bundle:nil)
                       let vc = story.instantiateViewController(withIdentifier: "MEBITViewController") as! MEBITViewController
            vc.headerImageValue  = "1"
            GlobalValue.tabCategory = "MEBIT"
            for objModule in arrModule {
                if objModule.module == "Kaizen" {
                    print(objModule)
                    vc.module = objModule.id ?? 0
                }
            }
            (actualController as! CategoriesViewController).navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 2{

            let story = UIStoryboard(name: "Category", bundle:nil)
                       let vc = story.instantiateViewController(withIdentifier: "MaasVC") as! MaasViewController
            GlobalValue.tabCategory = "Maas"
            for objModule in arrModule {
                if objModule.module == "Maas" {
                    print(objModule)
                    vc.module = objModule.id ?? 0
                }
            }
            (actualController as! CategoriesViewController).navigationController?.pushViewController(vc, animated: true)

        } else if indexPath.row == 3{
            let story = UIStoryboard(name: "Category", bundle:nil)
                       let vc = story.instantiateViewController(withIdentifier: "Hydrogenvc") as! HydrogenVC
            GlobalValue.tabCategory = "Hydrogen"
            for objModule in arrModule {
                if objModule.module == "Hydrogen" {
                    print(objModule)
                    vc.module = objModule.id ?? 0
                }
            }
            (actualController as! CategoriesViewController).navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 4{
            let story = UIStoryboard(name: "Category", bundle:nil)
                       let vc = story.instantiateViewController(withIdentifier: "SDGSvc") as! SDGSVC
            GlobalValue.tabCategory = "SDGS"
            for objModule in arrModule {
                if objModule.module == "SDGs" {
                    print(objModule)
                    vc.module = objModule.id ?? 0
                }
            }

            (actualController as! CategoriesViewController).navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 5{
            let story = UIStoryboard(name: "Category", bundle:nil)
                       let vc = story.instantiateViewController(withIdentifier: "MEBITViewController") as! MEBITViewController
            vc.headerImageValue  = "5"
            GlobalValue.tabCategory = "GR"
            for objModule in arrModule {
                if objModule.module == "GR" {
                    print(objModule)
                    vc.module = objModule.id ?? 0
                }
            }
            (actualController as! CategoriesViewController).navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 6{
            let story = UIStoryboard(name: "Category", bundle:nil)
                       let vc = story.instantiateViewController(withIdentifier: "Trainingvc") as! TrainingVC
            
            GlobalValue.tabCategory = "Training"
            (actualController as! CategoriesViewController).navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 7{
            let story = UIStoryboard(name: "Home", bundle:nil)
                       let vc = story.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            
            GlobalValue.tabCategory = "One & Only"
            (actualController as! CategoriesViewController).navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    func getSizeForItem(_ collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize {
        return CGSize(width: (actualController as! CategoriesViewController).screenWidth/2, height: 220)

    }
    
    
        //Module
        func callWebserviceCategory() {
            GlobalObj.displayLoader(true, show: true)
            APIClient.webserviceForCategoryList { (result) in
                GlobalObj.displayLoader(true, show: false)
                if let respCode = result.resp_code{
                    if respCode == 200{
                        // GlobalObj.displayLoader(true, show: false)
                        
                        if let arrDate = result.data{
                        
                            if let arr = arrDate.modules{
                                print(arr)
                                self.arrModule = arr
                            }
                        }
                        
                    }else{
                        // GlobalObj.displayLoader(true, show: false)
                        
                    }
                }
                
                GlobalObj.displayLoader(true, show: false)
                
            }
            
        }
}
