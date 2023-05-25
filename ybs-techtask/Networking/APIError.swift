//
//  APIError.swift
//  ybs-techtask
//
//  Created by Nov Petrović on 24/05/2023.
//

import Foundation

enum APIError: Error, Equatable {
    
    case invalidURL
    case responseProblem
    case decodingProblem
    case other(String)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Well this is embarrasing... The url you're trying to send data to is invalid. Please report this to our team."
        case .responseProblem:
            return "Invalid response from the server. Please try again."
        case .decodingProblem:
            return "The data received from the server was invalid. Please try again."
        case .other(let message):
            return message
        }
    }
}
