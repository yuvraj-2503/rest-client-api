//
//  RestClientAsync.swift
//  rest-client-api
//
//  Created by Yuvraj Singh on 22/06/25.
//

// RestClientAsync.swift

import Foundation

/**
 * @author Yuvraj
 */
public protocol RestClientAsync {
    func get(request: Request) async throws -> HttpResponse
    func delete(request: Request) async throws -> HttpResponse
    func post(request: BodyRequest) async throws -> HttpResponse
    func put(request: BodyRequest) async throws -> HttpResponse
    func patch(request: BodyRequest) async throws -> HttpResponse
}
