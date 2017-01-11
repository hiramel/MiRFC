//
//  ValidacionDatosVC.swift
//  SatDemo
//
//  Created by Hiram Elguézabal Jiménez on 10/11/16.
//  Copyright © 2016 Hiram Elguézabal Jiménez. All rights reserved.
//

import UIKit

class ValidacionDatosVC: UIViewController {
    
    @IBOutlet weak var apPaterno: UILabel!
    @IBOutlet weak var apMaterno: UILabel!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var sexo: UILabel!
    @IBOutlet weak var fechaNac: UILabel!
    @IBOutlet weak var nacionalidad: UILabel!
    @IBOutlet weak var documento: UILabel!
    @IBOutlet weak var entidad: UILabel!
    @IBOutlet weak var municipio: UILabel!
    @IBOutlet weak var anio: UILabel!
    @IBOutlet weak var libro: UILabel!
    @IBOutlet weak var tomo: UILabel!
    @IBOutlet weak var foja: UILabel!
    @IBOutlet weak var acta: UILabel!
    @IBOutlet weak var confirmarBtn: UIButton!
    
    
    
    @IBAction func confirmarAct(_ sender: AnyObject) {
        
        let valida = DomicilioActual(nibName: "DomicilioActual", bundle: nil)
        navigationController?.pushViewController(valida, animated: true)

        
    }
    
    
    @IBAction func atras(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)

    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        confirmarBtn.layer.cornerRadius = 10
        
        nombre.text = Singleton.nombre
        apPaterno.text = Singleton.apPaterno
        apMaterno.text = Singleton.apMaterno
        sexo.text = Singleton.genero
        fechaNac.text = Singleton.fecNac
        nacionalidad.text = Singleton.nacionalidad
        documento.text = Singleton.documentoProb
        entidad.text = Singleton.entidadNac
        municipio.text = Singleton.municipio
        anio.text = Singleton.anio
        libro.text = Singleton.libro
        tomo.text = Singleton.tomo
        foja.text = Singleton.foja
        acta.text = Singleton.acta
        
        
        

        
        
        

    }


}
