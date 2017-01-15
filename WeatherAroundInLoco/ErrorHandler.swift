//
//  ErrorHandler.swift
//  WeatherAroundInLoco
//
//  Created by Breno Ramos on 13/01/17.
//  Copyright © 2017 brenor2. All rights reserved.
//

import Foundation
import UIKit

enum ErrorType:String{
    case noInternetError = "Ops! Cheque sua conexão e tente novamente."
    case couldNotDownloadDataError = "Houve algum problema em nossos servidores. Tente novamente."
    case genericError = "Vish! Deu um erro feioso. Tente de novo."
    case noCitiesFoundError = "Nenhuma cidade próxima encontrada."
}

public class ErrorHandler{
    
    class func errorAlert(message:String, viewController: UIViewController)->Void{
        let alert = UIAlertController(title: "Algo aconteceu...", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }

}
