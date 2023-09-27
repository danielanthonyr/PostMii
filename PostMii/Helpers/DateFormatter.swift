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
    
    /// Returns a string in ""29/09/2023 05:25 PM"" format to a usable date object
    func getDateFromString(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        
        return nil
    }
}
