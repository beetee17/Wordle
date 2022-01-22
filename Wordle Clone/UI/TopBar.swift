//
//  TopBar.swift
//  Wordle Clone
//
//  Created by Brandon Thio on 22/1/22.
//

import SwiftUI

struct TopBar: View {
    @EnvironmentObject var viewModel: WordleViewModel
    
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "questionmark.circle.fill")
                    .resizable().scaledToFill()
                    .frame(width:25, height: 25)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Text("Win Streak: \(viewModel.currentStreak)")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold, design: .default))
            
            Spacer()

            Button(action: {}) {
                Image(systemName: "line.horizontal.3")
                    .resizable().scaledToFill()
                    .frame(width:15, height: 15)
                    .foregroundColor(.white)
            }
                
        }
        .padding(.horizontal, 30)
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar()
    }
}
