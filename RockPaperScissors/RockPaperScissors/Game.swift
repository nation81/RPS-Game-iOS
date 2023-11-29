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
    
    func load() {
        playRockScissorsPaper()
    }
    
    // MARK: RockScissorsPaper
    private func playRockScissorsPaper() {
        while loopState {
            
            print(Prompt.rockScissorsPaperChoice, terminator: " ")
            
            receiveUserInput()
            
            switch userInput {
                
            case 1, 2, 3:
                calculateRockScissorsPaperResult(with: userInput)
                
                print(gameResult.rawValue)
                
                if [.win, .lose].contains(gameResult) {
                    initMookZziBba()
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
    
    private func receiveUserInput() {
        while true {
            if let input = readLine(), let inputInt = Int(input) {
                self.userInput = inputInt
                break
            } else {
                print(Prompt.badInput)
                print(Prompt.rockScissorsPaperChoice, terminator: " ")
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
            print(Prompt.MookZziBbaChoice(currentPlayerTurn))
            
            receiveUserInput()
            
            switch userInput {
            case 1, 2, 3:
                //TODO: 묵찌빠 결과 계산 메서드 콜 (구현)
                break
            case 0:
                //TODO: 묵찌빠 게임 종료 메서드 콜 (구현)
                break // 구현후 삭제 코드
            default:
                print(Prompt.badInput)
                if currentPlayerTurn == .human {
                    //TODO: 잘못된 입력을 받은 경우 PlayerTurn 넘기는 메서드 콜 (구현)
                }
            }
        }
    }
    
    private func initMookZziBba() {
        let player: PlayerTurn = (gameResult == .win) ? .human : .computer
        setCurrentPlayerTurn(player)
    }
    
    private func setCurrentPlayerTurn(_ currentPlayerTurn: PlayerTurn) {
        self.currentPlayerTurn = currentPlayerTurn
    }
    
}
