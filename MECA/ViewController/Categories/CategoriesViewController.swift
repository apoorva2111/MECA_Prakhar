

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var footerView: FooterTabView!
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var viewModel : CategoriesVM!
    
    override func viewDidLoad() {
            super.viewDidLoad()
           
            viewModel = CategoriesVM.init(controller: self)
           
            self.categoryCollectionView.register(UINib(nibName: "SelectCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SelectCategoryCollectionViewCell")
           
            categoryCollectionView.dataSource = self
            categoryCollectionView.delegate = self
          
            screenSize = UIScreen.main.bounds
            screenWidth = screenSize.width
            screenHeight = screenSize.height
            setupUI()
            footerView.footerTabViewDelegate = self
            footerView.imgHome.image = UIImage.init(named: "Home_Inactive")
            footerView.imgCategory.image = UIImage.init(named: "Categories active")
            footerView.cateforyview.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
            footerView.cateforyview.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            footerView.lblHome.font = UIFont.init(name: "SFPro-Regular", size: 12)
            footerView.lblCalender.font = UIFont.init(name: "SFPro-Regular", size: 12)
            footerView.lblCategory.font = UIFont.init(name: "SFPro-Bold", size: 12)
            footerView.lblNotification.font = UIFont.init(name: "SFPro-Regular", size: 12)
            footerView.lblMore.font = UIFont.init(name: "SFPro-Regular", size: 12)
            // Do any additional setup after loading the view.
        }
    
    func setupUI(){
               let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                //layout.sectionInset = UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30)
                layout.itemSize = CGSize(width: screenWidth/2, height: 220)
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 0
                categoryCollectionView!.collectionViewLayout = layout
    }
}
//MARK:- UICollectionView
extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.arrCat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        viewModel.getItemForRowAt(indexPath, collectionView: categoryCollectionView)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.getSizeForItem(categoryCollectionView, collectionViewLayout: collectionViewLayout, indexPath: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath, collectionView: categoryCollectionView)
    }
}
//MARK:- Footerview Delegate
extension CategoriesViewController: FooterTabViewDelegate{
    func footerBarAction(strType: String) {
        if strType == "Home"{
            
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
        
        }else if strType == "Calendar"{
            
            let vc = FlowController().instantiateViewController(identifier: "Chatvcmain", storyBoard: "Home")
            self.navigationController?.pushViewController(vc, animated:false)
            
        }else if strType == "Categories"{
            
        }else if strType == "FROM TMC"{
            let vc = FlowController().instantiateViewController(identifier: "FromTMCvc", storyBoard: "Home")
            self.navigationController?.pushViewController(vc, animated:false)
        }else{
            let vc = FlowController().instantiateViewController(identifier: "MoreVC", storyBoard: "Home")
            self.navigationController?.pushViewController(vc, animated:false)
        }
    }
    
    
}
