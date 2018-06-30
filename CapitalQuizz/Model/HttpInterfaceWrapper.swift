//
//  HttpInterfaceWrapper.swift
//  OpenQuizz
//
//  Created by Ibrahima KH GUEYE on 29/04/2018.
//  Copyright © 2018 NxApple. All rights reserved.
//

import Foundation

//MARK: - this class is just a wrapper of UrlRequest
class HttpInterfaceWrapper: HttpInterface {
    func makeRequest(request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: completionHandler)
        task.resume()
    }
}
