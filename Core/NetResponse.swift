//
//  NetResponse.swift
//  Net
//
//  Created by Alex Rupérez on 22/3/17.
//
//

import Foundation

public struct NetResponse {

    public let url: URL?

    public let mimeType: String?

    public let contentLength: Int64?

    public let textEncoding: String?

    public let filename: String?

    public let statusCode: Int?

    public let headers: [AnyHashable : Any]?

    public let localizedDescription: String?

    let responseObject: Any?

}

extension NetResponse {

    public init(_ url: URL? = nil, mimeType: String? = nil, contentLength: Int64 = -1, textEncoding: String? = nil, filename: String? = nil, statusCode: Int? = nil, headers: [AnyHashable : Any]? = nil, localizedDescription: String? = nil, responseObject: Any? = nil) {
        self.url = url
        self.mimeType = mimeType
        self.contentLength = contentLength != -1 ? contentLength : nil
        self.textEncoding = textEncoding
        self.filename = filename
        self.statusCode = statusCode
        self.headers = headers
        self.localizedDescription = localizedDescription
        self.responseObject = responseObject
    }

}

extension NetResponse {

    public func object<T>() throws -> T {
        do {
            return try NetTransformer.object(object: responseObject)
        } catch {
            switch error as! NetError {
            case .error(let transformCode, let message, _, let object, let transformUnderlying):
                throw NetError.error(code: transformCode ?? statusCode, message: message, headers: headers, object: object ?? responseObject, underlying: transformUnderlying)
            }
        }
    }

}

extension NetResponse: Equatable {

    public static func ==(lhs: NetResponse, rhs: NetResponse) -> Bool {
        guard lhs.url != nil && rhs.url != nil else {
            return false
        }
        return lhs.url == rhs.url
    }

}

extension NetResponse: CustomStringConvertible {

    public var description: String {
        var description = ""
        if let statusCode = statusCode?.description {
            description = description + statusCode
        }
        if let url = url?.description {
            if description.characters.count > 0 {
                description = description + " "
            }
            description = description + url
        }
        if let localizedDescription = localizedDescription?.description {
            if description.characters.count > 0 {
                description = description + " "
            }
            description = description + "(\(localizedDescription))"
        }
        return description
    }

}

extension NetResponse: CustomDebugStringConvertible {

    public var debugDescription: String {
        return description
    }
    
}
