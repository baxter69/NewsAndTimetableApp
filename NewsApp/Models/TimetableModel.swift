//
//  TimetableModel.swift
//  NewsApp
//
//  Created by user on 25.10.2021.
//

import Foundation

enum WeekDays: String, CaseIterable  {
    /// понедельник
    case monday    = "понедельник"
    /// вторник
    case tuesday   = "вторник"
    /// среда
    case wednesday = "среда"
    /// четверг
    case thursday  = "четверг"
    /// пятница
    case friday    = "пятница"
    /// суббота
    case saturday  = "суббота"
    /// воскресенье
    case sunday    = "воскресенье"
    
    init?(rawValue: String) {
        switch rawValue {
        case "понедельник":  self = .monday
        case "вторник":      self = .tuesday
        case "среда":        self = .wednesday
        case "четверг":      self = .thursday
        case "пятница":      self = .friday
        case "суббота":      self = .saturday
        case "воскресенье":  self = .sunday
        default:             return nil
        }
    }
}

enum GroupNames: String, CaseIterable {
    /// группа начальной подготовки №1
    case np1 = "группа начальной подготовки №1"
    /// группа начальной подготовки №2
    case np2 = "группа начальной подготовки №2"
    /// группа начальной подготовки №3
    case np3 = "группа начальной подготовки №3"
    /// учебно-тренировочная группа №1
    case ut1 = "учебно-тренировочная группа №1"
    /// учебно-тренировочная группа №2
    case ut2 = "учебно-тренировочная группа №2"
    /// учебно-тренировочная группа №3
    case ut3 = "учебно-тренировочная группа №3"
    
    init?(rawValue: String) {
        switch rawValue {
        case "группа начальной подготовки №1": self = .np1
        case "группа начальной подготовки №2": self = .np2
        case "группа начальной подготовки №3": self = .np3
        case "учебно-тренировочная группа №1": self = .ut1
        case "учебно-тренировочная группа №2": self = .ut2
        case "учебно-тренировочная группа №3": self = .ut3
        default: return nil
        }
    }
}

struct Time: Equatable {
    /// часы
    var hours: String
    /// минуты
    var minutes: String
    
    static func == (lhs: Time, rhs: Time) -> Bool {
        lhs.minutes == rhs.minutes && lhs.hours == rhs.hours
    }
}

struct TimeInterval: Equatable {
    /// начало
    var begin: Time
    /// конец
    var end: Time
    
    static func == (lhs: TimeInterval, rhs: TimeInterval) -> Bool {
        lhs.begin == rhs.begin && lhs.end == rhs.end
    }
    
    func getString() -> String {
        return "c \(begin.hours):\(begin.minutes) до \(end.hours):\(end.minutes)"
    }
}

struct TimetableModel: Equatable, Identifiable {
    private static var idSequence = sequence(first: 1, next: {$0 + 1})
    let id: Int
    var day: WeekDays
    var timeInterval: TimeInterval
    var groupName: GroupNames
    var trainer: String
    
    init?(day: WeekDays, timeInterval: TimeInterval, groupName: GroupNames, trainer: String) {
        guard let id = TimetableModel.idSequence.next() else { return nil }
        self.id = id
        self.day = day
        self.timeInterval = timeInterval
        self.groupName = groupName
        self.trainer = trainer
    }
    
    static func == (lhs: TimetableModel, rhs: TimetableModel) -> Bool {
        lhs.day == rhs.day && lhs.timeInterval == rhs.timeInterval && lhs.groupName == rhs.groupName && lhs.trainer == rhs.trainer
    }
}
