//
//  QuestionView.swift
//  CapitalQuizz
//
//  Created by Ibrahima KH GUEYE on 29/04/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

import UIKit

class QuestionView: UIView {
    @IBOutlet var labelQuestion: UILabel!
    @IBOutlet var imageQuestion: UIImageView!
    var title = "" {
        didSet {
            labelQuestion.text = title
        }
    }
    var img = UIImage() {
        didSet {
            imageQuestion.image = img
        }
    }
}
