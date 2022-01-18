//
//  DetailVC.swift
//  mvvmStudy
//
//  Created by ABIN BABU on 17/01/22.
//  Copyright © 2022 Abin. All rights reserved.
//

import UIKit
import SDWebImage

class DetailVC: UIViewController {

    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var datas = RootClassElement()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.company.text = datas.company?.name
        self.name.text = datas.name
        self.userName.text = datas.username
        self.email.text = datas.email
        self.adress.text = datas.address?.city
        self.phone.text = datas.phone
        self.website.text = datas.website
        self.imageView.sd_setImage(with: URL(string: datas.profileImage ?? ""))
        
    }

}
