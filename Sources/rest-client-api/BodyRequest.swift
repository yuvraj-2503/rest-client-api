//
//  BodyRequest.swift
//  rest-client-api
//
//  Created by Yuvraj Singh on 22/06/25.
//

import Foundation
import util

/**
 * @author Yuvraj
 */
public class BodyRequest: Request {
    public let body: String?

    override
    public init(url: Url) {
        self.body = nil
        super.init(url: url)
    }

    public init(url: Url, headers: Headers) {
        self.body = nil
        super.init(url: url, headers: headers)
    }

    public init(url: Url, body: String) {
        self.body = body
        super.init(url: url)
    }

    public init(url: Url, headers: Headers, body: String) {
        self.body = body
        super.init(url: url, headers: headers)
    }

    public convenience init<T: Encodable>(url: Url, body: T) throws {
        let json = DefaultJson()
        let encoded = try json.encode(body)
        self.init(url: url, body: encoded)
    }

    public convenience init<T: Encodable>(url: Url, headers: Headers, body: T) throws {
        let json = DefaultJson()
        let encoded = try json.encode(body)
        self.init(url: url, headers: headers, body: encoded)
    }
}
