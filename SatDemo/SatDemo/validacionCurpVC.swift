//
//  validacionCurpVC.swift
//  SatDemo
//
//  Created by Hiram Elguézabal Jiménez on 08/11/16.
//  Copyright © 2016 Hiram Elguézabal Jiménez. All rights reserved.
//

import UIKit

class validacionCurpVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, respuestaExitosaPostDelegate, UITextFieldDelegate{

    let conexion = ConnectionServices()
    let swAlert = TKSwarmAlert(backgroundType: .transparentBlack(alpha: 0.5))

    
    @IBAction func buscarAct(_ sender: AnyObject) {
        
        curpTxt.resignFirstResponder()
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType(rawValue: UInt(4))!)
        SVProgressHUD.show(withStatus: "CARGANDO")
        conexion.delegate = self
        //let url = urlServicios.urlBaseServicios + "/" + idSolicitud + "/" + idNoCliente + "/CONTRATO"
        
        var testId = ""
        
        testId = curpTxt.text!
        
        if (testId == ""){
            testId = "0"
        }
        
        let url = "http://testjorge.mybluemix.net/api/v1/test?_id=" + testId

        conexion.consultaServicioGET(url, httpMethod: "GET")
    }
    
    
    @IBAction func atras(_ sender: AnyObject) {
       _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            tengoCurpView.isHidden = false
            noTengoCurpView.isHidden = true
            //popularView.hidden = false
        case 1:
            tengoCurpView.isHidden = true
            noTengoCurpView.isHidden = false
            //popularView.hidden = true
        default:
            break;
        }
    }
    
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var tengoCurpView: UIView!
    
    @IBOutlet weak var validaCurpBtn: UIButton!
    
    @IBOutlet weak var noTengoCurpView: UIView!
 
    @IBOutlet weak var buscar: UIButton!
    
    @IBOutlet weak var fecNacPicker: UITextField!
    
    @IBOutlet weak var entNacPicker: UITextField!
    
    @IBOutlet weak var curpTxt: UITextField!
    
    
    
    var estados = [[String:String]]()
    var descripciones = [String]()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSegmentedControl()
        hideKeyboardOnTap()
        addDatePicker()
        startParsing()
        addPicker()
        curpTxt.delegate = self



    }
    
    func setSegmentedControl(){
        segment.layer.cornerRadius = 4.0
        segment.clipsToBounds = true
        validaCurpBtn.layer.cornerRadius = 10
        buscar.layer.cornerRadius = 10
    
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
        fecNacPicker.inputAccessoryView = toolBar
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.backgroundColor = UIColor.white
        datePickerView.datePickerMode = UIDatePickerMode.date
        datePickerView.locale = NSLocale(localeIdentifier: "es_MX") as Locale
        fecNacPicker.inputView = datePickerView
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
        
//        let mayoriaEdad = NSCalendar.currentCalendar.dateByAddingUnit(.Year, value: -18, toDate: NSDate(), options: NSCalendar.Options(rawValue: 0))!
//        
//        datePickerView.date = mayoriaEdad
        
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "es_MX") as Locale!
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        fecNacPicker.text = dateFormatter.string(from: sender.date)
        
        
        let dateFormatterSingleton = DateFormatter()
        dateFormatterSingleton.dateFormat = "yyyy-MM-dd"
        //fechaNacimiento = dateFormatterSingleton.stringFromDate(sender.date)
    }

    func donePressed(sender: UIBarButtonItem) {
        fecNacPicker.resignFirstResponder()
        
    }
    

    //TODO PONER ESTO EN UN JSON CON LAS ACTIVIDADES GENERICAS Y ESPECIFICAS
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
    
    
    func startParsing()
    {
        
        //var ocupaciones = ""
        
        
        let dict =  conexion.jsonParsingFromFile(conNombre: "nacimiento")
        let datos = dict["datos"] as! NSDictionary
        estados = datos["estados"] as! [[String:String]]
        var estadosFilter = [String]()
        var count = estados.count
        count = count - 1
        
        for i in 0...count {
            let estado = estados[i]
            estadosFilter.append(estado["descripcion"]! )
        }
        descripciones = estadosFilter
    }
    
    func addPicker(){
        pickerDataSource = descripciones
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
        let siguienteButton = UIBarButtonItem(title: "Siguiente", style: UIBarButtonItemStyle.plain, target: self, action: #selector(validacionCurpVC.donePicker))
        siguienteButton.tintColor = UIColor.blue
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, siguienteButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        entNacPicker.inputView = pickerView
        entNacPicker.inputAccessoryView = toolBar
    }


    
    func donePicker() {
        entNacPicker.resignFirstResponder()
    }

    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
            valorPicker = pickerDataSource[row]
            self.entNacPicker.text = valorPicker
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


    
    func respuestaServicioGET(respuesta: NSDictionary, mensaje: String) {
        DispatchQueue.main.async(execute: {
            SVProgressHUD.dismiss()
            
            if mensaje == "OK"{
                var estatus : Int!
                estatus = respuesta["estatus"] as! Int
                if estatus == 0{
                    let datos = respuesta["datos"] as! NSDictionary
                    
                    
                    let nombre = datos["nombre"]
                    Singleton.nombre = nombre as! String?
                    let apPaterno = datos["apPaterno"]
                    Singleton.apPaterno = apPaterno as! String?
                    let apMaterno = datos["apMaterno"]
                    Singleton.apMaterno = apMaterno as! String?
                    let sexo = datos["sexo"]
                    Singleton.genero = sexo as! String?
                    let fecNac = datos["fecNac"]
                    Singleton.fecNac = fecNac as! String?
                    let nacionalidad = datos["nacionalidad"]
                    Singleton.nacionalidad = nacionalidad as! String?
                    let documento  = datos["documento"]
                    Singleton.documentoProb = documento as! String?
                    let entidad  = datos["entidad"]
                    Singleton.entidadNac = entidad as! String?
                    let municipio  = datos["municipio"]
                    Singleton.municipio = municipio as! String?
                    let anio  = datos["anio"]
                    Singleton.anio = anio as! String?
                    let libro  = datos["libro"]
                    Singleton.libro = libro as! String?
                    let tomo  = datos["tomo"]
                    Singleton.tomo = tomo as! String?
                    let foja  = datos["foja"]
                    Singleton.foja = foja as! String?
                    let acta  = datos["acta"]
                    Singleton.acta = acta as! String?
                    let extranjero = datos["extrangero"]
                    Singleton.extranjero = extranjero as! String?
                    let naturalizado = datos["naturalizado"]
                    Singleton.naturalizado = naturalizado as! String?

                    
                    
                    if (Singleton.extranjero == "Y"){

                        if (Singleton.naturalizado == "Y"){
                            Singleton.anioRegistro = datos["anioRegistro"] as! String?
                            Singleton.folioCarta = datos["folioCarta"] as! String?
                            Singleton.numeroRegistro = ""
                            Singleton.numeroExpediente = ""

                            
                        }else{
                            Singleton.numeroRegistro = datos["numeroRegistro"] as! String?
                            Singleton.numeroExpediente = datos["numeroExpediente"] as! String?
                            Singleton.anioRegistro = ""
                            Singleton.folioCarta = ""

                        }
                        
                        let valida = ValidacionDatosExt(nibName: "ValidacionDatosExt", bundle: nil)
                        self.navigationController?.pushViewController(valida, animated: true)

                        
                    
                    }else{
                        let valida = ValidacionDatosVC(nibName: "ValidacionDatosVC", bundle: nil)
                        self.navigationController?.pushViewController(valida, animated: true)

                    }

                    
                    
                    

 
                    
                }else if estatus == -1 {
                    let mensajeError = respuesta["descripcion"] as! String
//                    self.presentaValidacion("Error", subtitulo: mensajeError ,imagen: validaciones.inconoErrorValida)
                }else if estatus == -2 {
//                    let mensajeError = validaciones.errorGenerico
//                    self.presentaValidacion("Error", subtitulo: mensajeError ,imagen: validaciones.inconoErrorValida)
                }else if estatus == -3 {
                    //let mensajeError = validaciones.errorGenerico
//                    self.presentaValidacion("Error", subtitulo: "cerrar applicacion" ,imagen: validaciones.inconoErrorValida)
                }
                
            }else{
                self.showAlert()
//                self.presentaValidacion("Error", subtitulo: mensaje ,imagen: validaciones.inconoErrorValida)
            }
        })
    }
    
    
    func showAlert() {
        swAlert.show(self.makeSampleViews2())
        //        swAlert.addNextViews(self.makeSampleViews3())
        //        swAlert.addNextViews(self.makeSampleViews2())
        //swAlert.addNextViews(self.makeSampleViews4())
    }
    
    func makeSampleViews2()->[UIView] {

//        let height:CGFloat = 64
//        let width:CGFloat = 300
//        let margin:CGFloat = 10
//        let x:CGFloat = self.view.frame.width / 2 - width/2
//        let y:CGFloat = 160//240

        let height:CGFloat = 150
        let width:CGFloat = 300
        let margin:CGFloat = 10
        let x:CGFloat = self.view.frame.width / 2 - width/2
        let y:CGFloat = 160//240

        
        let f1 = CGRect(x: x, y: y, width: width, height: height)
//        let f2 = CGRect(x: x, y: y + (height + margin), width: width, height: height)
//        let f3 = CGRect(x: x, y: y + (height + margin) * 2, width: width, height: height)
        
        var views:[UIView] = []
        
        let textoAlerta = "No se pudo encontrar RFC."
        
        let view1 = SampleDesignView(type: SampleDesignViewType.bar(icon:UIImage(named: "satLogo"), text:textoAlerta), frame: f1)
        views.append(view1)
        
//        let view2 = SampleDesignView(type: SampleDesignViewType.bar(icon:UIImage(named: "apple88"), text:"dos!!"), frame: f2)
//        views.append(view2)//clear
//        //
//        let view3 = SampleDesignView(type: SampleDesignViewType.bar(icon:UIImage(named: "apple88"), text:"tres!!"), frame: f3)
//        views.append(view3)
        
        return views
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        curpTxt.resignFirstResponder()
        buscarAct(textField)
        return true
    }




 
}
