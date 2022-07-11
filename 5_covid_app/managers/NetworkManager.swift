//
//  NetworkManager.swift
//  5_covid_app
//
//  Created by David Granado Jordan on 6/10/22.
//

import Foundation

enum CovidNetworkError: Error {
    case noData
}

class NetworkManager {
    
    static let shared = NetworkManager(session: URLSession.shared)
    
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    
    @discardableResult
    func get<T: Decodable>( _ type: T.Type, from url: URL, completion: @escaping (Result<T, Error>)  -> Void  ) -> URLSessionDataTask {

        let request = URLRequest(url: url)
        //request.httpMethod = "POST"
        
        
        /*let taskTwo = session.dataTask(with: request) { (data, response, error) in
        
        }*/
        
        
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion( .failure(error)  )
                }
                return
            }
            
            let jsonDecoder = JSONDecoder()
            if let data  = data, let items = try? jsonDecoder.decode(type, from: data) {
                DispatchQueue.main.async {
                    completion( Result.success(items)  )
                }
            } else {
                DispatchQueue.main.async {
                    completion( .failure( CovidNetworkError.noData )  )
                }
            }
            
        }
        task.resume()
        
        return task
        
    }
    
    
}
