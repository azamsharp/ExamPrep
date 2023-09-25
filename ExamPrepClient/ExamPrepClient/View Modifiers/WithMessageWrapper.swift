//
//  WithMessageWrapper.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/23/23.
//

import Foundation
import SwiftUI

struct WithMessageWrapper: ViewModifier {
    
    @State private var messageWrapper: MessageWrapper?
    
    func body(content: Content) -> some View {
        content.environment(\.showMessage) { messageType in
                messageWrapper = MessageWrapper(messageType: messageType)
            }
        .overlay(alignment: .bottom) {
            if messageWrapper != nil {
                MessageView(messageWrapper: $messageWrapper)
            }
        }
    }
}
