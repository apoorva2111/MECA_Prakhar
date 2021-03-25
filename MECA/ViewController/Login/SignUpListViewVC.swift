//
//  SignUpListViewVC.swift
//  MECA
//
//  Created by Apoorva Gangrade on 19/03/21.
//

import UIKit
protocol SignUpListViewDelgate {
    func distributorListData(distributor: String,distributorId:Int)
    func divisionListData(division: String,disionId:Int)  //data: string is an example parameter
}

class SignUpListViewVC: UIViewController {
    
    @IBOutlet weak var tblList: UITableView!
    var viewModel : SignUpListViewVM!
    
    var Distributor_Id = ""

    var signUpListViewDelgate : SignUpListViewDelgate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignUpListViewVM.init(controller: self)
        tblList.register(SignUpListTVCell.nib(), forCellReuseIdentifier: viewModel.identifierItemCell)
       
        
      //  viewModel = SignUpListViewVM.init(controller: self)
      //  tblList.register(SignUpListTVCell.nib(), forCellReuseIdentifier: viewModel.identifierItemCell)
      //  viewModel.callWebserviceForDivision()
        
        if BoolValue.isFromDistributor{
            viewModel.callWebserviceForDistributor()
        }else{
            viewModel.callWebserviceForDivision()
        }
      
    }

    @IBAction func btnBackAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath, tableView: tblList)
    }
}
