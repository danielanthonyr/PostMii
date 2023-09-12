//
//  DateFormatter.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-12.
//

import Foundation

extension DateFormatter {
    
    /// Returns in 12/31/2019 format
    func getShortDateString(date: Date) -> String {
        let formatter2 = DateFormatter()
        formatter2.timeStyle = .short
        return formatter2.string(from: date)
    }
    
    /// Returns in 12/31/2019 format
    func getTimeString(date: Date) -> String {
        let formatter2 = DateFormatter()
        formatter2.timeStyle = .medium
        return formatter2.string(from: date)
    }
}
