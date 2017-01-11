//
//  InicioRfcVC.swift
//  SatDemo
//
//  Created by Hiram Elguézabal Jiménez on 10/11/16.
//  Copyright © 2016 Hiram Elguézabal Jiménez. All rights reserved.
//

import UIKit

class InicioRfcVC: UIViewController {
    
    
    
    
    @IBAction func descargaConstancia(_ sender: AnyObject) {
        
        let valida = MuestraConstanciaVC(nibName: "MuestraConstanciaVC", bundle: nil)
        navigationController?.pushViewController(valida, animated: true)

        
    }
    
    
    @IBAction func descargaCIF(_ sender: AnyObject) {
        
        let valida = MuestraCIF(nibName: "MuestraCIF", bundle: nil)
        navigationController?.pushViewController(valida, animated: true)

        
    }
    
    @IBAction func noSoy(_ sender: AnyObject) {

//        let valida = LoginVC(nibName: "LoginVC", bundle: nil)
//        navigationController?.pushViewController(valida, animated: true)
        Singleton.showNombreMenu = nil
        _ = navigationController?.popToRootViewController(animated: true)

        

    }
    
    @IBAction func ayuda(_ sender: AnyObject) {
    
    
    }
    
    @IBAction func menuBoton(_ sender: UIButton) {
        
        
        
    }
    
    
    @IBOutlet weak var menuBoton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBoton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().rearViewRevealWidth = 210

    }

    
    
}
