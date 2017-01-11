//
//  ValidacionDatosExt.swift
//  SatDemo
//
//  Created by Hiram Elguézabal Jiménez on 23/11/16.
//  Copyright © 2016 Hiram Elguézabal Jiménez. All rights reserved.
//

import UIKit

class ValidacionDatosExt: UIViewController {

    
    
    
//    @IBOutlet weak var apPaterno: UILabel!
//    @IBOutlet weak var apMaterno: UILabel!
//    @IBOutlet weak var nombre: UILabel!
//    @IBOutlet weak var sexo: UILabel!
//    @IBOutlet weak var fechaNac: UILabel!
//    @IBOutlet weak var nacionalidad: UILabel!
//    @IBOutlet weak var documento: UILabel!

    @IBOutlet weak var apPaterno: UILabel!
    @IBOutlet weak var apMaterno: UILabel!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var sexo: UILabel!
    @IBOutlet weak var fechaNac: UILabel!
    @IBOutlet weak var nacionalidad: UILabel!
    @IBOutlet weak var documento: UILabel!
    @IBOutlet weak var datoArribaTitulo: UILabel!
    @IBOutlet weak var datoAbajoTitulo: UILabel!
    @IBOutlet weak var datoArribaValor: UILabel!
    @IBOutlet weak var datoAbajoValor: UILabel!
    
    
    
    
    @IBAction func confirmarAct(_ sender: UIButton) {
        
        let valida = DomicilioActual(nibName: "DomicilioActual", bundle: nil)
        navigationController?.pushViewController(valida, animated: true)

        
    }
    
    
    @IBAction func atras(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nombre.text = Singleton.nombre
        apPaterno.text = Singleton.apPaterno
        apMaterno.text = Singleton.apMaterno
        sexo.text = Singleton.genero
        fechaNac.text = Singleton.fecNac
        nacionalidad.text = Singleton.nacionalidad
        documento.text = Singleton.documentoProb
        
        if (Singleton.naturalizado == "Y"){
            datoArribaTitulo.text = "Año de registro de carta"
            datoArribaValor.text = Singleton.anioRegistro
            datoAbajoTitulo.text = "Folio de la carta"
            datoAbajoValor.text = Singleton.folioCarta
        
        }else{
            datoArribaTitulo.text = "Número del registro nacional de extranjeros"
            datoArribaValor.text = Singleton.numeroRegistro
            datoAbajoTitulo.text = "Número del expediente del documento Migratorio"
            datoAbajoValor.text = Singleton.numeroExpediente
        
        }
        
        

        

    }
    
    
    


}
