//
//  Url.swift
//  rest-client-api
//
//  Created by Yuvraj Singh on 21/06/25.
//

/**
 * @author Yuvraj
 */
public class Url {
    public private(set) var url: String
    public var queryParams: QueryParams?
    private let separator = "/"
    private let question = "?"

    public init(baseUrl: String, pathParams: String...) {
        self.url = baseUrl
        if !pathParams.isEmpty {
            let relative = pathParams.joined(separator: separator)
            self.url = self.url + separator + relative
        }
    }

    @discardableResult
    public func queryParam(key: String, value: String) -> Url {
        if self.queryParams == nil {
            self.queryParams = QueryParams()
        }
        self.queryParams?.add(key: key, value: value)
        return self
    }

    public func getAsString() -> String {
        if let queryParams = self.queryParams {
            return url + question + queryParams.join()
        } else {
            return self.url
        }
    }
} 