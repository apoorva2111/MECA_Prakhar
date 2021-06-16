//
//  File.swift
//  MECA
//
import UIKit
import Tabman
import Pageboy

protocol UserImagesPagerControllerDelegate{
    
    func didScrollToPosition(_ position:Int)
}
class UserImagesPagerController: TabmanViewController {

    var viewControllers = [UIViewController]()
    var userImagesDelegate:UserImagesPagerControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self

    }
    override func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPageAt index: TabmanViewController.PageIndex, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        userImagesDelegate?.didScrollToPosition(index)
    }
}
extension UserImagesPagerController: PageboyViewControllerDataSource {

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

}
