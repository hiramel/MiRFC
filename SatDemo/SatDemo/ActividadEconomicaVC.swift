//
//  ActividadEconomicaVC.swift
//  SatDemo
//
//  Created by Hiram Elguézabal Jiménez on 11/11/16.
//  Copyright © 2016 Hiram Elguézabal Jiménez. All rights reserved.
//

import UIKit

class ActividadEconomicaVC: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate{

    
    
    @IBOutlet weak var fecNacTxt: UITextField!
    @IBOutlet weak var actividadTxt: UITextField!
    @IBOutlet weak var respuesta1Txt: UITextField!
    @IBOutlet weak var respuesta2Txt: UITextField!
    @IBOutlet weak var continuarBtn: UIButton!
    
    
    
    @IBAction func continuar(_ sender: AnyObject) {
        
        let valida = AcuseVC(nibName: "AcuseVC", bundle: nil)
        navigationController?.pushViewController(valida, animated: true)

        
    }
    
    
    @IBAction func atras(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDatePicker()
        addPickerActividad()
        continuarBtn.layer.cornerRadius = 4
        hideKeyboardOnTap()



    }
    
    func hideKeyboardOnTap(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func addDatePicker(){
        
        let toolBar = UIToolbar(frame: CGRect(x:0, y:self.view.frame.size.height/6, width:self.view.frame.size.width, height:40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        let okBarBtn = UIBarButtonItem(title: "Siguiente", style: UIBarButtonItemStyle.plain, target: self, action: #selector(validacionCurpVC.donePressed))
        okBarBtn.tintColor = UIColor.blue
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        toolBar.setItems([flexSpace,okBarBtn], animated: true)
        fecNacTxt.inputAccessoryView = toolBar
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.backgroundColor = UIColor.white
        datePickerView.datePickerMode = UIDatePickerMode.date
        datePickerView.locale = NSLocale(localeIdentifier: "es_MX") as Locale
        fecNacTxt.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(validacionCurpVC.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        let calendar = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian);
        let todayDate = NSDate()
        let components = calendar?.components([NSCalendar.Unit.year,NSCalendar.Unit.month,NSCalendar.Unit.day], from: todayDate as Date)
        var anioMayorEdad =  0
        anioMayorEdad = (components?.year)! - 18
        let minimumYear = (components?.year)! - anioMayorEdad
        let minimumMonth = (components?.month)! - 1
        let minimumDay = (components?.day)! - 1
        let comps = NSDateComponents();
        comps.year = -minimumYear
        comps.month = -minimumMonth
        comps.day = -minimumDay
}
    
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "es_MX") as Locale!
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        fecNacTxt.text = dateFormatter.string(from: sender.date)
        
        
        let dateFormatterSingleton = DateFormatter()
        dateFormatterSingleton.dateFormat = "yyyy-MM-dd"
        //fechaNacimiento = dateFormatterSingleton.stringFromDate(sender.date)
    }
    
    func donePressed(sender: UIBarButtonItem) {
        //fecNacTxt.resignFirstResponder()
        actividadTxt.becomeFirstResponder()
    }
    
    var pickerDataSource = ["Construcción",
                            "Industrias manufactureras",
                            "Comercio al por mayor",
                            "Comercio al por menor",
                            "Transportes, correos y almacenamiento",
                            "Información en medios masivos",
                            "Servicios financieros y de seguros",
                            "Servicios inmobiliarios",
                            "Servicios profesionales, científicos y técnicos",
                            "Dirección de corporativos y empresas",
                            "Servicios de apoyo a los negocios",
                            "Servicios educativos"]
    var valorPicker = ""

    
    func addPickerActividad(){
       // pickerDataSource = descripciones
        valorPicker = pickerDataSource[0]
        let alturaSuperview =  UIScreen.main.bounds.size.height
        let alturaPicker = alturaSuperview * 0.324
        let pickerView = UIPickerView(frame: CGRect(x:0, y:200, width:view.frame.width, height:alturaPicker))
        pickerView.backgroundColor = UIColor.white
        pickerView.showsSelectionIndicator = true
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.tag = 1
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let siguienteButton = UIBarButtonItem(title: "Terminar", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ActividadEconomicaVC.donePicker))
        siguienteButton.tintColor = UIColor.blue
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, siguienteButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        actividadTxt.inputView = pickerView
        actividadTxt.inputAccessoryView = toolBar
    }
    func donePicker() {
        actividadTxt.resignFirstResponder()
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        valorPicker = pickerDataSource[row]
        self.actividadTxt.text = valorPicker
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func numberOfComponentsInPickerView(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if let titleLabel = view as? UILabel {
            titleLabel.text = pickerDataSource[row]
            return titleLabel
        } else {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 16)
            titleLabel.textAlignment = NSTextAlignment.center
            titleLabel.text = pickerDataSource[row]
            return titleLabel
        }
    }





}
