//
//  ErrorWrapper.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/15/23.
//

import Foundation

struct MessageWrapper: Identifiable {
    let id = UUID()
    let error: Error?
    let guidance: String
}



