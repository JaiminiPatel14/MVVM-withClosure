//
//  EndPointType.swift
//  MVVM-withClosure
//
//  Created by Jaimini Shah on 17/05/25.
//


import Foundation

//MARK: - ENVIRONAMENTS
enum Environment {
    case development
    case production
    
    var baseURL: String {
        switch self {
        case .development:
            return "https://fakestoreapi.com/"
        case .production:
            return "https://fakestoreapi.com/" // Replace with production URL when available
        }
    }
}
//MARK: - METHODS
enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
}
//MARK: - WHAT REQUEST NEEDS
protocol EndPointType {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var baseURL: String { get }
    var url: URL? { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
}
//MARK: - REQUEST ENDPOINTS
enum EndPointItem {
    case login(username: String, password: String)
    case products
}
extension EndPointItem: EndPointType {
    
    var path: String {
        switch self {
            case .products:
            return "products"
        case .login:
            return "auth/login"
        }
    }
    var httpMethod: HTTPMethod {
        switch self {
        case .products:
            return .get
        case .login:
            return .post
        }
    }
    var baseURL: String {
        return Environment.development.baseURL
    }
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    var parameters: [String : Any]? {
        switch self {
        case .products:
            return nil
        case .login(let username, let password):
            return [
                "username": username,
                "password": password
            ]
        }

    }
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
}
