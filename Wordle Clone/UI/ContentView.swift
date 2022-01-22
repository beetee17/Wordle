//
//  ContentView.swift
//  Wordle Clone
//
//  Created by Brandon Thio on 22/1/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var viewModel: WordleViewModel
    @ObservedObject var errorHandler = ErrorViewModel.shared
    
    var body: some View {
        ZStack {
            Color.accentColor.ignoresSafeArea()
            VStack {
                
                TopBar()
                
                GridView()
                
                Spacer()
                
                KeyboardView()
            }
        }
        .banner(isPresented: $errorHandler.bannerIsShown, title: errorHandler.bannerTitle, message: errorHandler.bannerMessage)
        .alert(isPresented: $errorHandler.alertIsShown) {
            errorHandler.alert!
        }
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.accentColor.ignoresSafeArea()
            ContentView()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                .environmentObject(WordleViewModel())
        }
    }
}
