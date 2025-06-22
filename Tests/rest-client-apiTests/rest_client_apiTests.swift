import XCTest
@testable import rest_client_api

import util

final class UtilTest : XCTestCase {
    func testUtil(){
        do {
            let json = DefaultJson()
            let user = User(name: "Yuvraj", email: "abc@xyz.com", phoneNumber: "7250378940")
            let encoded = try json.encode(user)
            print("Encoded JSON:", encoded)
            XCTAssertFalse(encoded.isEmpty, "Encoded string should not be empty")

            let decoded: User = try json.decode(encoded, as: User.self)
            print("Decoded:", decoded)
            XCTAssertEqual(decoded, user, "Decoded user should match the original")
        } catch {
            XCTFail("Test failed with error: \(error)")
        }
    }
}

struct User : Encodable,Decodable, Equatable {
    let name : String
    let email : String
    let phoneNumber: String
}

final class rest_client_apiTests: XCTestCase {
    func testGetRequest() async throws {
        let url = Url(baseUrl: "https://jsonplaceholder.typicode.com", pathParams: "posts", "1")
        let request = Request(url: url)
        let client = UrlSessionRestClientAsync()
        let response = try await client.get(request: request)
        print(response.payload)
        XCTAssertEqual(response.statusCode, 200)
        XCTAssertFalse(response.payload.isEmpty)
    }
    
    func testSendOTP() async throws {
        let baseUrl = "http://56.228.27.35:8080/api/v1" // Replace with your real base URL
        let url = Url(baseUrl: baseUrl, pathParams: "auth", "send", "otp")
        let phoneNumber = PhoneNumber(countryCode: "+91", number: "7250378940")
        let contact = Contact.phone(phoneNumber)

        // Assuming BodyRequest takes a url and a JSON string body
        

        do {
            let bodyRequest = try BodyRequest(url: url, body: contact)
            let client = UrlSessionRestClientAsync()
            let response = try await client.post(request: bodyRequest)
            let statusCode = response.statusCode
            let payload = response.payload
            let exceptionMessage = "Failure, reason: \(payload)"
            let json = DefaultJson()

            if statusCode == 200 {
                let session = try json.decode(payload, as: SessionResponse.self)
                XCTAssertFalse(session.sessionId.isEmpty)
                print(session.sessionId)
            } else if statusCode == 400 {
                throw RestClientError.badRequest(exceptionMessage)
            } else if statusCode == 404 {
                throw RestClientError.notFound(exceptionMessage)
            } else {
                throw RestClientError.internalError(exceptionMessage)
            }
        } catch {
            XCTFail("Request failed: \(error.localizedDescription)")
        }
    }
}

struct Contact : Encodable, Equatable {
    let email: String?
    let phoneNumber: PhoneNumber?
    
    static func phone(_ phoneNumber: PhoneNumber) -> Contact {
        return Contact(email: nil, phoneNumber: phoneNumber)
    }
    
    static func email(_ email: String) -> Contact {
        return Contact(email: email, phoneNumber: nil)
    }
}

struct PhoneNumber: Codable, Equatable {
    let countryCode: String
    let number: String
}

struct SessionResponse: Codable, Equatable {
    let sessionId: String
}

enum RestClientError: Error, LocalizedError {
    case badRequest(String)
    case notFound(String)
    case internalError(String)

    var errorDescription: String? {
        switch self {
        case .badRequest(let msg), .notFound(let msg), .internalError(let msg):
            return msg
        }
    }
}
