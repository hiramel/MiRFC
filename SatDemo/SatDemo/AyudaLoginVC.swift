//
//  AyudaLoginVC.swift
//  SatDemo
//
//  Created by Hiram Elguézabal Jiménez on 30/11/16.
//  Copyright © 2016 Hiram Elguézabal Jiménez. All rights reserved.
//

import UIKit

class AyudaLoginVC: UIViewController {

    
    
    @IBAction func cerrar(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view?.backgroundColor = UIColor(red: 128/255,green: 128/255, blue:128/255,  alpha: 0.8)
        view.isOpaque = false

    }

  

}
