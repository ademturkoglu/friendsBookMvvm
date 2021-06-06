//
//  StringExtension.swift
//  FriendsBook
//
//  Created by adem.turkoglu on 6.06.2021.
//

import Foundation
import UIKit

extension String {
    
    func extractAll(type: NSTextCheckingResult.CheckingType) -> [NSTextCheckingResult] {
        var result = [NSTextCheckingResult]()
        do {
            let detector = try NSDataDetector(types: type.rawValue)
            result = detector.matches(in: self, range: NSRange(startIndex..., in: self))
        } catch { print("ERROR: \(error)") }
        return result
    }
    
    func to(type: NSTextCheckingResult.CheckingType) -> String? {
        if self.count < 10 {
            return self
        }
        let phones = extractAll(type: type).compactMap { $0.phoneNumber }
        switch phones.count {
        case 0:
            return nil
        case 1: return phones.first
        default: print("ERROR: Detected several phone numbers"); return nil
        }
    }
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter{CharacterSet.decimalDigits.contains($0)}
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    func makeACall() {
        guard   let number = to(type: .phoneNumber),
            let url = URL(string: "tel://\(number.onlyDigits())"),
            UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
        
    }
    
    func makeAMessage() {
        guard   let number = to(type: .phoneNumber),
            let url = URL(string: "sms://\(number.onlyDigits())"),
            UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
        
    }
    
    func makeAEmail() {
        guard let email = to(type: .init()),
            let url = URL(string: "mailto://\(email)"),
            UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
        
    }
    
    
}
