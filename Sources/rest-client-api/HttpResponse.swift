//
//  HttpResponse.swift
//  rest-client-api
//
//  Created by Yuvraj Singh on 21/06/25.
//

/**
 * @author Yuvraj
 */
public class HttpResponse {
    public let statusCode: Int
    public let payload: String
    
    public init(statusCode: Int, payload: String) {
        self.statusCode = statusCode
        self.payload = payload
    }
} 