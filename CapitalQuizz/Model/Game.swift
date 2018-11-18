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
    var numberOfQuestions = 5
    private var score = 0;
    
    
    var currentQuestion: Question {
        return questions[currentIndex]
    }
    
    //MARK: - return true if the user answer is correct and false otherwise
    func answserToQuestion(with answer: String)-> Bool {
        let ans = answer == currentQuestion.capital
        nextQuestion()
        if ans { score += 1 }
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
        score = 0;
        QuestionsManager.shared.getCountries { countries in
            self.setQuestions(countriesDict: countries)
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
        var index1: Int
        var index2: Int
        repeat {
            index1  = Int(arc4random_uniform(UInt32(array.count)))
            index2  = Int(arc4random_uniform(UInt32(array.count)))
            answers = [currentQuestion.capital, array[index1].capital, array[index2].capital]
        }while (index1 == index2)
        
        answers = answers.sorted()
    }
    
    private func setQuestions(countriesDict: Array<Question>) {
        var countries = countriesDict
        //Because in the API response there are some countries where capital name is empty
        countries.removeAll { ($0.capital .isEmpty)}
        let size = countries.count - 1;
        var index  = Int(arc4random_uniform(UInt32(size)))
        if (index + numberOfQuestions) > size {
            index = index - numberOfQuestions;
        }
        let temp = countries[index...(index + numberOfQuestions)]
        self.questions = Array(temp)
    }
    
    func getScore() -> String {
        return ("\(score) / \(numberOfQuestions)")
    }
}


