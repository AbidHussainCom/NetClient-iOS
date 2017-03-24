//
//  NetURLSession+AsyncStream.swift
//  Net
//
//  Created by Alex Rupérez on 17/3/17.
//
//

@available(iOS 9.0, *)
public extension NetURLSession {

    public func stream(_ netService: NetService) -> URLSessionTask {
        let task = session.streamTask(with: netService)
        observe(task)
        task.resume()
        return task
    }

    public func stream(_ domain: String, type: String, name: String = "", port: Int32? = nil) -> URLSessionTask {
        guard let port = port else {
            return stream(NetService(domain: domain, type: type, name: name))
        }
        return stream(NetService(domain: domain, type: type, name: name, port: port))
    }

    public func stream(_ hostName: String, port: Int) -> URLSessionTask {
        let task = session.streamTask(withHostName: hostName, port: port)
        observe(task)
        task.resume()
        return task
    }

}
