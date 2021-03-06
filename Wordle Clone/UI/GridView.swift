//
//  GridView.swift
//  Wordle Clone
//
//  Created by Brandon Thio on 22/1/22.
//

import SwiftUI

struct GridView: View {
    @EnvironmentObject var viewModel: WordleViewModel
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()),
                                    count: Game.numLetters)
    
    var body: some View {
        let attempts = viewModel.attempts
        let currentAttempt = viewModel.currentAttempt
        
        VStack {
            ForEach(0...Game.maxAttempts-1, id: \.self) { i in
                LazyVGrid(columns: columns) {
                    if i < attempts.count  {
                        AttemptView(attempt: attempts[i],
                                    isSelectable: false)
                    } else if i == attempts.count {
                        AttemptView(attempt: currentAttempt,
                                    isSelectable: true)
                    } else {
                        AttemptView(attempt: Array(repeating: nil,
                                                   count: Game.numLetters),
                                    isSelectable: false)
                    }
                    
                }
                .padding(.horizontal, 10)
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
            .environmentObject(WordleViewModel())
    }
}
