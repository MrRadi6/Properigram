//
//  BaseAPI.swift
//  Properigram
//
//  Created by Samir on 6/24/22.
//

import Alamofire

protocol BaseAPI {
    func makeRequest<T: Decodable>(request: URLRequestConvertible,
                                   completion: @escaping (Result<T, BaseError>) -> Void)
    func makeMetaRequest<T: Decodable, M: Decodable>(request: URLRequestConvertible,
                                                     completion: @escaping (Result<(T,M), BaseError>) -> Void)
}

extension BaseAPI {
    func makeRequest<T: Decodable>(request: URLRequestConvertible,
                                   completion: @escaping (Result<T, BaseError>) -> Void) {

        alamofireRequest(request: request) { (response: DataResponse<APIResponse<T>, AFError>) in
            switch response.result {
            case .success(let value):
                completion(.success(value.data))
            case .failure(let error):
                dLog(error)
                completion(.failure(.unknown))
            }
        }
    }

    func makeMetaRequest<T: Decodable, M: Decodable>(request: URLRequestConvertible,
                                                     completion: @escaping (Result<(T,M), BaseError>) -> Void) {
        alamofireRequest(request: request) { (response: DataResponse<APIResponseWithMeta<T,M>, AFError>) in
            switch response.result {
            case .success(let value):
                completion(.success((value.data,value.meta)))
            case .failure(let error):
                dLog(error)
                completion(.failure(.unknown))
            }
        }
    }
}

extension BaseAPI {
    private func alamofireRequest<T: Decodable>(request: URLRequestConvertible,
                                                interceptor: RequestInterceptor? = nil,
                                                completion: @escaping (DataResponse<T, AFError>) -> Void) {
        AF.request(request, interceptor: interceptor)
            .validate()
            .validate(contentType: [Network.ContentType.json])
            .responseDecodable(of: T.self) { response in
                if let requestURL = response.request?.url?.absoluteString {
                    dLog("Request - \(requestURL)")
                }
                completion(response)
            }
    }
}

