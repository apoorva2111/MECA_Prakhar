
import UIKit

class NewsListVC: UIViewController {

    @IBOutlet weak var listCollection: UICollectionView!
    @IBOutlet weak var lblHeader: UILabel!
    var arrOurPick = [Ourpicks]()
    var arrLatestNewslist = [NSDictionary]()
    var dictLatestNewslist = NSDictionary()
    var clickOn = ""
    var category = ""
    var viewModel : NewsListVM!
    var currentPage : Int = 1
    var checkPagination = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = NewsListVM.init(controller: self)
        
        self.checkPagination = "get"
   
        if clickOn == "Ourpick"{
            lblHeader.text = "Our Picks"
            viewModel.callWebserviceForNewListWithCat(keyword: "", category: category, subcategory: "", page: String(currentPage))
        }else if clickOn == "LatestNews"{
                lblHeader.text = category
                viewModel.callWebserviceForNewListWithCat(keyword: "", category: category, subcategory: "", page: String(currentPage))

            }else if clickOn == "Videos"{
                lblHeader.text = category
                viewModel.callWebserviceForNewListWithCat(keyword: "", category: category, subcategory: "", page: String(currentPage))

            }
                listCollection.register(UINib.init(nibName: "LatestNewsCVCell", bundle: nil), forCellWithReuseIdentifier: "LatestNewsCVCell")
                listCollection.delegate = self
                listCollection.dataSource = self
//            }
//        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @IBAction func btnbackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCreateNewsAction(_ sender: UIButton) {
        let vc = FlowController().instantiateViewController(identifier: "AddNewsViewController", storyBoard: "Home")as! AddNewsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewsListVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getNumbersOfItemsForSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        viewModel.getItemForRowAt(indexPath, collectionView: listCollection)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.getSizeForItem(listCollection, collectionViewLayout: collectionViewLayout, indexPath: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath, collectionView: listCollection)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let lastVisibleIndexPath = listCollection.indexPathsForVisibleItems.last {
            if indexPath == lastVisibleIndexPath {
                if indexPath.row == viewModel.arrCatList.count-1{
                    self.checkPagination = "pagination"
                    currentPage += 1
                    GlobalObj.run(after: 2) {
                        GlobalObj.displayLoader(true, show: true)
                        self.viewModel.callWebserviceForNewListWithCat(keyword: "", category: self.category, subcategory:"", page:String(self.currentPage))

                    }
                }
            }
        }
    }
}
