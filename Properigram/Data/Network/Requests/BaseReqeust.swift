//
//  BaseRouter.swift
//  Properigram
//
//  Created by Samir on 6/24/22.
//

import Alamofire

protocol BaseReqeust: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

extension BaseReqeust {
    func asURLRequest() throws -> URLRequest {
        let url = try Network.URL.baseUrl.asURL().appendingPathComponent("api").appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 20
        urlRequest.headers = getHTTPHeaders()
        
        var encoding: ParameterEncoding

        if let parameters = parameters {
            if method == .get {
                encoding = URLEncoding.default
            } else {
                encoding = JSONEncoding.default
            }
            do {
                urlRequest = try encoding.encode(urlRequest, with: parameters)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }

    private func getHTTPHeaders() -> HTTPHeaders {
        var headers: HTTPHeaders = HTTPHeaders()
        headers.add(.contentType(Network.ContentType.json))
        headers.add(.accept(Network.ContentType.json))
        return headers
    }
}
