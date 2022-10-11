//
//  NetworkError.swift
//  EffectiveMobile
//
//  Created by  User on 04.09.2022.
//

import Foundation

enum NetworkError: String, Error {
    case missingURL
    case missingRequest
    case taskError
    case responseError
    case dataError
    case decodeError
}
