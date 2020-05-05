//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    
    var quizBrain = QuizBrain()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trueButton.layer.cornerRadius = 20
        falseButton.layer.cornerRadius = 20
        updateUI()
    }
    
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle! //True, False
        let userGotItRight = quizBrain.checkAnswer(userAnswer)
        
        if userGotItRight {
            sender.backgroundColor = .green
            quizBrain.playSound(sound: "Success")
        } else {
            sender.backgroundColor = .red
            quizBrain.playSound(sound: "Fail")
        }
        
        quizBrain.nextQuestion()
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    @objc func updateUI() {
        if quizBrain.isEnd {
            let score = quizBrain.stat
            showAlert(title: "Конец игры", score: score)
            quizBrain.isEnd = !quizBrain.isEnd
            updateUI()
        } else {
            progressBar.progress = quizBrain.getProgress()
            questionLabel.text = quizBrain.getQuestionText()
            scoreLabel.text = "Счет: \(quizBrain.getScore())"
            numberLabel.text = "\(quizBrain.questionNumber + 1) из \(quizBrain.quiz.count)"
            trueButton.backgroundColor = .clear
            falseButton.backgroundColor = .clear
        }
    }
    func showAlert(title: String, score: Int) {
        let message = "Ваш счет: \(score)"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Введите Ваше имя"
        }
        
        let saveAction = UIAlertAction(title: "Сохранить", style: .default, handler: { alert -> Void in
            if let textField = alertController.textFields?[0] {
                if textField.text!.count > 0 {
                    self.quizBrain.recordName = textField.text!
                    self.quizBrain.saveRecords(name: self.quizBrain.recordName, number: score)
                    print(self.quizBrain.store.defaults.dictionary(forKey: "record")!)
                }
            }
        })
        
        alertController.addAction(saveAction)
        
        alertController.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: { alert -> Void in
            if let textField = alertController.textFields?[0] {
                if !textField.text!.isEmpty {
                    self.quizBrain.recordName = textField.text!
                    self.quizBrain.saveRecords(name: self.quizBrain.recordName, number: score)
                    print(self.quizBrain.store.defaults.object(forKey: "record") as? [String:Int] ?? [String:Int]())
                }
            }
            exit(0)
        }))
        
        alertController.preferredAction = saveAction
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func recordButtonTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToResult", sender: self)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "goToResult" {
                let destinationVC = segue.destination as! RecordsViewController
                destinationVC.records = quizBrain.getStringRecord(dict: quizBrain.dict)
                destinationVC.LabelHeight = quizBrain.dictHeight
            }
    }
}
