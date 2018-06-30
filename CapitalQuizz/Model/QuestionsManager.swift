//
//  QuestionsManager.swift
//  CapitalQuizz
//
//  Created by Ibrahima KH GUEYE on 29/04/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

import Foundation

class QuestionsManager: InterfaceResquest {
    
    
    private let url = URL(string: "https://restcountries.eu/rest/v2/all")!
    static let shared = QuestionsManager()
    private var httpInterface: HttpInterface
    init(httpInterface: HttpInterface = HttpInterfaceWrapper()) {
        self.httpInterface = httpInterface
    }
    
    func getCountries(callback: @escaping ([Question]) -> Void) {
        httpInterface.makeRequest(request: URLRequest(url: url)) { (data, response, error) in
            guard let jsonData = data else {
                callback([])
                return
            }
            let decoder = JSONDecoder()
            guard let json = try? decoder.decode([Question].self, from: jsonData) else {
                callback([])
                return
            }
            DispatchQueue.main.async {
                 callback(json)
            }
           
        }
    }
}
