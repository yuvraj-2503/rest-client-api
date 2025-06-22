//
//  QueryParam.swift
//  rest-client-api
//
//  Created by Yuvraj Singh on 21/06/25.
//;

/**
 * @author Yuvraj
 */
public class QueryParam {
    public let key: String
    public let value: String
    private let equals = "="

    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }

    public func join() -> String {
        return "\(key)\(equals)\(value)"
    }
}
