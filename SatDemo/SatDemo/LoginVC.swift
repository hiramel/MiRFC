//
//  LoginVC.swift
//  SatDemo
//
//  Created by Hiram Elguézabal Jiménez on 04/11/16.
//  Copyright © 2016 Hiram Elguézabal Jiménez. All rights reserved.
//

import UIKit
import TKSwarmAlert

class LoginVC: UIViewController,UITextFieldDelegate {
    
    let swAlert = TKSwarmAlert(backgroundType: .blur)
    var posicionView : CGFloat!
    
    @IBOutlet weak var menuBoton: UIButton!
    
    

    @IBAction func callAlert(_ sender: AnyObject) {
        onTapShowButton()
        
    }
    
    
    @IBAction func obtenRFC(_ sender: AnyObject) {
       
        let valida = validacionCurpVC(nibName: "validacionCurpVC", bundle: nil)
        navigationController?.pushViewController(valida, animated: true)
//        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType(rawValue: UInt(4))!)
//        SVProgressHUD.show()
        
    }
    
    @IBAction func obtenerConstancia(_ sender: UIButton) {
       
//        let constancia = InicioRfcVC(nibName: "InicioRfcVC", bundle: nil)
//        navigationController?.pushViewController(constancia, animated: true)
//        SVProgressHUD.dismiss()
        Singleton.showNombreMenu = "lleno"
        let frontViewController =  InicioRfcVC()//create instance of frontVC
        let rearViewController  =  Menu()//create instance of rearVC(menuVC)
        
        
        //create instance of swRevealVC based on front and rear VC
        let swRevealVC = SWRevealViewController(rearViewController: rearViewController, frontViewController: frontViewController)
        swRevealVC?.toggleAnimationType = SWRevealToggleAnimationType.easeOut
        swRevealVC?.toggleAnimationDuration = 0.30
        
        navigationController?.pushViewController(swRevealVC!, animated: true)


        
    }
    
    @IBAction func necesitasAyuda(_ sender: AnyObject) {
    
        let ayuda = AyudaLoginVC(nibName: "AyudaLoginVC", bundle: nil)
        //ayuda.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        ayuda.modalPresentationStyle = UIModalPresentationStyle.custom
        ayuda.modalTransitionStyle = UIModalTransitionStyle.crossDissolve

    
        present(ayuda, animated: true, completion: nil)
    
    }
    
    @IBOutlet weak var rfcTxt: UITextField!
    
    @IBOutlet weak var contrasenia: UITextField!
    
    
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
        hideKeyboardOnTap()
        rfcTxt.delegate = self
        contrasenia.delegate = self
        menuBoton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().rearViewRevealWidth = 210
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)


    }
    
    func onTapShowButton() {
        self.showAlert()
    }

    func showAlert() {
        swAlert.show(self.makeSampleViews2())
        //        swAlert.addNextViews(self.makeSampleViews3())
        //        swAlert.addNextViews(self.makeSampleViews2())
        //swAlert.addNextViews(self.makeSampleViews4())
    }
    
    func makeSampleViews2()->[UIView] {
        let height:CGFloat = 64
        let width:CGFloat = 300
        let margin:CGFloat = 10
        let x:CGFloat = self.view.frame.width / 2 - width/2
        let y:CGFloat = 160//240
        let f1 = CGRect(x: x, y: y, width: width, height: height)
        let f2 = CGRect(x: x, y: y + (height + margin), width: width, height: height)
        let f3 = CGRect(x: x, y: y + (height + margin) * 2, width: width, height: height)
        
        var views:[UIView] = []
        
        let view1 = SampleDesignView(type: SampleDesignViewType.bar(icon:UIImage(named: "apple88"), text:"uno"), frame: f1)
        views.append(view1)
        
        let view2 = SampleDesignView(type: SampleDesignViewType.bar(icon:UIImage(named: "apple88"), text:"dos!!"), frame: f2)
        views.append(view2)//clear
        //
        let view3 = SampleDesignView(type: SampleDesignViewType.bar(icon:UIImage(named: "apple88"), text:"tres!!"), frame: f3)
        views.append(view3)
        
        return views
    }
    
    func hideKeyboardOnTap(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.rfcTxt {
            self.contrasenia.becomeFirstResponder()
        }else{
            self.contrasenia.resignFirstResponder()
        }
        
        //validaNombres(textField)
        return true
    }
    
    
    
    func keyboardWillShow(notification: NSNotification) {
        
        let alturaSuperview =  UIScreen.main.bounds.size.height
        let medidasTeclado = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        

        let alturaTeclado = medidasTeclado?.height
        let bordeTeclado = alturaSuperview - alturaTeclado!
        
            posicionView = 0
            var posicionCampo :CGFloat!
            if rfcTxt.isEditing{
            } else if contrasenia.isEditing{
                let alturaCampo = contrasenia.frame.height
                posicionCampo = contrasenia.frame.origin.y
                posicionView = posicionCampo - bordeTeclado + alturaCampo + 10
            }
                self.view.window?.frame.origin.y = -1 * posicionView
        
        }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.view.window?.frame.origin.y != 0 {
            self.view.window?.frame.origin.y += posicionView
        }
    }






}
