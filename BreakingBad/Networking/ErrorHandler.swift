//
//  ErrorHandler.swift
//  BreakingBad
//
//  Created by Mahmoud Abdelshafi on 24/06/2021.
//

import Foundation

enum ErrorHandler : Error {
    
    case general
    case checkStatus(code : Int)
    
    var errorMessage : String {
        switch self {
        case .general:
            return "Somthing went wrong, try again"
        case .checkStatus(let code):
            if code == 404 {
                return "404 error message"
            }
            if (200..<300).contains(code) {
                return "Success"
            }
        }
        return "Network Error"
    }
}
