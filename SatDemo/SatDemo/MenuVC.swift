//
//  MenuVC.swift
//  SatDemo
//
//  Created by Hiram Elguézabal Jiménez on 28/11/16.
//  Copyright © 2016 Hiram Elguézabal Jiménez. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    
    
    
    @IBOutlet weak var viewNombre: UIView!
    
    
    
    @IBAction func inicioAct(_ sender: UIButton) {
        revealViewController().pushFrontViewController(LoginVC(), animated: true)

        
    }
    
    @IBAction func Pantalla1(_ sender: UIButton) {
        
        revealViewController().pushFrontViewController(InicioRfcVC(), animated: true)

    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (Singleton.showNombreMenu != nil){
        
            viewNombre.isHidden = false
        }

    }

    


}
