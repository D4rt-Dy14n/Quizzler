//
//  RecordsViewController.swift
//  Quizzler-iOS13
//
//  Created by Юрий Федоров on 10.04.2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

class RecordsViewController: UIViewController {

    var records = ""
    var text = ""
    var LabelHeight = 1
    @IBOutlet weak var recordsLabel: UILabel!
    
    @IBOutlet weak var recordsLabelHeight: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordsLabel.text = records
        recordsLabelHeight.constant = CGFloat(36 * LabelHeight)
    }

    @IBAction func returnButtonTapped(_ sender: UIButton) {
         dismiss(animated: true, completion: nil)
    }
}
