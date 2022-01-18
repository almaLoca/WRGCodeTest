
import Foundation
import UIKit
import Alamofire
import SwiftyJSON


class AFWrapper {
    
    //Webservice for GET Request with parameters
    
    class func requestGETURL(onSuccess success: @escaping success, onFailure failure: @escaping failure) {
        
        AF.request("http://www.mocky.io/v2/5d565297300000680030a986", method: .get, encoding: JSONEncoding.default).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                     let resJSON = JSON(value)
                     success(resJSON)
            case .failure(let error): break
                // error handling
            }
            
        }
    }
    
}
