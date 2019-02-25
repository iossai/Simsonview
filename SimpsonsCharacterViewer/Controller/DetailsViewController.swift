//
//  DetailsViewController.swift
//  SimpsonsCharacterViewer
//
//  Created by Sai Goutham  on 27/01/19.
//  Copyright © 2019 DataQ. All rights reserved.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {

    var  user: User?

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userDescreptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUserInfo()
        // Do any additional setup after loading the view.
    }
    
    /// Update UserInfo in UI
    func updateUserInfo() {
        let titleDescreption = HomeViewModel.shared.getTitleDescreption(userText: user?.text ?? "" )
        self.navigationItem.title = titleDescreption.title
        userDescreptionLabel.text = titleDescreption.descreption
        userImageView.sd_setImage(with: URL(string: user?.icon.url ?? ""), placeholderImage: UIImage(named: "PlaceholderImage"))
    }

}
