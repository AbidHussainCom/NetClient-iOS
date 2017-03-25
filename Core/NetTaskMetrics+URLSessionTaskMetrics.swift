//
//  NetTaskMetrics+URLSessionTaskMetrics.swift
//  Net
//
//  Created by Alex Rupérez on 25/3/17.
//
//

import Foundation

@available(iOS 10.0, *)
public extension NetTaskMetrics {

    init(_ urlSessionTaskMetrics: URLSessionTaskMetrics, request: NetRequest?, response: NetResponse?) {
        let transactionMetrics = urlSessionTaskMetrics.transactionMetrics.map { transactionMetrics -> NetTransactionMetrics in
            NetTransactionMetrics(request: request, response: response, fetchStartDate: transactionMetrics.fetchStartDate, domainLookupStartDate: transactionMetrics.domainLookupStartDate, domainLookupEndDate: transactionMetrics.domainLookupEndDate, connectStartDate: transactionMetrics.connectStartDate, secureConnectionStartDate: transactionMetrics.secureConnectionStartDate, secureConnectionEndDate: transactionMetrics.secureConnectionEndDate, connectEndDate: transactionMetrics.connectEndDate, requestStartDate: transactionMetrics.requestStartDate, requestEndDate: transactionMetrics.requestEndDate, responseStartDate: transactionMetrics.responseStartDate, responseEndDate: transactionMetrics.responseEndDate, networkProtocolName: transactionMetrics.networkProtocolName, isProxyConnection: transactionMetrics.isProxyConnection, isReusedConnection: transactionMetrics.isReusedConnection, resourceFetchType: NetTransactionMetrics.NetResourceFetchType(rawValue: transactionMetrics.resourceFetchType.rawValue) ?? .unknown)
        }
        self.init(transactionMetrics: transactionMetrics, taskInterval: urlSessionTaskMetrics.taskInterval.duration, redirectCount: urlSessionTaskMetrics.redirectCount)
    }
    
}
