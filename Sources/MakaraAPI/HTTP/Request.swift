//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


class Request {
    
    private static let agent = "Makara API Swift 0.0.1"
    private static let apiEndpoint = "https://makara.com/api"
    private static let apiSession = URLSession(
        configuration: URLSessionConfiguration.ephemeral
    )
    private static let signatureHeaderName = "X-Makara-Signature"
    private static let sessionIdHeaderName = "X-Makara-Session-ID"
    
    public static func make(
        path: String,
        data: RequestData?,
        session: Session?,
        query: QueryString?,
        method: HTTPMethod,
        then callback: @escaping (Error?, Data?) -> Void
    ) {
        
        let shouldEncodeDataInURL: Bool
        if method == .GET && data != nil {
            shouldEncodeDataInURL = true
        } else {
            shouldEncodeDataInURL = false
        }
        
        let request: URLRequest
        
        do {
            request = try buildRequest(
                path,
                data,
                session,
                query,
                method,
                shouldEncodeDataInURL
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
        _ method: HTTPMethod,
        _ shouldEncodeDataInUrl: Bool
    ) throws -> URLRequest {

        let fullURL: String

        if let query = query {
            fullURL = Self.apiEndpoint + path + query.paramString
        } else {
            fullURL = Self.apiEndpoint + path
        }

        let targetURL: URL?

        if shouldEncodeDataInUrl == true, let data = data {
            if query != nil {
                targetURL = URL(string: (
                    fullURL + "&" + data.asQueryStringArgument()
                ))
            } else {
                targetURL = URL(string: (
                    fullURL + "?" + data.asQueryStringArgument()
                ))
            }
        } else {
            targetURL = URL(string: fullURL)
        }

        guard targetURL != nil else {
          throw MakaraAPIError(.inconsistentState)
        }

        var request = URLRequest(url: targetURL!)
        request.httpMethod = method.rawValue
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        request.setValue(agent, forHTTPHeaderField: "User-Agent")
        if data != nil && shouldEncodeDataInUrl == false {
            request.setValue(
              "application/json",
              forHTTPHeaderField: "Content-Type"
            )
            request.httpBody = data!.encodedData
        }

        if let session = session {
            let signature = try session.signature(
                path: path,
                data: data,
                apiKey: session.apiKey.data(using: .utf8)!
            )
            request.setValue(signature, forHTTPHeaderField: signatureHeaderName)
            request.setValue(
                session.publicId,
                forHTTPHeaderField: sessionIdHeaderName
            )
        }

        return request
    }
}
