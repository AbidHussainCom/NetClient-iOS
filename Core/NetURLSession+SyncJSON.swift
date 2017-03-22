//
//  NetURLSession+SyncJSON.swift
//  Net
//
//  Created by Alex Rupérez on 17/3/17.
//
//

public extension NetURLSession {

    public func json(_ request: URLRequest, options: JSONSerialization.ReadingOptions = .allowFragments) throws -> Any? {
        guard let data = try data(request), data.count > 0 else {
            return nil
        }
        return try json(data, options: options)
    }

    public func json(_ url: URL, cachePolicy: URLRequest.CachePolicy? = nil, timeoutInterval: TimeInterval? = nil, options: JSONSerialization.ReadingOptions = .allowFragments) throws -> Any? {
        return try json(urlRequest(url, cache: cachePolicy, timeout: timeoutInterval), options: options)
    }

    public func json(_ urlString: String, cachePolicy: URLRequest.CachePolicy? = nil, timeoutInterval: TimeInterval? = nil, options: JSONSerialization.ReadingOptions = .allowFragments) throws -> Any? {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        return try json(url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval, options: options)
    }

}
