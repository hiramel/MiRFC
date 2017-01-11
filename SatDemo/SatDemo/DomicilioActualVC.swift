//
//  DomicilioActualVC.swift
//  SatDemo
//
//  Created by Hiram Elguézabal Jiménez on 11/11/16.
//  Copyright © 2016 Hiram Elguézabal Jiménez. All rights reserved.
//

import UIKit

class DomicilioActualVC: UIViewController {
    
    
    
    @IBOutlet weak var continuarBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        self.continuarBtn.layer.cornerRadius = 10

    }
    
    
    @IBAction func siguiente(_ sender: AnyObject) {
        
        let valida = ActividadEconomicaVC(nibName: "ActividadEconomicaVC", bundle: nil)
        navigationController?.pushViewController(valida, animated: true)

        
    }
    
    
    
    @IBAction func atras(_ sender: AnyObject) {
        
        _ = navigationController?.popViewController(animated: true)

        
    }
    
    
    @IBAction func unicaDomicilio(_ sender: AnyObject) {
        
        let condiciones = LocalizaDomicilio(nibName: "LocalizaDomicilio", bundle: nil)
       // condiciones.delegate = self
        condiciones.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        present(condiciones, animated: true, completion: nil)

        
    }
    
    
    


}
