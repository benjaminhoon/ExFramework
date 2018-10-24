//
//  Ex+Date.swift
//  ExFramework
//
//  Created by LJH on 2018. 10. 5..
//  Copyright © 2018년 JH. All rights reserved.
//

public extension Date
{
    func toString(dateFormat:String) -> String
    {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    var startOfMonth:Date?
    {
        get{
            let calendar = Calendar.current
            let currentDateComponents = calendar.dateComponents([.year, .month], from: self as Date)
            let startOfMonth = calendar.date(from: currentDateComponents)
            return startOfMonth
        }
    }
    
    var endOfMonth:Date?
    {
        get{
            guard let plusOneMonthDate = dateByAddingMonths(1) else { return nil }
            
            let calendar = Calendar.current
            let plusOneMonthDateComponents = calendar.dateComponents([.year, .month], from: plusOneMonthDate)
            let endOfMonth = calendar.date(from: plusOneMonthDateComponents)?.addingTimeInterval(-1)
            return endOfMonth
        }
    }


    var toWeekDayKoString:String {
        get{
            let calendar = Calendar.current
            let exWeekDay = ExWeekDayType(rawValue: calendar.component(.weekday, from: self))!

            switch exWeekDay {
            case ExWeekDayType.Sunday:   return "일"
            case ExWeekDayType.Monday:   return "월"
            case ExWeekDayType.Tuesday:  return "화"
            case ExWeekDayType.Wednesday:return "수"
            case ExWeekDayType.Thursday: return "목"
            case ExWeekDayType.Friday:   return "금"
            case ExWeekDayType.Saturday: return "토"
            }
        }
    }
    
    
    fileprivate func dateByAddingMonths(_ monthsToAdd: Int) -> Date? {
        
        let calendar = Calendar.current
        var months = DateComponents()
        months.month = monthsToAdd
        
        return calendar.date(byAdding: months, to: self)
    }
    
    
    // 하루가 지났는지 체크 24시간 기준
    var isOneDayPass:Bool
    {
        get{
            let ONE_DAY_TIME:TimeInterval = -86400    // 24 hour
            
            let toDay = Date()
            if toDay.timeIntervalSince(self) <= 0 && toDay.timeIntervalSince(self) <= ONE_DAY_TIME
            {
                return true
            }
            else
            {
                return false
            }
        }
    }

}
