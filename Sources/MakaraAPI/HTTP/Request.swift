//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


internal class Request {
    
    private static let agent = "Makara API Swift 0.0.1"
    private static let apiEndpoint = "https://makara.com/api"
    private static let apiSession = URLSession(
        configuration: URLSessionConfiguration.ephemeral
    )
    private static let signatureHeaderName = "X-Makara-Signature"
    private static let sessionIdHeaderName = "X-Makara-Session-ID"
    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.nozomiTime)
        return decoder
    }()
    
    public static func make<T: Encodable>(
        path: String,
        payload: T,
        session: Session?,
        query: QueryString?,
        method: HTTPMethod,
        then callback: @escaping (Error?, Data?) -> Void
    ) {
        
        let data: RequestData
        do { try data = RequestData(data: payload) }
        catch { callback(error, nil); return }
        
        Self.make(
            path: path,
            data: data,
            session: session,
            query: query,
            method: method,
            then: callback
        )
        
        return
        
    }
    
    public static func make(
        path: String,
        data: RequestData?,
        session: Session?,
        query: QueryString?,
        method: HTTPMethod,
        then callback: @escaping (Error?, Data?) -> Void
    ) {
        
        if method == .GET && data != nil {
            callback(MakaraAPIError(.inconsistentState), nil)
        }

        let request: URLRequest
        
        do {
            request = try buildRequest(
                path,
                data,
                session,
                query,
                method
            )
        } catch {
            callback(error, nil)
            return
        }

        let _ = Self.apiSession.dataTask(
            with: request,
            completionHandler: {(
                data: Data?,
                response: URLResponse?,
                error: Error?
            ) in
                Self.completeRequest(data, response, error, callback)
        }).resume()

    }
    
    private static func completeRequest(
        _ data: Data?,
        _ response: URLResponse?,
        _ error: Error?,
        _ callback: @escaping (Error?, Data?) -> Void
    ) {
        if error != nil {
            callback(error, nil)
            return
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            callback(MakaraAPIError(.inconsistentState), nil)
            return
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            let error: MakaraAPIError
            switch httpResponse.statusCode {
            case 400: error = MakaraAPIError(.badRequest)
            case 401: error = MakaraAPIError(.notAuthenticated)
            case 402: error = MakaraAPIError(.subscriptionProblem)
            case 403: error = MakaraAPIError(.notAuthorised)
            case 404: error = MakaraAPIError(.notFound)
            case 429: error = MakaraAPIError(.rateLimit)
            case 500: error = MakaraAPIError(.genericServerError)
            case 502, 503, 504: error = MakaraAPIError(.serviceDisruption)
            default: error = MakaraAPIError(
                .inconsistentState
                )
            }
            callback(error, nil)
            return
        }
        callback(nil, data)
        return
    }
    
    private static func buildRequest(
        _ path: String,
        _ data: RequestData?,
        _ session: Session?,
        _ query: QueryString?,
        _ method: HTTPMethod
    ) throws -> URLRequest {

        let fullURL: String
        let endpoint = Self.deriveEndpoint()

        if let query = query {
            guard let parameters = query.paramString.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            ) else {
                throw MakaraAPIError(
                    .inconsistentState,
                    message: "bad url encode"
                )
            }
            fullURL = endpoint + path + parameters
        } else {
            fullURL = endpoint + path
        }
        
        guard let targetURL = URL(string: fullURL) else {
            throw MakaraAPIError(.inconsistentState, message: "nil targetURL")
        }

        var request = URLRequest(url: targetURL)
        request.httpMethod = method.rawValue
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        request.setValue(agent, forHTTPHeaderField: "User-Agent")
        request.httpShouldHandleCookies = false
        if data != nil {
            request.setValue(
              "application/json",
              forHTTPHeaderField: "Content-Type"
            )
            request.httpBody = data!.encodedData
        }

        if let session = session {
            let signature = try session.signature(
                path: path,
                apiKey: session.apiKey.data(using: .utf8)!
            )
            request.setValue(
                signature,
                forHTTPHeaderField: signatureHeaderName
            )
            request.setValue(
                session.publicId,
                forHTTPHeaderField: sessionIdHeaderName
            )
        }

        return request
    }
    
    internal static func decodeResponse<T: Codable>(
        _ error: Error?,
        _ data: Data?,
        _ decodableType: T.Type,
        _ callback: (Error?, T?) -> Void,
        _ coerce404toNil: Bool = true
    ) -> Void {
        
        guard let data = data else {
            if let apiError = error as? MakaraAPIError {
                if apiError.kind == .notFound && coerce404toNil {
                    callback(nil, nil)
                    return
                }
            }
            callback(error ?? MakaraAPIError(.inconsistentState), nil)
            return
        }
        
        let decoded: T
        
        do {
            try decoded = Self.decoder.decode(decodableType, from: data)
        } catch {
            callback(error, nil)
            return
        }

        callback(nil, decoded)
        
        return
        
    }
    
    private static func deriveEndpoint() -> String {
        if let environment = getenv("MAKARA_API_ENDPOINT") {
            guard let endpoint = String(utf8String: environment) else {
                fatalError("Bad environment variable")
            }
            return endpoint
        }
        return Self.apiEndpoint
    }
    
}
