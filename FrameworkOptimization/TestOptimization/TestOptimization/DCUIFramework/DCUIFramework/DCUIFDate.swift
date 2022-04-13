//
//  DCUIFDate.swift
//  DCUIFramework
//
//  Created by kaushal kishor on 07/03/18.
//  Copyright © 2018 Abhinav Agarwal. All rights reserved.
//

import UIKit

public class DCUIFDate: NSObject {
  
  @objc public static var timer: Timer?
  
  public enum DateStringFormat{
    case DayMonthNameYear;
    case WeekDayDayMonthNameYear;
    case OnlyDay;
    case OnlyMonth;
    case OnlyTime;
    case TwoDaysMonthNameYear;
    case DayMonthNameYearWithTime;
    case DayMonthYear;
    case MonthYear;
    case OnlyYear;
    case DayMonthNameYears;
    case AppDefault;
  }
  
  @objc public static func startTimer()
  {
    
  }
  
  @objc public static func stopTimer()
  {
    timer?.invalidate();
  }
  
  public static func getDateFormatterForType(type:DateStringFormat,timeZone:TimeZone =  TimeZone.current) -> DateFormatter{
    
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.timeZone = timeZone;
    
    
    switch type {
    case DateStringFormat.DayMonthNameYear:
      dateFormatter.dateFormat = "MMM dd, YYYY"
      break;
    case DateStringFormat.WeekDayDayMonthNameYear:
      dateFormatter.dateFormat = "dd MMM YYYY | HH:mm a"
      break;
      
    case DateStringFormat.DayMonthNameYearWithTime:
      dateFormatter.dateFormat = "YYYY, MMM dd HH:mm a"
      break;
      
    case DateStringFormat.OnlyDay:
      dateFormatter.dateFormat = "dd"
      break;
      
    case DateStringFormat.OnlyMonth:
      dateFormatter.dateFormat = "MMM"
      break;
      
    case DateStringFormat.OnlyTime:
      dateFormatter.dateFormat = "HH:mm"
      break;
      
    case DateStringFormat.TwoDaysMonthNameYear:
      dateFormatter.dateFormat = "YYYY, MMM dd";
      break;
      
    case DateStringFormat.DayMonthYear:
      dateFormatter.dateFormat = "dd/MM/yyyy";
      break;
    case DateStringFormat.MonthYear:
      dateFormatter.dateFormat = "MMMM-yyyy";
      break;
      
    case DateStringFormat.OnlyYear:
      dateFormatter.dateFormat = "YYYY";
      break;
      
    case DateStringFormat.AppDefault:
      dateFormatter.dateFormat = "MMM dd, YYYY"
      break;
    case .DayMonthNameYears:
      dateFormatter.dateFormat = "dd/MMMM/yyyy";
    }
    return dateFormatter;
  }
  
