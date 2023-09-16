//
//  MessageView.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/15/23.
//

import SwiftUI

struct MessageView: View {
    
    @Environment(\.dismiss) private var dismiss
    var messageWrapper: MessageWrapper
    
    var body: some View {
        VStack {
            switch messageWrapper.messageType {
                case .error(let error, let guidance):
                    VStack {
                        Text(error.localizedDescription)
                        Text(guidance)
                    }.padding()
                        .background(.red)
                    
                case .info(let message):
                    Text(message)
                        .padding()
                        .background(.orange)
            }
            
            
        }
        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous))
        .foregroundColor(.white)
        .task {
            try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            dismiss()
        }
    }
}


#Preview {
    Group {
        MessageView(messageWrapper: MessageWrapper(messageType: .info("Email already registered.")))
        MessageView(messageWrapper: MessageWrapper(messageType: .error(SampleError.operationFailed, "Operation failed.")))
        
    }
}
