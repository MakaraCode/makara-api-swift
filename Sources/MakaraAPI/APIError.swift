//
//  File.swift
//
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


public struct MakaraAPIError: MakaraError {

    public let kind: Kind
    public let message: String
    public let id: String
    
    internal init(_ kind: Kind, message: String? = nil) {
        self.kind = kind
        self.message = message ?? kind.rawValue
        self.id = RandomNumber(.large).string
        return
    }

    public enum Kind: String {
        case jsonParseFailed = """
        Makara API Swift was unable to parse the JSON sent by the Makara API. \
        This likely indicates a bug, please considering opening an issue on \
        GitHub.
        """
        case badResponse = """
        Makara API Swift library was not able to understand the response sent \
        by the Makara API. If this happens repeatedly, there may be a bug in \
        the API.
        """
        case inconsistentState = """
        Makara API Swift has entered an unexpected state from which it cannot \
        recover. Please consider filing a bug report on GitHub.
        """
        case notFound = "A requested resource could not be found"
        case notAuthorised = """
        You are not authorised to access a requested resource.
        """
        case notAuthenticated = """
        Your request was not authenticated. Your Session may have expired or \
        been deleted. Consider creating a new Session.
        """
        case badRequest = """
        The Makara API could not understand your request, it may be missing a \
        required parameter, or be composed of incorrect types. It is the \
        responsibility of this library (Makara API Swift) to supply correctly \
        formed requests, so please consider filing a bug report on GitHub.
        """
        case genericServerError = """
        The Makara API replied with a generic error response, indicating that \
        it has failed internally. Either Makara is experiencing temporary \
        disruption, or there is a bug in the API.
        """
        case constraintViolated = """
        Input data violates a constraint. For example, a description may be \
        too long.
        """
        case subscriptionProblem = """
        Your Makara subscription does not allow you to perfom this action. \
        Your payment method may have expired, or your plan may be disabled. \
        Please visit https://Makara.io/billing or contact support@Makara.io
        """
        case serviceDisruption = """
        Makara is experiencing a service disruption. This should be \
        temporary. Check the @Makaraapi Twitter feed and \
        https://Makara.io/blog/ for service updates.
        """
        case rateLimit = """
        You have hit the Makara API rate limiter. You might try batching your \
        requests (e.g. creating 10 Transactions at once). If your \
        implementation requires a higher rate limit, or your believe you are \
        being erroneously limited (e.g. behind a corporate or university NAT), \
        please contact support@makara.io
        """
        case notImplemented = """
        The requested functionality is not yet implemented by Makara API Swift
        """
        case badConfiguration = """
        Makara API is not configured in such a way as to allow it to
        peform your request. You may be missing an environment variable.
        """
        case testError = """
        A test case has entered an unexpected state
        """
    }
    
}
