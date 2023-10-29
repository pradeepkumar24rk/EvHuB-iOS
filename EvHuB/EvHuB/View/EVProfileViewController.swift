//
//  EVProfileViewController.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 27/10/23.
//

import UIKit

class EVProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let evProfileViewModel = EVProfileViewModel()
    var userInfo: UserModel?
    var rowData:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EVTableViewCell.nib(), forCellReuseIdentifier: EVTableViewCell.identifier)
        tableView.register(EVProfileHeaderTableViewCell.nib(), forCellReuseIdentifier: EVProfileHeaderTableViewCell.identifier)
        guard let val = userInfo?.admin else { return }
        if val {
            rowData = evProfileViewModel.categoryAdmin
        } else {
            rowData = evProfileViewModel.categoryUser
        }
    }

}

extension EVProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionHeader = tableView.dequeueReusableCell(withIdentifier: EVProfileHeaderTableViewCell.identifier) as? EVProfileHeaderTableViewCell else { return UITableViewCell() }
        sectionHeader.config(name: userInfo?.email)
        return sectionHeader
    }
}

extension EVProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rowData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EVTableViewCell.identifier) as? EVTableViewCell else { return UITableViewCell() }
        cell.config(rowData[indexPath.row])
        return cell
    }
    
    
}
