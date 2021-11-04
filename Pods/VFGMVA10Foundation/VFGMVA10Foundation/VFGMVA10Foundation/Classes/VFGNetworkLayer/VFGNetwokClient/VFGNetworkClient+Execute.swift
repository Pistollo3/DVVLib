//
//  VFGNetworkClient+Execute.swift
//  VFGMVA10Foundation
//
//  Created by Ahmed Sultan on 10/17/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//


public typealias ResponseArg = (data: Data?, urlResponse: URLResponse?, error: Error?)
public typealias ResponseCompletionHandler = (ResponseArg) -> Void

/**
    this extension give a default implementation for execute network
    call it accept type VFRequestType else you can build your own implementation with different request type
*/
extension VFGNetworkClient {
    @available(*, deprecated, message: "please use executeData instead")
    open func execute<T: Codable>(
        request: VFGRequestProtocol,
        model: T.Type,
        progressClosure: VFGNetworkProgressClosure? = nil,
        completion: @escaping VFGNetworkCompletion
    ) {
        executeData(request: request, model: model, progressClosure: progressClosure) { result in
            switch result {
            case .success(let model):
                completion(model, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    open func executeData<T: Codable>(
        request: VFGRequestProtocol,
        model: T.Type,
        progressClosure: VFGNetworkProgressClosure? = nil,
        completion: @escaping (Result<T, Error>, [AnyHashable: Any]?) -> Void
    ) {
        executeData(request: request, model: model) { [weak self] result in
            completion(result, self?.headerFields)
        }
    }

    open func executeData<T: Codable>(
        request: VFGRequestProtocol,
        model: T.Type,
        progressClosure: VFGNetworkProgressClosure? = nil,
        completion: @escaping VFGNetworkCompletionDelegate<T>
    ) {
        // the response handler that will be executed once network response received
        let responseCompletionHandler: URLSessionProtocol.DataTaskResult = { [weak self] data, response, error in
            guard let self = self else {
                DispatchQueue.main.async {
                    completion(.failure(VFGNetworkError.network))
                }
                return
            }
            let arg: ResponseArg = (data, response, error)
            if model == Data.self, let data = data as? T {
                self.headerFields = (response as? HTTPURLResponse)?.allHeaderFields
                completion(.success(data))
            } else {
                self.mapResponse(responseArg: arg, model: model, completion: completion)
            }
            observation[request.hash]?.invalidate()
            observation.removeValue(forKey: request.hash)
            self.cleanUp(request: request, completion: nil)
        }
        // to check if local file data task or network request data task
        do {
            let currentTask: URLSessionDataTaskProtocol
            let isRequestPathFile = URL(string: request.path)?.isFileURL ?? false
            let fileURL = isRequestPathFile ? URL(string: request.path): URL(string: baseUrl)
            if let baseURL = fileURL, baseURL.isFileURL {
                currentTask = session.dataTask(with: baseURL, completionHandler: responseCompletionHandler)
            } else {
                let fullRequestHeaders = buildHeaders(request: request, completion: completion)
                let urlRequest = try buildRequest(from: request, with: fullRequestHeaders, to: URL(string: baseUrl))
                VFGNetworkLogger.log(request: urlRequest)
                currentTask = session.dataTask(with: urlRequest, completionHandler: responseCompletionHandler)
                NetworkDefaults.workerQueue.sync {
                    let task = currentTask.progress.observe(\.fractionCompleted) { progress, _ in
                        guard let progressDelegate = progressClosure else { return }
                        progressDelegate?(progress.fractionCompleted)
                    }
                    observation[request.hash] = task
                }
            }

            currentTask.resume()
            networkProgressDelegate?.addTask(dataTask: currentTask, progressClosure: progressClosure)
            NetworkDefaults.workerQueue.sync {
                self.runningTasks.append(CurrentTask(request: request, task: currentTask))
            }
        } catch {
            DispatchQueue.main.async {
                self.headerFields = nil
                completion(.failure(VFGNetworkError.unknown))
            }
        }
    }

    fileprivate func cleanUp(request: VFGRequestProtocol, completion: (() -> Void)?) {
        NetworkDefaults.workerQueue.async(qos: .default, flags: .barrier) { [weak self] in
            guard let self = self else { return }
            let cancelledTaskIndex = self.runningTasks.firstIndex { $0.request?.hash == request.hash }
            guard let taskIndex = cancelledTaskIndex else { return }
            self.runningTasks.remove(at: taskIndex).task?.cancel()
            DispatchQueue.main.async {
                completion?()
            }
        }
    }

    open func cancel(request: VFGRequestProtocol, completion: (() -> Void)?) {
        cleanUp(request: request, completion: completion)
    }
}
