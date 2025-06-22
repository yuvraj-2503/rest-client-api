//
//  Headers.swift
//  rest-client-api
//
//  Created by Yuvraj Singh on 21/06/25.
//

/**
 * @author Yuvraj
 */
public class Headers: Sequence {
    public var headers: [Header]
    
    public init() {
        self.headers = []
    }
    
    public init(headers: [Header]) {
        self.headers = headers
    }
    
    @discardableResult
    public func add(key: String, value: String) -> Headers {
        headers.append(Header(key: key, value: value))
        return self
    }
    
    public func makeIterator() -> IndexingIterator<[Header]> {
        return headers.makeIterator()
    }
    
    public func forEach(_ body: (Header) throws -> Void) rethrows {
        try headers.forEach(body)
    }
} 