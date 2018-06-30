//
//  InterfaceResquest.swift
//  CapitalQuizz
//
//  Created by Ibrahima KH GUEYE on 29/04/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

import Foundation

protocol InterfaceResquest {
    typealias counryCallback = (([Question]) -> Void)
    func getCountries(callback: @escaping counryCallback)
}
