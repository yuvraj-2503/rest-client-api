//
//  URLSessionRestClientAsync.swift
//  rest-client-api
//
//  Created by Yuvraj Singh on 22/06/25.
//
// URLSessionRestClientAsync.swift

import Foundation

/**
 * @author Yuvraj
 */
public class UrlSessionRestClientAsync: RestClientAsync {
    private let session: URLSession
    private let interceptor: LogInterceptor?

    public init(session: URLSession = .shared, interceptor: LogInterceptor? = nil) {
        self.session = session
        self.interceptor = interceptor
    }

    public func get(request: Request) async throws -> HttpResponse {
        var urlRequest = URLRequest(url: URL(string: request.url.getAsString())!)
        urlRequest.httpMethod = "GET"
        loadHeaders(request: request, urlRequest: &urlRequest)
        return try await send(urlRequest: urlRequest)
    }

    public func delete(request: Request) async throws -> HttpResponse {
        var urlRequest = URLRequest(url: URL(string: request.url.getAsString())!)
        urlRequest.httpMethod = "DELETE"
        loadHeaders(request: request, urlRequest: &urlRequest)
        return try await send(urlRequest: urlRequest)
    }

    public func post(request: BodyRequest) async throws -> HttpResponse {
        return try await sendWithBody(request: request, method: "POST")
    }

    public func put(request: BodyRequest) async throws -> HttpResponse {
        return try await sendWithBody(request: request, method: "PUT")
    }

    public func patch(request: BodyRequest) async throws -> HttpResponse {
        return try await sendWithBody(request: request, method: "PATCH")
    }

    private func sendWithBody(request: BodyRequest, method: String) async throws -> HttpResponse {
        var urlRequest = URLRequest(url: URL(string: request.url.getAsString())!)
        urlRequest.httpMethod = method
        loadHeaders(request: request, urlRequest: &urlRequest)
        if let body = request.body {
            urlRequest.httpBody = body.data(using: .utf8)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return try await send(urlRequest: urlRequest)
    }

    private func loadHeaders(request: Request, urlRequest: inout URLRequest) {
        if let headers = request.headers {
            for header in headers {
                urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
    }

    private func send(urlRequest: URLRequest) async throws -> HttpResponse {
        interceptor?.intercept(request: urlRequest)
        let (data, response) = try await session.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        interceptor?.intercept(response: httpResponse, data: data)
        let payload = String(data: data, encoding: .utf8) ?? ""
        return HttpResponse(statusCode: httpResponse.statusCode, payload: payload)
    }
}
