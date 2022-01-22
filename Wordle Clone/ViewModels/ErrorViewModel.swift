//
//  ErrorViewModel.swift
//  Wordle Clone
//
//  Created by Brandon Thio on 22/1/22.
//

import Foundation
import SwiftUI

/// View model that controls the display of pop-up and banner notifications
class ErrorViewModel: NSObject, ObservableObject {
    
    static let shared = ErrorViewModel()
    
    /// True if a pop-up notification should be shown to the user
    @Published var alertIsShown = false
    
    /// Title of the pop-up
    @Published var alert: Alert? = nil 
    
    /// True if a banner notification should be shown to the user
    @Published var bannerIsShown = false
    /// Title of the banner
    @Published var bannerTitle = ""
    /// Contents of the banner
    @Published var bannerMessage = ""
    
    /// Displays a pop-up notification
    /// - Parameters:
    ///   - title: The title of the notification
    ///   - message: The message of the notification
    func showAlert(title: String, message: String, action: @escaping () -> Void) {
        alertIsShown = true
        alert = Alert(title: Text(title),
                      message: Text(message),
                      dismissButton: .default(Text("OK"), action: action))
    }
    
    /// Displays a banner-style notification
    /// - Parameters:
    ///   - title: The title of the notification
    ///   - message: The message of the notification
    func showBanner(title: String, message: String) {
        bannerTitle = title
        bannerMessage = message
        bannerIsShown = true
    }
}
