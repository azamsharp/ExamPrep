//
//  String+Extensions.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/12/23.
//

import Foundation

extension String {
    
    var isEmptyOrWhitespace: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isEmail: Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    func trim() -> String {
        self.trimmingCharacters(in: .whitespaces)
    }
    
}
