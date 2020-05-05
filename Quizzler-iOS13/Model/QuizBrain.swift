//
//  QuizBrain.swift
//  Quizzler-iOS13
//
//  Created by Юрий Федоров on 04.04.2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

var player = AVAudioPlayer()
//var alert = Alert()

struct QuizBrain {
    let quiz = [
        Question(q: "Использование мобильного телефона на заправке может спровоцировать взрыв.", a: "Ложь"),
        Question(q: "Бритье волос провоцирует их более густой рост.", a: "Ложь"),
        Question(q: "Лунатиков нельзя будить.", a: "Ложь"),
        Question(q: "Флот США содержит больше авианосцев, чем все флоты мира вместе взятые.", a: "Правда"),
        Question(q: "Четверть всех костей человека находится в стопе.", a: "Правда"),
        Question(q: "С поверхности Луны можно увидеть Китайскую стену.", a: "Ложь"),
        Question(q: "Пять колец Олимпиады символизируют пять видов спорта, которые изначально были на играх в Древней Греции.", a: "Ложь"),
        Question(q: "У улиток зеленая кровь.", a: "Правда"),
        Question(q: "Дж. К. Роулинг — первый автор-миллиардер.", a: "Ложь"),
        Question(q: "Кингстон — столица Ямайки.", a: "Правда"),
        Question(q: "Лас-Вегас имеет прозвище «город братской любви.", a: "Ложь"),
        Question(q: "Для подготовки к роли в «Американском психопате» Кристиан Бэйл пересматривал фильм «Психо» и наблюдал за повадками Нормана Бейтса.", a: "Ложь"),
        Question(q: "У Дании самый старый из ныне существующих флагов.", a: "Правда"),
        Question(q: "Нутеллу изобрели во время Второй мировой войны.", a: "Ложь"),
        Question(q: "8 из 10 самых высоких гор в мире находятся в Непале.", a: "Правда"),
        Question(q: "Санкт-Петербург — самый северный в мире город с населением более миллиона человек.", a: "Правда"),
        Question(q: "На каждого гражданина России приходится 2,5 православных храма.", a: "Ложь"),
        Question(q: "В 2002-м году по рейтингу ЮНЕСКО Екатеринбург вошёл в список 12-ти идеальных городов мира.", a: "Правда"),
        Question(q: "Площадь Сибири — это ~11% от всей суши на Земле.", a: "Ложь"),
        Question(q: "Игра «Tetris» была создана русским программистом.", a: "Правда"),
        Question(q: "Город Суздаль занимает всего 15 квадратных километров площади, при этом имеет 53 храма.", a: "Правда"),
        Question(q: "По прямой от Москвы до Вашингтона ближе, чем от Москвы до Владивостока.", a: "Ложь"),
        Question(q: "На гербе Челябинска изображен слон.", a: "Ложь"),
        Question(q: "В России придумали играть в гольф на вертолетах.", a: "Правда"),
        Question(q: "Если 31 декабря отправиться на поезде из Москвы в Магадан, то можно встретить новый год 8 раз.", a: "Ложь"),
        Question(q: "Каждый монарх династии Романовых оставил своему наследнику страну большего размера, чем получил от предшественника.", a: "Правда"),
        Question(q: "Российский математик в 2002 году решил одну из семи «задач тысячелетия».", a: "Правда"),
        Question(q: "В пустыне Сахара никогда не выпадал снег.", a: "Ложь"),
        Question(q: "В Китае «Кока-Кола» называется «Коку-Коле».", a: "Правда"),
        Question(q: "Облака не могут двигаться на юго-запад.", a: "Правда"),
        Question(q: "Пабло Пикассо нарисовал логотип для «Чупа-чупс».", a: "Ложь"),
        Question(q: "Ширли Хендерсон сыграла в «Гарри Поттере» 13-летнюю школьницу Плаксу Миртл, а на момент съёмок ей было 36 лет.", a: "Правда"),
        Question(q: "В Windows нельзя создать папку с названием «Con».", a: "Правда"),
        Question(q: "Позвоночник y верблюда искривлен по форме горба.", a: "Ложь"),
        Question(q: "Ни в одном языке мира нет обозначения для обратной части колена.", a: "Ложь"),
        Question(q: "Национальный оркестр Монако больше, чем его армия.", a: "Правда"),
        Question(q: "В казино Лас-Вегаса нет часов.", a: "Правда"),
        Question(q: "У белых медведей кожа черного цвета.", a: "Правда"),
        Question(q: "Северные немцы не понимают южных.", a: "Правда"),
        Question(q: "В центре земли такая же температура, как на поверхности Солнца.", a: "Правда")
    ]
    
    var store = Store(dictStore: ["":0])
    var dict = [String:Int]()
//Example for testing:
//    ["рд": 3, "Ь олло": 3, " тп": 1, "илл": 2, "ождо": 1, " ьпо": 0, "рдд": 3, "род до": 3, "рьл": 0, "  ьол": 0, "рлд": 2, "оддро": 0]
    
    var stat = 0
    var questionNumber = 0
    var score = 0
    var isEnd = false
    var recordName = ""
    var recordString = ""
    var dictHeight = 1
    
    mutating func checkAnswer(_ userAnswer: String) -> Bool {
        if userAnswer == quiz[questionNumber].answer {
            score += 1
            return true
        } else {
            return false
        }
    }
    
    func getScore() -> Int {
        return score
    }
    
    func getQuestionText() -> String {
        return quiz[questionNumber].text
    }
    
    func getProgress() -> Float {
        let progress = Float(questionNumber + 1) / Float(quiz.count)
        return progress
    }
    
    mutating func nextQuestion() {
        
        if questionNumber < quiz.count - 1 {
            questionNumber += 1
        } else {
            //Call alert from ViewController
        stat = score
        isEnd = true
            questionNumber = 0
            score = 0
        }
    }
    
    func playSound(sound: String) {
    let url = Bundle.main.url(forResource: sound, withExtension: "mp3")
    player = try! AVAudioPlayer(contentsOf: url!)
    player.play()
    }
    
    mutating func saveRecords(name: String, number: Int) {
//        if dict.contains(where: { (name, _) -> Bool in
//        })
        dict.updateValue(number, forKey: name)
        store.defaults.set(dict, forKey: "record")
        dictHeight = dict.count
        print(dictHeight)
    }
    
    mutating func getStringRecord(dict: [String:Int]) -> String {
        
        for (_, _) in dict {
            recordString = dict
                .sorted(by: {$0.value > $1.value})
                .map({ (key, value) -> String in
                return "\(key): \(value) очков"
            }).joined(separator: "\n")
        }
        return recordString
    }
}


