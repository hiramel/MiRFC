//
//  Menu.swift
//  SatDemo
//
//  Created by Hiram Elguézabal Jiménez on 03/12/16.
//  Copyright © 2016 Hiram Elguézabal Jiménez. All rights reserved.
//

import UIKit

class Menu: UIViewController, UITableViewDelegate, UITableViewDataSource, respuestaExitosaPostDelegate {

    var fruits = ["Configuración", "Preguntas Frecuentes", "Tutoriales", "Videos", "Contacto"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewNombre: UIView!
    let conexion = ConnectionServices()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false;
        emptyCellsEnabled = !emptyCellsEnabled
        self.navigationController?.isNavigationBarHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
        if (Singleton.showNombreMenu != nil){
            viewNombre.isHidden = false
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        buscarMenu()
        
    }
    
    
    func buscarMenu(){
        conexion.delegate = self
        let url = "http://testjorge.mybluemix.net/api/v1/test?_id=MENU"
        conexion.consultaServicioGET(url, httpMethod: "GET")


    
    
    }
    
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "MyTestCell")
            cell.textLabel?.text = "    " + fruits[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
            cell.backgroundColor = UIColor(red: 0/255,green: 46/255, blue:98/255,  alpha: 0.8)
    }
    
    
    
    var emptyCellsEnabled: Bool {
        get {
            return tableView.emptyCellsEnabled
        }
        
        set (newValue) {
            if newValue {
                //footerSwitchButton.setTitle("Hide", for: .normal)
            } else {
                //footerSwitchButton.setTitle("Show", for: .normal)
            }
            
            tableView.emptyCellsEnabled = newValue
        }
    }
    
    
    func respuestaServicioGET(respuesta: NSDictionary, mensaje: String) {
        DispatchQueue.main.async(execute: {
            SVProgressHUD.dismiss()
            
            if mensaje == "OK"{
                var estatus : Int!
                estatus = respuesta["estatus"] as! Int
                if estatus == 0{
                    var datos = respuesta["datos"] as! [String]
                    print("\(datos)")
                    self.fruits = datos
                    //self.fruits.append("hola")
                    self.tableView.reloadData()
                    
                    }else{
                        print("error en el servicio")
                    }
                
            }else{
                //self.showAlert()
                print("error en el servicio")
                //                self.presentaValidacion("Error", subtitulo: mensaje ,imagen: validaciones.inconoErrorValida)
            }
        })
    }

    
    
    
}

extension UITableView {
    
    var emptyCellsEnabled: Bool {
        set(newValue) {
            if newValue {
                tableFooterView = nil
            } else {
                tableFooterView = UIView()
            }
            
        }
        get {
            if tableFooterView == nil {
                return true
            }
            return false
        }
    }
}
