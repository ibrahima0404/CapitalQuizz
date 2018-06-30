//
//  HttpInterface.swift
//  OpenQuizz
//
//  Created by Ibrahima KH GUEYE on 29/04/2018.
//  Copyright © 2018 NxApple. All rights reserved.
//

import Foundation

//MARK: - protocol that UrlRequest wrapper must conform
protocol HttpInterface {
    func makeRequest(request: URLRequest, completionHandler: @escaping(Data?, URLResponse?, Error?)-> Void)
}
