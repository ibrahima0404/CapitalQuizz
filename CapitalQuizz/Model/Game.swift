//
//  Game.swift
//  CapitalQuizz
//
//  Created by Ibrahima KH GUEYE on 29/04/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

import Foundation
class Game {
    
    
    //MARK: - enumeration for game state
    enum State {
        case going, finish
    }
    
    var state: State = .going
    private var questions = [Question]()
    private var currentIndex = 0
    var answers = [String]()
    
    var currentQuestion: Question {
        return questions[currentIndex]
    }
    
    //MARK: - return true if the user answer is correct and false otherwise
    func answserToQuestion(with answer: String)-> Bool {
        let ans = answer == currentQuestion.capital
        nextQuestion()
        return ans
    }
    
    //MARK: - go to next question
    private func nextQuestion() {
        currentIndex += 1
        if currentIndex < questions.count - 1 {
            getAnswers()
        }else {
            finishGame()
        }
    }
    
    //MARK: - set the game over
    private func finishGame(){
        state = .finish
    }
    
    //MARK: - start new game part
   func newGame() {
        state = .going
        currentIndex = 0
        QuestionsManager.shared.getCountries { countries in
            self.questions = countries
            let name = Notification.Name(rawValue: "QuestionLoaded")
            let notification = Notification(name: name)
            NotificationCenter.default.post(notification)
            self.getAnswers()
        }
    
    }
    
    //MARK - this func gives the answers that will display
    private func getAnswers() {
        var array = questions
        array.remove(at: currentIndex)
        let index1  = Int(arc4random_uniform(UInt32(array.count)))
        let index2  = Int(arc4random_uniform(UInt32(array.count)))
        answers = [currentQuestion.capital, array[index1].capital, array[index2].capital]
        answers = answers.sorted()
    }
}
