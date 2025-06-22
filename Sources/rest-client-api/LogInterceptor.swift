//
//  LogInterceptor.swift
//  rest-client-api
//
//  Created by Yuvraj Singh on 22/06/25.
//


// LogInterceptor.swift

import Foundation
import os

/**
 * @author Yuvraj
 */
public protocol LogInterceptor {
    func intercept(request: URLRequest)
    func intercept(response: HTTPURLResponse, data: Data?)
}

public class DefaultLogInterceptor: LogInterceptor {
    private let logger = Logger(subsystem: "rest-client-api", category: "network")

    public init() {}

    public func intercept(request: URLRequest) {
        logger.debug("request method: \(request.httpMethod ?? "N/A")")
        logger.debug("request url: \(request.url?.absoluteString ?? "N/A")")
        logger.debug("request headers: \(request.allHTTPHeaderFields ?? [:])")
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            logger.debug("request payload: \(bodyString)")
        }
    }

    public func intercept(response: HTTPURLResponse, data: Data?) {
        logger.debug("response code: \(response.statusCode)")
        logger.debug("response headers: \(response.allHeaderFields)")
        if let data = data, let bodyString = String(data: data, encoding: .utf8) {
            logger.debug("response payload: \(bodyString)")
        }
    }
}
