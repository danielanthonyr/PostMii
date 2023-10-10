//
//  DateFormatter.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-12.
//

import Foundation

extension DateFormatter {
    
    /// Returns in Sept 25 format
    func getDayOfMonthAndMonth(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMM"
        return formatter.string(from: date)
    }
    
    /// Returns in Thu, Oct 12 9:30 PM format
    func getShortDateWithTimeString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, d MMM h:mm a"
        return formatter.string(from: date)
    }
    
    /// Returns in 12/31/2019 format
    func getTimeString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter.string(from: date)
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
