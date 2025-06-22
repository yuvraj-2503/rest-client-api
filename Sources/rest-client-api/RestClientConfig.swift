//
//  RestClientConfig.swift
//  rest-client-api
//
//  Created by Yuvraj Singh on 21/06/25.
//

/**
 * @author Yuvraj
 */
 @MainActor
public class RestClientConfig {
    public static let shared = RestClientConfig()
    private var debug = false
    
    private init() {}
    
    public func isDebug() -> Bool {
        return debug
    }
    
    public func debugMode() {
        self.debug = true
    }
} 