  public static func timeStampIntoData(timestamp:Double) ->Date{
    
    let unixTimestamp = timestamp;
    
    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp/1000))
    return date;
    
  }
  
  public static func timeStampTenDigitIntoDate(timestamp:Double) ->Date {
    if  "\(Int64.init(timestamp))".count > 10 {
      
      return Date(timeIntervalSince1970: TimeInterval(timestamp/1000))
    }else {
      return Date(timeIntervalSince1970: TimeInterval(timestamp))
    }
  }
  
  public static func getDateStringInAppFormatFromTimestamp(timestamp:Double,dateFormatter:DateFormatter) -> String{
    
    let date:Date = DCUIFDate.timeStampIntoData(timestamp: Double(timestamp));
    return  dateFormatter.string(from: date)
    
  }
  
  public static func getTwoDateStringInAppFormatFromTimestamp(timestamp1:Double,timestamp2:Double,dateFormatter:DateFormatter) -> String{
    
    let date1:Date = DCUIFDate .timeStampIntoData(timestamp: Double(timestamp1));
    let date2:Date = DCUIFDate .timeStampIntoData(timestamp: Double(timestamp2));
    
    let finalDateString = dateFormatter.string(from: date1) + " - " +
      getDateStringInAppFormatFromDate(date: date2, dateFormatter: DCUIFDate.getDateFormatterForType(type: DCUIFDate.DateStringFormat.OnlyMonth)) + " "
      + getDateStringInAppFormatFromDate(date: date2, dateFormatter: DCUIFDate.getDateFormatterForType(type: DCUIFDate.DateStringFormat.OnlyDay))
    
    return finalDateString
  }
  
  public static func getTwoDateTimeStringInAppFormatFromTimestamp(timestamp1:Double,timestamp2:Double,dateFormatter:DateFormatter) -> String{
    
    let date1:Date = DCUIFDate .timeStampIntoData(timestamp: Double(timestamp1));
    let date2:Date = DCUIFDate .timeStampIntoData(timestamp: Double(timestamp2));
    
    let finalDateString = dateFormatter.string(from: date1) + " at " + getDateStringInAppFormatFromDate(date: date1, dateFormatter: DCUIFDate.getDateFormatterForType(type: DCUIFDate.DateStringFormat.OnlyTime,timeZone: dateFormatter.timeZone)) +  " - " +
      getDateStringInAppFormatFromDate(date: date2, dateFormatter: DCUIFDate.getDateFormatterForType(type: DCUIFDate.DateStringFormat.OnlyMonth,timeZone: dateFormatter.timeZone)) + " "
      + getDateStringInAppFormatFromDate(date: date2, dateFormatter: DCUIFDate.getDateFormatterForType(type: DCUIFDate.DateStringFormat.OnlyDay)) + " at " + getDateStringInAppFormatFromDate(date: date2, dateFormatter: DCUIFDate.getDateFormatterForType(type: DCUIFDate.DateStringFormat.OnlyTime,timeZone: dateFormatter.timeZone)) ;
    
    return finalDateString + " " + dateFormatter.timeZone.abbreviation()!;
  }
  
  
  public static func getDateTimeWithTimeZone(timestamp1:Double,dateFormatter:DateFormatter) -> String{
    
    let date1:Date = DCUIFDate .timeStampIntoData(timestamp: Double(timestamp1));
    
    let finalDateString = dateFormatter.string(from: date1) + " at " + getDateStringInAppFormatFromDate(date: date1, dateFormatter: DCUIFDate.getDateFormatterForType(type: DCUIFDate.DateStringFormat.OnlyTime,timeZone: dateFormatter.timeZone)) ;
    
    return finalDateString + " " + dateFormatter.timeZone.abbreviation()!;
  }
  
  public static func getDateFromDateString(dateString:String,dateFormatter:DateFormatter) -> Date{
    
    
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
    let date = dateFormatter.date(from: dateString)
    return date!;
  }
  
  public static func getDateStringInAppFormatFromDate(date:Date,dateFormatter:DateFormatter) -> String{
    
    return  dateFormatter.string(from: date)
    
  }
  
  public static func getTimeStamp(date:Date) -> Double{
    
    return date.timeIntervalSince1970;
    
  }
  
  public static func getCurrentTimeZoneName() ->String {
    
    return DCUIFDate.getGMTForTimeZone(time:  TimeZone.current);
    
    //TimeZone.abbreviation();
    
  }
  
  public static func getGMTForTimeZone(time:TimeZone) ->String{
    
    
    let minute:Int = (time.secondsFromGMT()/60) % 60;
    let hour:Int = time.secondsFromGMT()/3600;
    let str:NSString =  NSString.init(format: "%02d:%02d", hour,minute);
    return NSString.init(format: "GMT+%@", str) as String
    
  }
  
  
  
  
  @objc public static func getCurrentTimeStamp() -> Double{
    return NSDate().timeIntervalSince1970;
  }
  
  public static func  getDateAfeterOrBefore(value:Int) -> Date{
    //    return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: 10, toDate: NSDate(), options: [])!
    
    return  NSCalendar.current.date(byAdding: .day, value: value, to: Date())!;
    
  }
  
  
  
  public static func getTimeAgoSinceDate(date:Date, numericDates:Bool) -> String {
    let calendar = NSCalendar.current
    let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
    let now = NSDate()
    let earliest = now.earlierDate(date as Date)
    let latest = (earliest == (now as Date) as Date) ? date : now as Date
    let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
    
    /* if (components.year! >= 2) {
     return "\(components.year!) years ago"
     } else if (components.year! >= 1){
     if (numericDates){
     return "1 year ago"
     } else {
     return "Last year"
     }
     } else if (components.month! >= 2) {
     return "\(components.month!) months ago"
     } else if (components.month! >= 1){
     if (numericDates){
     return "1 month ago"
     } else {
     return "Last month"
     }
     } else if (components.weekOfYear! >= 2) {
     return "\(components.weekOfYear!) weeks ago"
     } else if (components.weekOfYear! >= 1){
     if (numericDates){
     return "1 week ago"
     } else {
     return "Last week"
     }
     }*/
    
    if (components.weekOfYear! >= 1){
      return DCUIFDate.getDateStringInAppFormatFromDate(date: date, dateFormatter: DCUIFDate.getDateFormatterForType(type: DCUIFDate.DateStringFormat.AppDefault));
    }
    else if (components.day! >= 2) {
      return "\(components.day!) days ago"
    } else if (components.day! >= 1){
      if (numericDates){
        return "1 day ago"
      } else {
        return "Yesterday"
      }
    } else if (components.hour! >= 2) {
      return "\(components.hour!) hours ago"
    } else if (components.hour! >= 1){
      if (numericDates){
        return "1 hour ago"
      } else {
        return "an hour ago"
      }
    } else if (components.minute! >= 2) {
      return "\(components.minute!) minutes ago"
    } else if (components.minute! >= 1){
      if (numericDates){
        return "1 minute ago"
      } else {
        return "a minute ago"
      }
    } else if (components.second! >= 3) {
      return "\(components.second!) seconds ago"
    } else {
      return "Just now"
    }
    
  }
  
  public static func differenceBetweenTwoDateInNoOfDays(startDate: Double, endDate: Double) -> Int {
    // print("start date time stamp \(startDate)")
    // print("end date time stamp \(endDate)")
    
    var noOfDaysOfEndDate: Double = 0.0;
    if endDate > 0{
      noOfDaysOfEndDate = endDate;
    }else{
      noOfDaysOfEndDate = startDate + abs(endDate)
    }
    let difference = abs(noOfDaysOfEndDate) - abs(startDate);
    // print("doOfEndDate === \(noOfDaysOfEndDate)")
    // print("difference time stamp \(difference)")
    let days = (Int(difference / (60*60*24*1000)))
    return abs(days);
  }
  
  
}




