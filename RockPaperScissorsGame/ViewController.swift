//
//  ViewController.swift
//  RockPaperScissorsGame
//
//  Created by yakup metin on 31.01.2025.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
}


