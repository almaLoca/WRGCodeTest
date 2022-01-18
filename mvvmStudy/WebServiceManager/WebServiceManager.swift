

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

public func nullCheck(json: JSON) -> Bool {
    return json != JSON.null  // json != json.null my code ab
}

class WebserviceManager  {
    
    private init () {}
    static let shared = WebserviceManager()
    
    func getWS(handler : @escaping wsHandler){

        AFWrapper.requestGETURL( onSuccess: { (response) in
            if nullCheck(json:response){
                print("succes ")
                handler(true, response)

            }
            else{
                handler(false, "Success")
            }
        }, onFailure: {(error) in
            print(error as Any)
            print("error get")

        })

    }
    


}
