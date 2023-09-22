import SwiftUI

class SelectedDate: ObservableObject {
    @Published var date: DateComponents?
}

// PREVIEW'S

let defaultSelectedDate = SelectedDate()

extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    var rightNow: Date {
        Calendar.current.dateInterval(of: .day, for: self)!.start
    }
    
    func diff(numDays: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: numDays, to: self)!
    }
    
    static func from(year: Int, month: Int, day: Int) -> Date? { // On SeedData
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? nil
    }
    var dateComponents: DateComponents {
        var dateComponents = Calendar.current.dateComponents(
            [.month,
             .day,
             .year,
             .hour,
             .minute],
            from: Date())
        dateComponents.timeZone = TimeZone.current
        dateComponents.calendar = Calendar(identifier: .gregorian)
        return dateComponents
    }
}

var dateForm: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.calendar = .current
    formatter.dateFormat = "dd/MM"
    return formatter
}


