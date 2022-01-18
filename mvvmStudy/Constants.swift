

import Foundation
import Alamofire
import SwiftyJSON

extension String {
    
    /*
     Webservice URLs and Names
     */
    public static var baseUrlProd            = "http://www.mocky.io/v2/5d565297300000680030a986"
    
}

/*
 API Completion Handler
 */

typealias success = (JSON) -> ()
typealias failure = (Error) -> ()
typealias wsHandler = (_ success: Bool, _ response: Any?) -> ()

let defaults = UserDefaults.standard
