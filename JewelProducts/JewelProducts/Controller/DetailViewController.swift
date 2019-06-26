//
//  DetailViewController.swift
//  JewelProducts
//
//  Created by Apple on 26/06/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var DescriptionLbl: UILabel!
    
    var desc : String!
    override func viewDidLoad() {
        super.viewDidLoad()

        DescriptionLbl.text = desc
    }
    
}
