//
//  SignUpListViewVC.swift
//  MECA
//
//  Created by Apoorva Gangrade on 19/03/21.
//

import UIKit

class SignUpListViewVC: UIViewController {
    
    @IBOutlet weak var tblList: UITableView!
    var viewModel : SignUpListViewVM!
    
    
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignUpListViewVM.init(controller: self)
        tblList.register(SignUpListTVCell.nib(), forCellReuseIdentifier: viewModel.identifierItemCell)
    }


}

extension SignUpListViewVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: tblList)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getHeightForRowAt(indexPath, tableView: tblList)
    }
}
