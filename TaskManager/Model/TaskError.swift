//
//  TaskError.swift
//  TaskManager
//
//  Created by Khanh Pham on 15/9/2024.
//

import Foundation

enum TaskError: Error {
    case missingTitle
    case missingDescription
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .missingTitle:
            return "The task must have a title."
        case .missingDescription:
            return "The task must have a description."
        default:
            return nil
        }
    }
}

