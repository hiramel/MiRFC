//
//  MuestraCIF.swift
//  SatDemo
//
//  Created by Hiram Elguézabal Jiménez on 11/11/16.
//  Copyright © 2016 Hiram Elguézabal Jiménez. All rights reserved.
//

import UIKit

class MuestraCIF: UIViewController {
    
    let swAlert = TKSwarmAlert(backgroundType: .transparentBlack(alpha: 0.5))
    var mensaje = "Se guardo tu CIF"

    
    @IBAction func atras(_ sender: AnyObject) {
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func ayuda(_ sender: AnyObject) {
        
        
    }

    
    @IBAction func guardaCIF(_ sender: AnyObject) {
        
       presentaSubMenu() 
    }
    
    
    func presentaSubMenu(){
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.view.tintColor = UIColor(red: 0/255,green: 122/255, blue:255/255,  alpha: 0.8)
        let tomarFoto = UIAlertAction(title: "Descargar", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            //self.useCamera()
            self.mensaje = "       Se descargo tu CIF"
            self.showAlert()
        })
        let libreria = UIAlertAction(title: "Enviar", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            //self.useCamaraRoll()
            self.mensaje = "        Se envio tu CIF"
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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
