//
//  ViewController.swift
//  SimpsonsCharacterViewer
//
//  Created by Sai Goutham  on 27/01/19.
//  Copyright © 2019 DataQ. All rights reserved.
//

import UIKit

enum CellIdentifiers: String {
    case listCell = "ListCell"
    case gridCell = "GridCell"
}

enum SegueIdentifiers: String {
    case detailSegue = "DetailSeque"
}

class ViewController: UIViewController {

    @IBOutlet weak var usersTableView: UITableView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userInfoLabel: UILabel!

    var isList = true

    var totalUsers: [User] = []
    
    var searchedUsers: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Constants.appName
        getUsers()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailsViewController
        {
            let detailsVC = segue.destination as? DetailsViewController
            detailsVC?.user = sender as? User
        }
    }

    @IBAction func refreshBtnAction(_ sender: Any) {
        if isList {
            isList = false
        } else {
            isList = true
        }
        usersTableView.reloadData()
    }
    
    /// get the all the Users
    func getUsers() {
        HomeViewModel.shared.getUsers { (results, error) in
            if results != nil {
                self.totalUsers = HomeViewModel.shared.creteUserModels(results: results!)
                self.searchedUsers = self.totalUsers
                if self.totalUsers.count > 0 {
                    DispatchQueue.main.async {
                        self.usersTableView.reloadData()
                        let device = UIDevice.current.userInterfaceIdiom
                        if device == .pad {
                            self.updateDetailView(user: self.totalUsers[0])
                        }
                    }
                }
            } else if error != nil {
                let alertController = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Dismiss", style: .default) { (action:UIAlertAction) in
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    /// Update Details view
    ///
    /// - Parameter user: user model object
    func updateDetailView(user: User) {
        let titleDescreption = HomeViewModel.shared.getTitleDescreption(userText: user.text)
        userNameLabel.text = titleDescreption.title
        userInfoLabel.text = titleDescreption.descreption
        userImageView.sd_setImage(with: URL(string: user.icon.url), placeholderImage: UIImage(named: "PlaceholderImage"))
    }

}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedUsers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isList {
            let listCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.listCell.rawValue) as! ListCell
            let titleDescreption = HomeViewModel.shared.getTitleDescreption(userText: searchedUsers[indexPath.row].text)
            listCell.textLabel?.text = titleDescreption.title
            return listCell
        } else {
            let gridCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.gridCell.rawValue) as! GridCell
            gridCell.userImageView.sd_setImage(with: URL(string: searchedUsers[indexPath.row].icon.url), placeholderImage: UIImage(named: "PlaceholderImage"))
            return gridCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        let device = UIDevice.current.userInterfaceIdiom
        if device == .pad {
            updateDetailView(user: searchedUsers[indexPath.row])
        } else {
            performSegue(withIdentifier: SegueIdentifiers.detailSegue.rawValue, sender: searchedUsers[indexPath.row])
        }
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            searchedUsers.removeAll()
            for user in totalUsers {
                if user.text.lowercased().contains(searchText.lowercased()) {
                    searchedUsers.append(user)
                }
            }
        } else {
            searchedUsers = totalUsers
        }
        usersTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

