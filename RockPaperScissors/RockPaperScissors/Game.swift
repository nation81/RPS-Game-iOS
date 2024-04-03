//
//  Game.swift
//  RockPaperScissors
//
//  Created by 이주상 on 2023/11/23.
//

import Foundation

final class Game {
    // MARK: Properties
    private var loopState: Bool = true
    
    private var gameResult: GameResult = .draw
    
    private var userInput: Int = 0
    
    private var currentPlayerTurn: PlayerTurn = .human
    
    private let mookZziBbaDictionary: [Int: String] = [1: "묵", 2: "찌", 3: "빠"]
    
    private var isPlayingMookZziBba: Bool = false
    
    func load() {
        playRockScissorsPaper()
    }
    
    // MARK: RockScissorsPaper
    private func playRockScissorsPaper() {
        while loopState {
            
            print(Prompt.rockScissorsPaperMenu, terminator: " ")
            
            receiveUserInput() {
                print(Prompt.badInput)
                print(Prompt.rockScissorsPaperMenu, terminator: " ")
            }
            
            switch userInput {
                
            case 1, 2, 3:
                calculateRockScissorsPaperResult(with: userInput)
                
                print(gameResult.rawValue)
                
                if [.win, .lose].contains(gameResult) {
                    isPlayingMookZziBba = true
                    makeInitialSettingForMookZziBba()
                    playMookZziBba()
                }
                
            case 0:
                shutDown()
                
            default:
                print(Prompt.badInput)
            }
        }
    }
    
    private func calculateRockScissorsPaperResult(with userInput: Int) {
        let randomInt: Int = Int.random(in: 1...3)
        
        let difference: Int = randomInt - userInput
        
        switch difference {
        case 0:
            setGameResult(.draw)
        case -1, 2:
            setGameResult(.lose)
        case 1, -2:
            setGameResult(.win)
        default:
            break
        }
    }
    
    private func setGameResult(_ gameResult: GameResult) {
        self.gameResult = gameResult
    }
    
    private func receiveUserInput(completion: () -> Void) {
        while true {
            if let input = readLine(), let inputInt = Int(input) {
                self.userInput = inputInt
                break
            } else {
                completion()
            }
        }
    }
    
    private func shutDown() {
        print(Prompt.gameExit)
        breakLoop()
    }
    
    private func breakLoop() {
        self.loopState = false
    }
    
    // MARK: MookZziBba
    private func playMookZziBba() {
        while true {
            print(Prompt.mookZziBbaMenu(currentPlayerTurn), terminator: " ")
            
            receiveUserInput() {
                if self.currentPlayerTurn == .human {
                    self.changePlayerTurn()
                }
                print(Prompt.badInput)
                print(Prompt.mookZziBbaMenu(self.currentPlayerTurn), terminator: " ")
            }
            
            switch userInput {
            case 1, 2, 3:
                calculateMookZziBbaResult(with: userInput)
                return
            case 0:
                shutDown()
                return
            default:
                print(Prompt.badInput)
                if currentPlayerTurn == .human {
                    changePlayerTurn()
                }
            }
        }
    }
    
    private func makeInitialSettingForMookZziBba() {
        let player: PlayerTurn = (gameResult == .win) ? .human : .computer
        setCurrentPlayerTurn(player)
    }
    
    private func setCurrentPlayerTurn(_ currentPlayerTurn: PlayerTurn) {
        self.currentPlayerTurn = currentPlayerTurn
    }
    
    private func calculateMookZziBbaResult(with input: Int) {
        
        let randomInt: Int = Int.random(in: 1...3)
        
        let computerChoice: String = mookZziBbaDictionary[randomInt] ?? ""
        
        let userChoice: String = mookZziBbaDictionary[userInput] ?? ""
        
        print(Prompt.makeAllChoicesMessage(computerChoice, userChoice))
        
        let difference: Int = randomInt - userInput
        
        switch difference {
        case 0:
            draw()
        case -1, 2:
            handleWinningSituation(loser: .human)
        case 1, -2:
            handleWinningSituation(loser: .computer)
        default:
            break
        }
    }
    
    private func handleWinningSituation(loser: PlayerTurn) {
        if currentPlayerTurn == loser {
            changePlayerTurn()
        }
        print(Prompt.currentTurnMessage(currentPlayerTurn))
        playMookZziBba()
    }
    
    private func draw() {
        print(Prompt.winnerMessage(currentPlayerTurn))
        breakLoop()
    }
    
    private func changePlayerTurn() {
        let playerTurn: PlayerTurn = (self.currentPlayerTurn == .human) ? .computer : .human
        setCurrentPlayerTurn(playerTurn)
    }
}
