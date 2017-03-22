//
//  NetURLSession+AsyncUpload.swift
//  Net
//
//  Created by Alex Rupérez on 17/3/17.
//
//

public extension NetURLSession {

    public func upload(_ streamedRequest: URLRequest) -> URLSessionTask {
        let task = session.uploadTask(withStreamedRequest: streamedRequest)
        observe(task)
        task.resume()
        return task
    }

    public func upload(_ streamedURL: URL, cachePolicy: URLRequest.CachePolicy? = nil, timeoutInterval: TimeInterval? = nil) -> URLSessionTask {
        return upload(urlRequest(streamedURL, cache: cachePolicy, timeout: timeoutInterval))
    }

    public func upload(_ streamedURLString: String, cachePolicy: URLRequest.CachePolicy? = nil, timeoutInterval: TimeInterval? = nil) throws -> URLSessionTask {
        guard let url = URL(string: streamedURLString) else {
            throw URLError(.badURL)
        }
        return upload(url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
    }

    public func upload(_ request: URLRequest, data: Data, completion: ((Data?, NetResponse?, NetError?) -> Swift.Void)? = nil) -> URLSessionTask {
        guard let completion = completion else {
            let task = session.uploadTask(with: request, from: data)
            observe(task)
            task.resume()
            return task
        }
        let task = session.uploadTask(with: request, from: data) { (data, response, error) in
            completion(data, self.netResponse(response), self.netError(error))
        }
        observe(task)
        task.resume()
        return task
    }

    public func upload(_ url: URL, data: Data, cachePolicy: URLRequest.CachePolicy? = nil, timeoutInterval: TimeInterval? = nil, completion: ((Data?, NetResponse?, NetError?) -> Swift.Void)? = nil) -> URLSessionTask {
        return upload(urlRequest(url, cache: cachePolicy, timeout: timeoutInterval), data: data, completion: completion)
    }

    public func upload(_ urlString: String, data: Data, cachePolicy: URLRequest.CachePolicy? = nil, timeoutInterval: TimeInterval? = nil, completion: ((Data?, NetResponse?, NetError?) -> Swift.Void)? = nil) throws -> URLSessionTask {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        return upload(url, data: data, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval, completion: completion)
    }

    public func upload(_ request: URLRequest, fileURL: URL, completion: ((Data?, NetResponse?, NetError?) -> Swift.Void)? = nil) -> URLSessionTask {
        guard let completion = completion else {
            let task = session.uploadTask(with: request, fromFile: fileURL)
            observe(task)
            task.resume()
            return task
        }
        let task = session.uploadTask(with: request, fromFile: fileURL) { (data, response, error) in
            completion(data, self.netResponse(response), self.netError(error))
        }
        observe(task)
        task.resume()
        return task
    }

    public func upload(_ url: URL, fileURL: URL, cachePolicy: URLRequest.CachePolicy? = nil, timeoutInterval: TimeInterval? = nil, completion: ((Data?, NetResponse?, NetError?) -> Swift.Void)? = nil) -> URLSessionTask {
        return upload(urlRequest(url, cache: cachePolicy, timeout: timeoutInterval), fileURL: fileURL, completion: completion)
    }

    public func upload(_ urlString: String, fileURL: URL, cachePolicy: URLRequest.CachePolicy? = nil, timeoutInterval: TimeInterval? = nil, completion: ((Data?, NetResponse?, NetError?) -> Swift.Void)? = nil) throws -> URLSessionTask {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        return upload(url, fileURL: fileURL, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval, completion: completion)
    }

}
