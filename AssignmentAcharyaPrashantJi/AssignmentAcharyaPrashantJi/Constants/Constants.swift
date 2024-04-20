//
//  Constants.swift
//  AssignmentAcharyaPrashantJi
//
//  Created by Rajeshwari Sharma on 19/04/24.
//

// Constants.swift

import Foundation
import UIKit

// This struct defines constants used in the application
struct Constant {
    static let baseUrl = "https://acharyaprashant.org/api/v2/content/"
}

// Enum to represent network errors
enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidData
}

// Enum representing different API endpoints
enum EndPoint {
    case misc
    
    var path: String {
        // Define the path for the misc endpoint
        switch self {
        case .misc:
            return "misc/media-coverages?limit=100"
        }
    }
}

// Computed property to get the base URL


// Enum defining request headers
enum RequestHeaders {
    static let contentType = "Content-Type"
    static let applicationJSON = "application/json"
    static let formData = "application/x-www-form-urlencoded"
}
