//
//  ViewModel.swift
//  AssignmentAcharyaPrashantJi
//
//  Created by Rajeshwari Sharma on 19/04/24.
//

import Foundation


class ViewModel {
    
    // Property to store the data model retrieved from the API
    var datamodel: [DataModel]?
    
    // Method to fetch data from the API
    func fetchDataFromApi(completion: @escaping (Result<[DataModel], Error>) -> Void) {
        
        // Check if the URL can be created from the base URL and endpoint
        guard let url = URL(string: Constant.baseUrl + EndPoint.misc.path) else {
            return // Exit the function if the URL cannot be created
        }
        
        print("url == \(url)")
        
        // Create a GET request with the specified URL
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Create a URLSession
        let session = URLSession.shared
        
        // Perform a data task with the request
        let task = session.dataTask(with: request) { data, response, error in
            
            // Handle any error that occurred during the network request
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check if there is valid response data
            if let responseData = data {
                
                do {
                    // Decode the JSON data into the NextDataModel
                    self.datamodel = try JSONDecoder().decode([DataModel].self, from: responseData)
                    print("datamodel = \(String(describing: self.datamodel))")
                    
                    // Call the completion handler with the success result and the decoded data model
                    completion(.success(self.datamodel!))
                } catch let decodingError {
                    // Call the completion handler with the failure result and the decoding error
                    completion(.failure(decodingError))
                }
                
            }
            
        }
        
        // Start the data task
        task.resume()
    }
    
}
