//
//  AcuseVC.swift
//  SatDemo
//
//  Created by Hiram Elguézabal Jiménez on 11/11/16.
//  Copyright © 2016 Hiram Elguézabal Jiménez. All rights reserved.
//

import UIKit

class AcuseVC: UIViewController {
    
    let swAlert = TKSwarmAlert(backgroundType: .transparentBlack(alpha: 0.5))
    var mensaje = "Se guardo tu Constancia"


    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func atras(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)

    
    }
    
    
    @IBAction func goToInicio(_ sender: AnyObject) {
        
//        let valida = InicioRfcVC(nibName: "InicioRfcVC", bundle: nil)
//        navigationController?.pushViewController(valida, animated: true)

        Singleton.showNombreMenu = "show"
        let frontViewController =  InicioRfcVC()//create instance of frontVC
        let rearViewController  =  Menu()//create instance of rearVC(menuVC)
        
        
        //create instance of swRevealVC based on front and rear VC
        let swRevealVC = SWRevealViewController(rearViewController: rearViewController, frontViewController: frontViewController)
        swRevealVC?.toggleAnimationType = SWRevealToggleAnimationType.easeOut
        swRevealVC?.toggleAnimationDuration = 0.30
        
        navigationController?.pushViewController(swRevealVC!, animated: true)


        
    }
    
    
    func createSlidingMenu(){
        
        let frontViewController =  InicioRfcVC()//create instance of frontVC
        let rearViewController  =  Menu()//create instance of rearVC(menuVC)
        
        
        //create instance of swRevealVC based on front and rear VC
        let swRevealVC = SWRevealViewController(rearViewController: rearViewController, frontViewController: frontViewController)
        swRevealVC?.toggleAnimationType = SWRevealToggleAnimationType.easeOut
        swRevealVC?.toggleAnimationDuration = 0.30

    

}
    
    @IBAction func descargaAcuse(_ sender: UIButton) {
        presentaSubMenu()
    }
    
    func presentaSubMenu(){
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.view.tintColor = UIColor(red: 0/255,green: 122/255, blue:255/255,  alpha: 0.8)
        let tomarFoto = UIAlertAction(title: "Descargar", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.mensaje = "    Se descargo tu Acuse"
            self.showAlert()

        })
        let libreria = UIAlertAction(title: "Enviar", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.mensaje = "        Se envio tu Acuse"
            self.showAlert()

        })
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        optionMenu.addAction(tomarFoto)
        optionMenu.addAction(libreria)
        optionMenu.addAction(cancelAction)
        optionMenu.popoverPresentationController?.sourceView = self.view
        optionMenu.popoverPresentationController?.sourceRect = self.view.bounds
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func showAlert() {
        swAlert.show(self.makeSampleViews2())
        //        swAlert.addNextViews(self.makeSampleViews3())
        //        swAlert.addNextViews(self.makeSampleViews2())
        //swAlert.addNextViews(self.makeSampleViews4())
    }
    
    func makeSampleViews2()->[UIView] {
        
        let height:CGFloat = 150
        let width:CGFloat = 300
        let x:CGFloat = self.view.frame.width / 2 - width/2
        // let y:CGFloat = 160//240
        let y:CGFloat = 180//240
        
        
        let f1 = CGRect(x: x, y: y, width: width, height: height)
        var views:[UIView] = []
        let textoAlerta = self.mensaje
        let view1 = SampleDesignView(type: SampleDesignViewType.bar(icon:UIImage(named: "satLogo"), text:textoAlerta), frame: f1)
        views.append(view1)
        
        
        return views
    }


    
    

}
