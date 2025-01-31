//
//  ViewController.swift
//  RockPaperScissorsGame
//
//  Created by yakup metin on 31.01.2025.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var BotChoiceLabel: UILabel!
    @IBOutlet weak var ResultLabel: UILabel!
    @IBOutlet weak var YourChoice: UILabel!
    @IBOutlet weak var PointLabel: UILabel!
    
    enum Label: Int {
        case PointLabel = 0
    }
    
    enum Choice: String {
        case rock = "Rock"
        case paper = "Paper"
        case scissors = "Scissors"
    }
    
    var yourChoice: Choice = .rock
    var botChoice: Choice = .rock
    var score = 0
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadScore()
        ResultLabel.text = "..."
        YourChoice.text = "Make your choice..."
        BotChoiceLabel.text = "Waiting for your choice..."
        PointLabel.text = "Point: 0"
    }
    
    
    @IBAction func RockButton(_ sender: Any) {
        yourChoice = .rock
        YourChoice.text = "Your: Rock"
        botTurn()
        determineWinner()
    }
    
    @IBAction func PaperButton(_ sender: Any) {
        yourChoice = .paper
        YourChoice.text = "Your: Paper"
        botTurn()
        determineWinner()
    }
    
    @IBAction func ScissorsButton(_ sender: Any) {
        yourChoice = .scissors
        YourChoice.text = "Your: Scissors"
        botTurn()
        determineWinner()
    }
    
    func botTurn() {
        let choices: [Choice] = [.rock, .paper, .scissors]
        botChoice = choices.randomElement()!
        BotChoiceLabel.text = "Computer's Choice: \(botChoice.rawValue)"
    }
    
    // Kazananı belirleme
    func determineWinner() {
        if yourChoice == botChoice {
            ResultLabel.text = "Draw!"
        } else if (yourChoice == .rock && botChoice == .scissors) ||
                    (yourChoice == .paper && botChoice == .rock) ||
                    (yourChoice == .scissors && botChoice == .paper) {
            ResultLabel.text = "Won!"
            score += 2
        } else {
            ResultLabel.text = "Lose!"
            score -= 1
        }
        
        PointLabel.text = "Puan: \(score)"
        saveScore()
    }
    
    // Puanı Core Data'ya kaydetme
    func saveScore() {
        let fetchRequest: NSFetchRequest<Score> = Score.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            
            // Eğer veritabanında bir puan varsa, onu güncelle
            if let existingScore = results.first {
                existingScore.value = Int16(score)
            } else {
                // Eğer puan yoksa, yeni bir puan oluştur
                let newScore = Score(context: context)
                newScore.value = Int16(score)
            }
            
            // Değişiklikleri kaydet
            try context.save()
        } catch {
            print("Point unsaved: \(error)")
        }
    }
    
    // Core Data'dan puanı okuma
    func loadScore() {
        let fetchRequest: NSFetchRequest<Score> = Score.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            if let existingScore = results.first {
                score = Int(existingScore.value)
                PointLabel.text = "Point: \(score)"
            }
        } catch {
            print("Point unloading: \(error)")
        }
    }
}


