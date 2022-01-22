//
//  Letter.swift
//  Wordle Clone
//
//  Created by Brandon Thio on 22/1/22.
//

import Foundation
import SwiftUI

class Letter: Identifiable {
    var char: Character { Character(string) }
    var string: String
    var color: Color? = nil
    var id = UUID()
    
    init(_ letter: String, color: Color? = nil) {
        self.string = letter.lowercased()
        self.color = color
    }
}

extension Array where Element == Letter {
    func setColor(for wordle: String) {
        guard self.count == 5 else { return }
      
        let wordle = wordle.reduce(into: Array<String>()) { (res, letter) in
            res.append(String(letter))
            
        }
        
        for index in self.indices {
            let letter = self[index].string
            
            if letter == wordle[index] {
                self[index].color = Color.PERFECT
            } else if wordle.contains(letter) {
                self[index].color = Color.ALMOST
            } else {
                self[index].color = Color.WRONG
            }
        }
    }
}
