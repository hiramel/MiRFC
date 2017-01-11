//
//  DomicilioActual.swift
//  SatDemo
//
//  Created by Hiram Elguézabal Jiménez on 23/11/16.
//  Copyright © 2016 Hiram Elguézabal Jiménez. All rights reserved.
//

import UIKit

class DomicilioActual: UIViewController, respuestaMapa,  UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var ubicaDomicilioBtn: UIButton!
    @IBOutlet weak var viewCodigoPostal: UIView!
    @IBOutlet weak var viewTipovialidad: UIView!
    @IBOutlet weak var viewNombreVialidad: UIView!
    @IBOutlet weak var viewNoExt: UIView!
    @IBOutlet weak var viewNoInt: UIView!
    @IBOutlet weak var viewColonia: UIView!
    @IBOutlet weak var viewLocalidad: UIView!
    @IBOutlet weak var viewMunicipio: UIView!
    @IBOutlet weak var viewEntidad: UIView!
    @IBOutlet weak var viewEntreCalle: UIView!
    @IBOutlet weak var viewYCalle: UIView!
    @IBOutlet weak var viewTipoInmueble: UIView!
    @IBOutlet weak var viewCaracDomicilio: UIView!
    @IBOutlet weak var viewReferencias: UIView!
    @IBOutlet weak var viewLadaTelefono: UIView!
    @IBOutlet weak var viewCorreo: UIView!
    @IBOutlet weak var continuarBtn: UIButton!
    
    @IBOutlet weak var codigoPostalTxt: UITextField!
    @IBOutlet weak var tipoVialidadTxt: UITextField!
    @IBOutlet weak var nombreVialidadTxt: UITextField!
    @IBOutlet weak var noExtTxt: UITextField!
    @IBOutlet weak var noIntTxt: UITextField!
    @IBOutlet weak var coloniaTxt: UITextField!
    @IBOutlet weak var localidadTxt: UITextField!
    @IBOutlet weak var municipioTxt: UITextField!
    @IBOutlet weak var entidadTxt: UITextField!
    @IBOutlet weak var entreCalle: UITextField!
    @IBOutlet weak var yCalleTxt: UITextField!
    @IBOutlet weak var tipoTelefono: UITextField!
    @IBOutlet weak var tipoDomicilio: UITextField!
    @IBOutlet weak var tipoInmueble: UITextField!
    @IBOutlet weak var caracteristicasDom: UITextField!
    @IBOutlet weak var referencias: UITextField!
    @IBOutlet weak var telefono: UITextField!
    @IBOutlet weak var correo: UITextField!
    
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    var posicionView : CGFloat!

    
    
    
    @IBAction func confirmarAct(_ sender: UIButton) {
        
        let valida = ActividadEconomicaVC(nibName: "ActividadEconomicaVC", bundle: nil)
        navigationController?.pushViewController(valida, animated: true)

        
    }
    
    @IBAction func regresarAct(_ sender: AnyObject) {
        
        _ = navigationController?.popViewController(animated: true)

        
    }
    
    
    @IBAction func ubicaDomicilio(_ sender: UIButton) {
       
        let condiciones = LocalizaDomicilio(nibName: "LocalizaDomicilio", bundle: nil)
        condiciones.delegateMapa = self
        condiciones.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        present(condiciones, animated: true, completion: nil)

        
    }
    
    
    @IBAction func cambiaTel(_ sender: AnyObject) {
        
        if (tipoTelefono.text == "Movil"){
            tipoTelefono.text = "Fijo"
        }else{
            tipoTelefono.text = "Movil"
        }
        
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
        self.automaticallyAdjustsScrollViewInsets = false;
        
        continuarBtn.layer.cornerRadius = 4
        
        ubicaDomicilioBtn.backgroundColor = .clear
        ubicaDomicilioBtn.layer.cornerRadius = 5
        ubicaDomicilioBtn.layer.borderWidth = 1
        ubicaDomicilioBtn.layer.borderColor = UIColor(red: 0/255,green: 122/255, blue:255/255,  alpha: 0.8).cgColor
        hideKeyboardOnTap()
        addPickerActividad()
        addPickerVialidad()
        addPickerNombreColonia()
        addPickerNombreLocalidad()
        addPickerNombreMunicipio()
        addPickerNombreEntidad()
        addPickerTipoInmueble()
        addNextButtonCodigoPostal()
        addNextButtonNombreVialidad()
        addNextButtonNumExt()
        addNextButtonNumInt()
        addNextEntreCalle()
        addNextYCalle()
        addDoneCaracteristicas()
        addDoneReferencias()
        addDoneTelefono()
        addDoneCorreo()
        nombreVialidadTxt.delegate = self
        noExtTxt.delegate = self
        noIntTxt.delegate = self
        entreCalle.delegate = self
        yCalleTxt.delegate = self
        caracteristicasDom.delegate = self
        referencias.delegate = self
        telefono.delegate = self
        correo.delegate = self
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        
    }
    
    func hideKeyboardOnTap(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    
    func respuestaExitosaMapa() {
        
        codigoPostalTxt.text = "01219"
        tipoVialidadTxt.text = "Avenida"
        nombreVialidadTxt.text = "Joaquin Gallo"
        noExtTxt.text = "336"
        noIntTxt.text = "12"
        coloniaTxt.text = "Zedec Sta Fe"
        localidadTxt.text = "Poniente"
        municipioTxt.text = "Alvaro Obregon"
        entidadTxt.text = "DF"
        entreCalle.text = "Joaquin Gallo"
        yCalleTxt.text = "Alfonoso Napoles Gandara"
        tipoDomicilio.text = "Propio"
        tipoInmueble.text = "Propio"
        
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
    
    var pickerDataSourceTipoVialidad = ["Avenida",
                                        "Calle",
                                        "Andador",
                                        "Boulevard"]
   
    var pickerDatasourceNombreColonia = ["San Pedro de los Pinos",
                                         "Carola",
                                         "Espartaco",
                                         "El Reloj",
                                         "Los Robles",
                                         "Olivos"
                                        ]
   
    var pickerDatasourceNombreLocalidad = ["ADOLFO LOPEZ MATEOS",
                                         "ADOLFO RUIZ CORTINES",
                                         "AERONAUTICA MILITAR",
                                         "AGRICOLA METROPOLITANA",
                                         "AGRICULTURA",
                                         "AHUEHUETES"
    ]
    
    var pickerDatasourceNombreMunicipio = ["Azcapotzalco",
                                           "Benito Juárez",
                                           "Coyoacán",
                                           "Cuajimalpa de Morelos",
                                           "Cuauhtémoc",
                                           "Gustavo A. Madero",
                                           "Iztacalco"
    ]

    var pickerDatasourceNombreEntidad = ["Distrito Federal",
                                           "Nuevo León",
                                           "Baja California Sur",
                                           "Baja California",
                                           "Sonora",
                                           "Coahuila",
                                           "Colima"
    ]

    
    
    var pickerDatasourceTipoInmueble = ["Nuevo",
                                         "Rustico",
                                         "Urbano",
                                         "Rentado",
                                         "Propio"
    ]

    
    var valorPicker = ""
    var valorPickerTipoVialidad = ""
    var valorPickerNombreColonia = ""
    var valorPickerNombreLocalidad = ""
    var valorPickerNombreMunicipio = ""
    var valorPickerNombreEntidad = ""
    var valorPickerTipoInmueble = ""
    
    
    
    
    
    func addPickerActividad(){
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
        let siguienteButton = UIBarButtonItem(title: "Siguiente", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DomicilioActual.donePicker))
        siguienteButton.tintColor = UIColor.blue
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, siguienteButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        tipoDomicilio.inputView = pickerView
        tipoDomicilio.inputAccessoryView = toolBar
    }
    
    
    func addPickerVialidad(){
        valorPickerTipoVialidad = pickerDataSourceTipoVialidad[0]
        let alturaSuperview =  UIScreen.main.bounds.size.height
        let alturaPicker = alturaSuperview * 0.324
        let pickerView = UIPickerView(frame: CGRect(x:0, y:200, width:view.frame.width, height:alturaPicker))
        pickerView.backgroundColor = UIColor.white
        pickerView.showsSelectionIndicator = true
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.tag = 2
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let siguienteButton = UIBarButtonItem(title: "Siguiente", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DomicilioActual.doneTipoVialidad))
        siguienteButton.tintColor = UIColor.blue
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, siguienteButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        tipoVialidadTxt.inputView = pickerView
        tipoVialidadTxt.inputAccessoryView = toolBar
    }
    
    func addPickerNombreColonia(){
        valorPickerTipoVialidad = pickerDataSourceTipoVialidad[0]
        let alturaSuperview =  UIScreen.main.bounds.size.height
        let alturaPicker = alturaSuperview * 0.324
        let pickerView = UIPickerView(frame: CGRect(x:0, y:200, width:view.frame.width, height:alturaPicker))
        pickerView.backgroundColor = UIColor.white
        pickerView.showsSelectionIndicator = true
        pickerView.dataSource = self
        pickerView.delegate = self

        pickerView.tag = 3
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let siguienteButton = UIBarButtonItem(title: "Siguiente", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DomicilioActual.doneColonia))
        siguienteButton.tintColor = UIColor.blue
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, siguienteButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        coloniaTxt.inputView = pickerView
        coloniaTxt.inputAccessoryView = toolBar
    }
    
    func addPickerNombreLocalidad(){
        valorPickerTipoVialidad = pickerDataSourceTipoVialidad[0]
        let alturaSuperview =  UIScreen.main.bounds.size.height
        let alturaPicker = alturaSuperview * 0.324
        let pickerView = UIPickerView(frame: CGRect(x:0, y:200, width:view.frame.width, height:alturaPicker))
        pickerView.backgroundColor = UIColor.white
        pickerView.showsSelectionIndicator = true
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.tag = 4
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let siguienteButton = UIBarButtonItem(title: "Siguiente", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DomicilioActual.doneLocalidad))
        siguienteButton.tintColor = UIColor.blue
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, siguienteButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        localidadTxt.inputView = pickerView
        localidadTxt.inputAccessoryView = toolBar
    }

    func addPickerNombreMunicipio(){
        valorPickerTipoVialidad = pickerDataSourceTipoVialidad[0]
        let alturaSuperview =  UIScreen.main.bounds.size.height
        let alturaPicker = alturaSuperview * 0.324
        let pickerView = UIPickerView(frame: CGRect(x:0, y:200, width:view.frame.width, height:alturaPicker))
        pickerView.backgroundColor = UIColor.white
        pickerView.showsSelectionIndicator = true
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.tag = 5
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let siguienteButton = UIBarButtonItem(title: "Siguiente", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DomicilioActual.doneMunicipio))
        siguienteButton.tintColor = UIColor.blue
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, siguienteButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        municipioTxt.inputView = pickerView
        municipioTxt.inputAccessoryView = toolBar
    }

    func addPickerNombreEntidad(){
        valorPickerNombreEntidad = pickerDatasourceNombreEntidad[0]
        let alturaSuperview =  UIScreen.main.bounds.size.height
        let alturaPicker = alturaSuperview * 0.324
        let pickerView = UIPickerView(frame: CGRect(x:0, y:200, width:view.frame.width, height:alturaPicker))
        pickerView.backgroundColor = UIColor.white
        pickerView.showsSelectionIndicator = true
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.tag = 6
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let siguienteButton = UIBarButtonItem(title: "Siguiente", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DomicilioActual.doneEntidad))
        siguienteButton.tintColor = UIColor.blue
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, siguienteButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        entidadTxt.inputView = pickerView
        entidadTxt.inputAccessoryView = toolBar
    }
    
    func addPickerTipoInmueble(){
        valorPickerTipoInmueble = pickerDatasourceTipoInmueble[0]
        let alturaSuperview =  UIScreen.main.bounds.size.height
        let alturaPicker = alturaSuperview * 0.324
        let pickerView = UIPickerView(frame: CGRect(x:0, y:200, width:view.frame.width, height:alturaPicker))
        pickerView.backgroundColor = UIColor.white
        pickerView.showsSelectionIndicator = true
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.tag = 7
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let siguienteButton = UIBarButtonItem(title: "Siguiente", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DomicilioActual.doneTipoInmueble))
        siguienteButton.tintColor = UIColor.blue
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, siguienteButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        tipoInmueble.inputView = pickerView
        tipoInmueble.inputAccessoryView = toolBar
    }
    
    
    func addNextButtonCodigoPostal()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:320, height:50))
        doneToolbar.barStyle = UIBarStyle.default
        doneToolbar.isTranslucent = true
        doneToolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        doneToolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Siguiente", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DomicilioActual.doneCodigoPostal)      )
        done.tintColor = UIColor.blue
        doneToolbar.items = [flexSpace,done]
        doneToolbar.sizeToFit()
        self.codigoPostalTxt.inputAccessoryView = doneToolbar
    }

    
    func addNextButtonNombreVialidad()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:320, height:50))
        doneToolbar.barStyle = UIBarStyle.default
        doneToolbar.isTranslucent = true
        doneToolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        doneToolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Siguiente", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DomicilioActual.doneNombreVialidad))
        done.tintColor = UIColor.blue
        doneToolbar.items = [flexSpace,done]
        doneToolbar.sizeToFit()
        self.nombreVialidadTxt.inputAccessoryView = doneToolbar
    }

    
    
    func addNextButtonNumExt()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:320, height:50))
        doneToolbar.barStyle = UIBarStyle.default
        doneToolbar.isTranslucent = true
        doneToolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        doneToolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Siguiente", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DomicilioActual.doneNoExt))
        done.tintColor = UIColor.blue
        doneToolbar.items = [flexSpace,done]
        doneToolbar.sizeToFit()
        self.noExtTxt.inputAccessoryView = doneToolbar
    }

    
    
    func addNextButtonNumInt()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:320, height:50))
        doneToolbar.barStyle = UIBarStyle.default
        doneToolbar.isTranslucent = true
        doneToolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        doneToolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Siguiente", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DomicilioActual.doneNoInt))
        done.tintColor = UIColor.blue
        doneToolbar.items = [flexSpace,done]
        doneToolbar.sizeToFit()
        self.noIntTxt.inputAccessoryView = doneToolbar
    }
    
    func addNextEntreCalle()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:320, height:50))
        doneToolbar.barStyle = UIBarStyle.default
        doneToolbar.isTranslucent = true
        doneToolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        doneToolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Siguiente", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DomicilioActual.doneEntreCalle))
        done.tintColor = UIColor.blue
        doneToolbar.items = [flexSpace,done]
        doneToolbar.sizeToFit()
        self.entreCalle.inputAccessoryView = doneToolbar
    }

    
    func addNextYCalle()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:320, height:50))
        doneToolbar.barStyle = UIBarStyle.default
        doneToolbar.isTranslucent = true
        doneToolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        doneToolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Siguiente", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DomicilioActual.doneYCalle))
        done.tintColor = UIColor.blue
        doneToolbar.items = [flexSpace,done]
        doneToolbar.sizeToFit()
        self.yCalleTxt.inputAccessoryView = doneToolbar
    }

    
    func addDoneCaracteristicas()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:320, height:50))
        doneToolbar.barStyle = UIBarStyle.default
        doneToolbar.isTranslucent = true
        doneToolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        doneToolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Siguiente", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DomicilioActual.doneCaracteristicas))
        done.tintColor = UIColor.blue
        doneToolbar.items = [flexSpace,done]
        doneToolbar.sizeToFit()
        self.caracteristicasDom.inputAccessoryView = doneToolbar
    }
    
    
    func addDoneReferencias()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:320, height:50))
        doneToolbar.barStyle = UIBarStyle.default
        doneToolbar.isTranslucent = true
        doneToolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        doneToolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Siguiente", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DomicilioActual.doneReferencias))
        done.tintColor = UIColor.blue
        doneToolbar.items = [flexSpace,done]
        doneToolbar.sizeToFit()
        self.referencias.inputAccessoryView = doneToolbar
    }

    func addDoneTelefono()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:320, height:50))
        doneToolbar.barStyle = UIBarStyle.default
        doneToolbar.isTranslucent = true
        doneToolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        doneToolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Siguiente", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DomicilioActual.doneTelefono))
        done.tintColor = UIColor.blue
        doneToolbar.items = [flexSpace,done]
        doneToolbar.sizeToFit()
        self.telefono.inputAccessoryView = doneToolbar
    }
    
    
    func addDoneCorreo()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:320, height:50))
        doneToolbar.barStyle = UIBarStyle.default
        doneToolbar.isTranslucent = true
        doneToolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        doneToolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Terminar", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DomicilioActual.doneCorreo))
        done.tintColor = UIColor.blue
        doneToolbar.items = [flexSpace,done]
        doneToolbar.sizeToFit()
        self.correo.inputAccessoryView = doneToolbar
    }


    
    func donePicker() {
        tipoDomicilio.resignFirstResponder()
        codigoPostalTxt.becomeFirstResponder()
    }
    
    func doneCodigoPostal(){
        codigoPostalTxt.resignFirstResponder()
        tipoVialidadTxt.becomeFirstResponder()
    }
    
    func doneTipoVialidad(){
        tipoVialidadTxt.resignFirstResponder()
        nombreVialidadTxt.becomeFirstResponder()
    }
    
    
    func doneNombreVialidad(){
        nombreVialidadTxt.resignFirstResponder()
        noExtTxt.becomeFirstResponder()
    }

    func doneNoExt(){
        noExtTxt.resignFirstResponder()
        noIntTxt.becomeFirstResponder()
    }

    func doneNoInt(){
        noIntTxt.resignFirstResponder()
        coloniaTxt.becomeFirstResponder()
    }

    func doneColonia(){
        coloniaTxt.resignFirstResponder()
        localidadTxt.becomeFirstResponder()
    }
    
    func doneLocalidad(){
        localidadTxt.resignFirstResponder()
        municipioTxt.becomeFirstResponder()
    }
    func doneMunicipio(){
        municipioTxt.resignFirstResponder()
        entidadTxt.becomeFirstResponder()
    }

    func doneEntidad(){
        entidadTxt.resignFirstResponder()
        entreCalle.becomeFirstResponder()
    }
    
    func doneEntreCalle(){
        entreCalle.resignFirstResponder()
        yCalleTxt.becomeFirstResponder()
    }

    func doneYCalle(){
        //yCalleTxt.resignFirstResponder()
        tipoInmueble.becomeFirstResponder()
    }


    func doneTipoInmueble(){
        //tipoInmueble.resignFirstResponder()
        caracteristicasDom.becomeFirstResponder()
    }

    func doneCaracteristicas(){
        //caracteristicasDom.resignFirstResponder()
        referencias.becomeFirstResponder()
    }

    
    func doneReferencias(){
        //referencias.resignFirstResponder()
        telefono.becomeFirstResponder()
    }

    func doneTelefono(){
        //telefono.resignFirstResponder()
        correo.becomeFirstResponder()
    }
    
    func doneCorreo(){
        correo.resignFirstResponder()
    }
    


    



 
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(pickerView.tag == 1){
            valorPicker = pickerDataSource[row]
            self.tipoDomicilio.text = valorPicker
        }else if (pickerView.tag == 2){
            valorPickerTipoVialidad = pickerDataSourceTipoVialidad[row]
            self.tipoVialidadTxt.text = valorPickerTipoVialidad
        }else if (pickerView.tag == 3){
            valorPickerNombreColonia = pickerDatasourceNombreColonia[row]
            self.coloniaTxt.text = valorPickerNombreColonia
        }else if (pickerView.tag == 4){
            valorPickerNombreLocalidad = pickerDatasourceNombreLocalidad[row]
            self.localidadTxt.text = valorPickerNombreLocalidad
        }else if (pickerView.tag == 5){
            valorPickerNombreMunicipio = pickerDatasourceNombreMunicipio[row]
            self.municipioTxt.text = valorPickerNombreMunicipio
        }else if (pickerView.tag == 6){
            valorPickerNombreEntidad = pickerDatasourceNombreEntidad[row]
            self.entidadTxt.text = valorPickerNombreEntidad
        }else if (pickerView.tag == 7){
            valorPickerTipoInmueble = pickerDatasourceTipoInmueble[row]
            self.tipoInmueble.text = valorPickerTipoInmueble
        }


    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 1){
            return pickerDataSource.count
        }else if (pickerView.tag == 2){
            return pickerDataSourceTipoVialidad.count
        }else if (pickerView.tag == 3){
            return pickerDatasourceNombreColonia.count
        }else if (pickerView.tag == 4){
            return pickerDatasourceNombreLocalidad.count
        }else if (pickerView.tag == 5){
            return pickerDatasourceNombreMunicipio.count
        }else if (pickerView.tag == 6){
            return pickerDatasourceNombreEntidad.count
        }else if (pickerView.tag == 7){
            return pickerDatasourceTipoInmueble.count
   
        }else{
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1){
            return pickerDataSource[row]
        }else if (pickerView.tag == 2){
            return pickerDataSourceTipoVialidad[row]
        }else if (pickerView.tag == 3){
            return pickerDatasourceNombreColonia[row]
        }else if (pickerView.tag == 4){
            return pickerDatasourceNombreLocalidad[row]
        }else if (pickerView.tag == 5){
            return pickerDatasourceNombreMunicipio[row]
        }else if (pickerView.tag == 6){
            return pickerDatasourceNombreEntidad[row]
        }else if (pickerView.tag == 7){
            return pickerDatasourceTipoInmueble[row]

            
            
        }else{
            return pickerDataSource[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = NSTextAlignment.center
        
        if (pickerView.tag == 1){
            titleLabel.text = pickerDataSource[row]
        }else if (pickerView.tag == 2){
            titleLabel.text = pickerDataSourceTipoVialidad[row]
        }else if (pickerView.tag == 3){
            titleLabel.text = pickerDatasourceNombreColonia[row]
        }else if (pickerView.tag == 4){
            titleLabel.text = pickerDatasourceNombreLocalidad[row]
        }else if (pickerView.tag == 5){
            titleLabel.text = pickerDatasourceNombreMunicipio[row]
        }else if (pickerView.tag == 6){
            titleLabel.text = pickerDatasourceNombreEntidad[row]
        }else if (pickerView.tag == 7){
            titleLabel.text = pickerDatasourceTipoInmueble[row]
        }
                    return titleLabel
    }

    
    func keyboardWillShow(notification: NSNotification) {
        
        
        let bottomOffset = CGPoint(x: 0, y: scroll.contentSize.height - scroll.bounds.size.height)
        
        let alturaSuperview =  UIScreen.main.bounds.size.height
        let medidasTeclado = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        
        
        let alturaTeclado = medidasTeclado?.height
        let bordeTeclado = alturaSuperview - alturaTeclado!
        
        posicionView = 0
        var posicionCampo :CGFloat!
        if correo.isEditing{
            posicionView = 160
            scroll.setContentOffset(bottomOffset, animated: true)

            
        } else if telefono.isEditing{
            posicionView = 140
            scroll.setContentOffset(bottomOffset, animated: true)
        }else if coloniaTxt.isEditing{
            scroll.setContentOffset(CGPoint(x: 0, y: 20), animated: true)

        }else if tipoDomicilio.isEditing{
            scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            
        }else if codigoPostalTxt.isEditing{
            scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            
        }else if tipoVialidadTxt.isEditing{
            scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            
        }else if nombreVialidadTxt.isEditing{
            scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            
        }else if noExtTxt.isEditing{
            scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            
        }else if noIntTxt.isEditing{
            scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            
        }else if localidadTxt.isEditing{
            scroll.setContentOffset(CGPoint(x: 0, y: 70), animated: true)
            
        }else if municipioTxt.isEditing{
            scroll.setContentOffset(CGPoint(x: 0, y: 130), animated: true)
            
        }else if entidadTxt.isEditing{
            scroll.setContentOffset(CGPoint(x: 0, y: 180), animated: true)
            
        }else if entreCalle.isEditing{
            scroll.setContentOffset(CGPoint(x: 0, y: 220), animated: true)
            
        }else if yCalleTxt.isEditing{
            scroll.setContentOffset(CGPoint(x: 0, y: 270), animated: true)
            
        }else if tipoInmueble.isEditing{
            scroll.setContentOffset(CGPoint(x: 0, y: 320), animated: true)
            
        }else if caracteristicasDom.isEditing{
            posicionView = 30
             scroll.setContentOffset(bottomOffset, animated: true)
            
        }else if referencias.isEditing{
            posicionView = 70
            scroll.setContentOffset(bottomOffset, animated: true)
            
        }

        self.view.window?.frame.origin.y = -1 * posicionView
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.view.window?.frame.origin.y != 0 {
            self.view.window?.frame.origin.y += posicionView
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }




}
