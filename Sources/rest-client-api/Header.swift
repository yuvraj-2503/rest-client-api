//
//  Header.swift
//  rest-client-api
//
//  Created by Yuvraj Singh on 21/06/25.
//

/**
 * @author Yuvraj
 */
public struct Header {
    public var key: String
    public var value: String
    
    public init(key: String = "", value: String = "") {
        self.key = key
        self.value = value
    }
} 