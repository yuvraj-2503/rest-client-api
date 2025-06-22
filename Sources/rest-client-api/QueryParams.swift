//
//  QueryParams.swift
//  rest-client-api
//
//  Created by Yuvraj Singh on 21/06/25.
//

/**
 * @author Yuvraj
 */
public class QueryParams: Sequence {
    private var params: [QueryParam] = []
    private let ampersand = "&"

    public init() {}

    @discardableResult
    public func add(key: String, value: String) -> QueryParams {
        self.params.append(QueryParam(key: key, value: value))
        return self
    }

    public func join() -> String {
        let joinedParams = params.map { $0.join() }
        return joinedParams.joined(separator: ampersand)
    }

    public func makeIterator() -> IndexingIterator<[QueryParam]> {
        return params.makeIterator()
    }

    public func forEach(_ body: (QueryParam) throws -> Void) rethrows {
        try params.forEach(body)
    }
} 