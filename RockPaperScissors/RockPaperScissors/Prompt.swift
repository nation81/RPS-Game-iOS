//
//  Constant.swift
//  RockPaperScissors
//
//  Created by Doyoung An on 11/23/23.
//

import Foundation

struct Prompt {
    private init() {}
    
    //MARK: RockScissorsPaper
    static let rockScissorsPaperMenu: String = "가위(1), 바위(2), 보(3)! <종료 : 0> :"
    
    static let gameExit: String = "게임 종료"
    
    static let badInput: String = "잘못된 입력입니다. 다시 시도해주세요"
    
    //MARK: MookZziBba
    static func mookZziBbaMenu(_ playerTurn: PlayerTurn) -> String {
        return "[\(playerTurn.rawValue) 턴] 묵(1), 찌(2), 빠(3)! <종료 : 0> :"
    }
    
    static func winnerMessage(_ playerTurn: PlayerTurn) -> String {
        return "\(playerTurn.rawValue)의 승리!"
    }
    
    static func currentTurnMessage(_ playerTurn: PlayerTurn) -> String {
        return "\(playerTurn.rawValue)의 턴입니다"
    }
    
    static func makeAllChoicesMessage(_ computerChoice: String, _ userChoice: String) -> String {
        return "컴퓨터 : \(computerChoice), 유저 : \(userChoice)"
    }
}
