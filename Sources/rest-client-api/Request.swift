//
//  Request.swift
//  rest-client-api
//
//  Created by Yuvraj Singh on 21/06/25.
//

/**
 * @author Yuvraj
 */
public class Request {
    public let url: Url
    public let headers: Headers?
    
    public init(url: Url) {
        self.url = url
        self.headers = nil
    }
    
    public init(url: Url, headers: Headers?) {
        self.url = url
        self.headers = headers
    }
} 
