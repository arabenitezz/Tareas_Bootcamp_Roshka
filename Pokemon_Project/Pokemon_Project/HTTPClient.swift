//
//  HTTPClient.swift
//  HTTPDemo
//
//  Created by Jose Alejandro Herrero De Lorenzi on 3/9/20.
//  Copyright © 2020 Jose Alejandro Herrero De Lorenzi. All rights reserved.
//

import Foundation
import Alamofire

/**
 COSAS DEL SERVICIO
 endpoint = Ej: https://www.sudameris.com/servicios/users/get
 method: get, post,delete,put
 encoding: .json, --> https://www.sudameris.com/servicios/users/get
 .url --> https://www.sudameris.com/servicios/users/get?activo=true
 headers = [key, value] Ej: ["Content-Type" : "Application/json"] ----> Dictionary <String, String>
 parameters = [Key, Value] ----> Dictionary<String, Any>
 COSAS QUE HACEMOS DESPUES
 onSucces: --> TODO SALIO BIEN
 onFailure: --> TODO SALIO MAL
 */

typealias APIHeaders = HTTPHeaders
typealias APIParameters = [String: Any]

struct APIError: Error {
    let message: String
}

class APISessionManager {
    static let shared = APISessionManager()
    
    private init() {}
    
    func request(_ url: String,
                 method: HTTPMethod,
                 parameters: Parameters?,
                 encoding: ParameterEncoding,
                 headers: HTTPHeaders?) -> DataRequest {
        return AF.request(url,
                          method: method,
                          parameters: parameters,
                          encoding: encoding,
                          headers: headers)
    }
}

enum APIMethod {
    case get
    case post
    case delete
    case put
    
    fileprivate var value: HTTPMethod {
        switch self {
        case .get:
            return HTTPMethod.get
        case .post:
            return HTTPMethod.post
        case .delete:
            return HTTPMethod.delete
        case .put:
            return HTTPMethod.put
        }
    }
}

enum APIEncoding {
    case json
    case url
    
    fileprivate var value: ParameterEncoding {
        switch self {
        case .json:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
}
class HTTPClient {
    //se hace un metodo estatico o metodo de la clase
    class func request<T: Codable>(endpoint: String,
                                   method: APIMethod = .get,
                                   encoding: APIEncoding = .url,
                                   parameters: APIParameters? = nil,
                                   headers: APIHeaders? = nil,
                                   onSuccess: @escaping (T) -> Void,
                                   onFailure: ((APIError)-> Void)? = nil){
        
        let request = APISessionManager
            .shared
            .request(endpoint,
                     method: method.value,
                     parameters: parameters,
                     encoding: encoding.value,
                     headers: headers)
        
        request.responseDecodable(of: T.self) { (response: DataResponse<T, AFError>) in
            guard response.error == nil else {
                onFailure?(APIError(message: "Hay un error"))
                return
            }
            
            guard let object = response.value else {
                onFailure?(APIError(message: "No vino ningun dato"))
                return
            }
            
            onSuccess(object)
            print(response)
        }
        
    }
}








