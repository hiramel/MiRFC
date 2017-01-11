//
//  LocalizaDomicilio.swift
//  SatDemo
//
//  Created by Hiram Elguézabal Jiménez on 11/11/16.
//  Copyright © 2016 Hiram Elguézabal Jiménez. All rights reserved.
//

import UIKit
import MapKit


protocol respuestaMapa {
    func respuestaExitosaMapa()
}


class LocalizaDomicilio: UIViewController {
    
    
    
    
    var delegateMapa: respuestaMapa?
    @IBOutlet weak var mapa: MKMapView!
    
    
    @IBAction func aceptar(_ sender: AnyObject) {
        self.delegateMapa?.respuestaExitosaMapa()
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func atras(_ sender: AnyObject) {
       dismiss(animated: true, completion: nil)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let centerlocation = CLLocationCoordinate2DMake(19.372501, -99.261131)
        let mapSpan = MKCoordinateSpanMake(0.01, 0.01)
        let mapRegion = MKCoordinateRegionMake(centerlocation, mapSpan)
        self.mapa.setRegion(mapRegion, animated: true)

    }


}
