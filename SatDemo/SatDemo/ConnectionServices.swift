//
//  ConnectionServices.swift
//  SatDemo
//
//  Created by Hiram Elguézabal Jiménez on 10/11/16.
//  Copyright © 2016 Hiram Elguézabal Jiménez. All rights reserved.
//

import Foundation

@objc protocol respuestaExitosaPostDelegate {
    @objc optional func respuestaServicioGET(respuesta: NSDictionary, mensaje: String)
}



class ConnectionServices: NSObject{

    
    
    var delegate : respuestaExitosaPostDelegate?


    func jsonParsingFromFile(conNombre:String) -> NSDictionary {
        let path: NSString = Bundle.main.path(forResource: conNombre, ofType: "json")! as NSString
        let data : NSData = try! NSData(contentsOfFile: path as String, options: NSData.ReadingOptions.dataReadingMapped)
        let dict: NSDictionary!=(try! JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
        return dict
    }
  
    
    
    func consultaServicioGET(_ url : String, httpMethod : String ){
        let urlString = url
        let request = NSMutableURLRequest(url: URL(string: urlString)!)
        request.timeoutInterval = 540
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        var session = URLSession.shared
        request.httpMethod = httpMethod
        
        let urlconfig = URLSessionConfiguration.default
        urlconfig.timeoutIntervalForRequest = 540
        urlconfig.timeoutIntervalForResource = 540
        session = URLSession(configuration: urlconfig, delegate: nil, delegateQueue: nil)
        
        NSLog("-------------- ENTRANDO A consultaServicioGET ------------------")
        
        let task = session.dataTask(with: request as URLRequest , completionHandler: {
            data, response, error  in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("codigo HTTP \(httpResponse.statusCode)")
            }
            
            if error != nil {
                NSLog("-------------- ENTRANDO A error ------------------")
                print("error=\(error)")
                let jsonError : NSDictionary = NSDictionary()
                self.delegate?.respuestaServicioGET!(respuesta: jsonError, mensaje: "\(error!.localizedDescription)")
                return
            }
            //let jsonString = NSString(data: data!,encoding: String.Encoding.ascii.rawValue)
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            NSLog("-------------- RESPUESTA ------------------>  \(responseString!)")
            
            var json: NSDictionary
            
            //            print("responseString = \(jsonString!)")
            //            print("responseString = \(responseString!)")
            if (responseString == "null"){
                print("son nulo")
                let jsonError : NSDictionary = NSDictionary()
                self.delegate?.respuestaServicioGET!(respuesta: jsonError, mensaje: "ERROR")
            }else{
                json = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                self.delegate?.respuestaServicioGET!(respuesta: json, mensaje: "OK")
                //            NSLog("-------------- JSON ------------------>  \(json)")
            }
            
        })
        
        task.resume()
        
    }
    
}
