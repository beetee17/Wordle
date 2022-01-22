//
//  LetterView.swift
//  Wordle Clone
//
//  Created by Brandon Thio on 22/1/22.
//

import SwiftUI

struct LetterView: View {
    
    @State private var animating = false
    var letter: Letter?
    var animationDuration = 0.1
    
    var body: some View {
        let color = letter?.color
        
        ZStack {
            Rectangle()
                .frame(width: 70, height: 70)
                .border(getBorderColor(), width: 3)
                .foregroundColor(color ?? .clear)
                .scaleEffect(animating ? 1.1 : 1)
                .animation(.easeInOut(duration: animationDuration))
            
            if let letter = letter {
                Text(letter.string)
                    .font(.system(size: 40, weight: .heavy, design: .monospaced))
                    .foregroundColor(.white)
                    .textCase(.uppercase)
                    .onAppear {
                        print("LETTER \(letter.string)")
                        animating = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                            animating = false
                        }
                    }
            }
        }
    }
    func getBorderColor() -> Color {
        guard let letter = letter else {
            return .secondary
        }
        guard let color = letter.color else {
            return .white.opacity(0.8)
        }
        return color
    }
}

struct LetterView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.accentColor
            LetterView(letter: nil)
        }
    }
}
