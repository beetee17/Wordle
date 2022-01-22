//
//  WordleViewModel.swift
//  Wordle Clone
//
//  Created by Brandon Thio on 22/1/22.
//

import Foundation

class WordleViewModel: ObservableObject {
    
    @Published var attempts: [[Letter]] = []
    @Published var currentAttempt: [Letter?] = Array(repeating: nil, count: Game.numLetters)
    
    @Published var selection = 0
    @Published var lastEditAction: EditAction = .None
    
    @Published var wordle: String = Game.wordles.randomElement()!
    
    var currentStreak = UserDefaults.standard.integer(forKey: "Current Win Streak") {
        didSet {
            UserDefaults.standard.set(currentStreak, forKey: "Current Win Streak")
        }
    }
    
    var previousBest = UserDefaults.standard.integer(forKey: "Previous Best") {
        didSet {
            UserDefaults.standard.set(previousBest, forKey: "Previous Best")
        }
    }
    
    func updateSelection(to newValue: Int, action: EditAction) {
        guard newValue >= 0 && newValue < Game.numLetters else { return }
        selection = newValue
        
        if action != lastEditAction {
            switch action {
            case .Insert:
                selection -= 1
            case .Delete:
                selection += 1
            case .None:
                break
            }
        }
        
        lastEditAction = action
    }
    
    func addChar(_ char: Letter) {
        updateSelection(to: selection+1, action: .Insert)
        currentAttempt[selection] = char
        
    }
    
    func deleteChar() {
        updateSelection(to: selection-1, action: .Delete)
        currentAttempt[selection] = nil
    }
    
    func confirmAttempt() {
        let currentAttempt = currentAttempt.compactMap({$0})
        guard currentAttempt.count == Game.numLetters else { return }
        guard isWord(currentAttempt) else { return }
            
        currentAttempt.setColor(for: wordle)
        Keyboard.shared.updateColors(for: currentAttempt)
        attempts.append(currentAttempt)
        
        for attempt in attempts {
            print(attempt.toString())
        }
        
        if isCorrect(currentAttempt) {
            ErrorViewModel.shared.showAlert(title: "WELL DONE",
                                            message: "\n\(wordle.capitalized) found in \(attempts.count) turns \n\nDefinition: N/A",
                                            action: {
                self.reset()
                self.currentStreak += 1
            })
            
            
        } else if attempts.count == Game.maxAttempts {
            // Player is out of attempts
            ErrorViewModel.shared.showAlert(title: "STREAK LOST",
                                            message: "\nPrevious Best: \(previousBest) \n\nThe word was \(wordle.capitalized)",
                                            action: {
                self.reset()
                self.currentStreak = 0
            })
            
            
        }
        
        self.currentAttempt = Array(repeating: nil, count: Game.numLetters)
        self.updateSelection(to: 0, action: .None)
    }
    
    func isWord(_ word: [Letter]) -> Bool {
        let word = word.toString()
        guard Game.dictionary.search(element: word) != -1 else {
            ErrorViewModel.shared.showBanner(title: "Invalid Attempt",
                                             message: "\(word.capitalized) is not a word!")
            return false
        }
        
        return true
    }
    
    func isCorrect(_ word: [Letter]) -> Bool {
        // check if valid word
        return word.toString() == wordle
    }
    
    func reset() {
        currentAttempt = Array(repeating: nil, count: Game.numLetters)
        attempts = []
        Keyboard.shared.reset()
        wordle = Game.wordles.randomElement()!
        previousBest = max(previousBest, currentStreak)
    }
}
