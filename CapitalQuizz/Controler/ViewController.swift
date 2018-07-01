//
//  ViewController.swift
//  CapitalQuizz
//
//  Created by Ibrahima KH GUEYE on 29/04/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

import UIKit
import SVGKit
class ViewController: UIViewController {
    @IBOutlet weak var buttonAnswer1: UIButton!
    @IBOutlet weak var buttonAnswer2: UIButton!
    @IBOutlet weak var buttonAnswer3: UIButton!
    @IBOutlet weak var questionView: QuestionView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = Notification.Name("QuestionLoaded")
        NotificationCenter.default.addObserver(self, selector:#selector(questionsLoaded), name: name, object: nil)
        
        startGame()
    }
    
    @IBAction func didTouchButton1(_ sender: Any) {
        if game.state == .going {
            let answer = game.answserToQuestion(with: buttonAnswer1.title(for: .normal)!)
            animationQuestion(answer: answer, button: buttonAnswer1)
        }else {
            presentAlertGameOver()
        }
    }
    
    @IBAction func didTouchButton2(_ sender: Any) {
        if game.state == .going {
            let answer = game.answserToQuestion(with: buttonAnswer2.title(for: .normal)!)
            animationQuestion(answer: answer, button: buttonAnswer2)
        }else {
            presentAlertGameOver()
        }
    }
    
    @IBAction func didTouchButton3(_ sender: Any) {
        if game.state == .going {
            let answer = game.answserToQuestion(with: buttonAnswer3.title(for: .normal)!)
            animationQuestion(answer: answer, button: buttonAnswer3)
        }else {
            presentAlertGameOver()
        }
    }
    
}

extension ViewController {
    
    func startGame() {
        self.questionView.isHidden = true
        buttonAnswer1.isHidden = true
        buttonAnswer2.isHidden = true
        buttonAnswer3.isHidden = true
        spinner.isHidden = false
        game.newGame()
    }
    
    @objc func questionsLoaded() {
        DispatchQueue.main.async {
            self.questionView.isHidden = false
            self.buttonAnswer1.isHidden = false
            self.buttonAnswer2.isHidden = false
            self.buttonAnswer3.isHidden = false
            self.spinner.isHidden = true
            self.nextQuestion()
        }
    }
    
    private func nextQuestion() {
        self.questionView.title = "Capitale \(self.game.currentQuestion.name) ?"
        self.buttonAnswer1.setTitle(self.game.answers[0], for: .normal)
        self.buttonAnswer2.setTitle(self.game.answers[1], for: .normal)
        self.buttonAnswer3.setTitle(self.game.answers[2], for: .normal)
        let svgURL = URL(string: self.game.currentQuestion.flag)!
        //let svgImage = SVGKImage(contentsOf: svgURL)
        let data = NSData(contentsOf: svgURL)
        let img = SVGKImage(data: data! as Data?)
        self.questionView.img = (img?.uiImage)!
    }
    
    private func animationQuestion(answer: Bool, button: UIButton) {
        let bgColor = button.backgroundColor
        if answer {
            button.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            button.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            let size = UIScreen.main.bounds.size
            self.questionView.transform = CGAffineTransform(translationX: 0.0, y: -size.height/2)
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                if self.game.state == .going {
                    self.nextQuestion()
                }
                button.backgroundColor = bgColor
                button.transform = .identity
                self.questionView.transform = .identity
            }, completion: nil)
        }else {
            button.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            button.transform = CGAffineTransform(rotationAngle: CGFloat.pi/10)
            let size = UIScreen.main.bounds.size
            self.questionView.transform = CGAffineTransform(translationX: 0.0, y: -size.height/2)
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                if self.game.state == .going {
                    self.nextQuestion()
                }
                button.backgroundColor = bgColor
                button.transform = .identity
                self.questionView.transform = .identity
            }, completion: nil)
        }
    }
}

extension ViewController {
    func presentAlertGameOver() {
        let alert = UIAlertController(title: "Game Over", message: "Start a new game ?", preferredStyle:.alert)
        let yes = UIAlertAction(title: "Yes", style: .default, handler: { (aler) in
            self.startGame()
        })
        let no = UIAlertAction(title: "No", style: .default, handler: nil)
        alert.addAction(yes)
        alert.addAction(no)
        present(alert, animated: true, completion: nil)
    }
    
}
