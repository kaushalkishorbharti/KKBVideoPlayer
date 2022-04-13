//
//  DCUIFDateTimePicker.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 22/06/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit



public class DCUIFDateTimePicker: NSObject {
    
    var completionHandler:((_ date:Date)->Void)!
    var selector:WWCalendarTimeSelector!;
    
    fileprivate var singleDate: Date = Date()
    public var multipleDates: [Date] = []
 
    
    
    public enum DateTimePickerType{
        
       case DateMonth
       case MonthYear
       case Year
       case YearMonthDate
    }
    
    public  func openDatePicker(type:DateTimePickerType,complition:@escaping (_ date:Date)->Void){
        
        completionHandler=complition;
        
         selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: DCUIFramework.bundle).instantiateInitialViewController()
            as? WWCalendarTimeSelector
        selector.delegate = self
        selector.optionSelectionType = .single
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
//        if(multipleDates.count > 0 && multipleDates[0] != nil){
//
//             selector.optionCurrentDate = multipleDates[0];
//        }
        if(multipleDates.count > 1 && multipleDates[1] != nil){
            
            selector.optionCurrentDate = multipleDates[1];
        }
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        
        switch type {
        case DateTimePickerType.DateMonth:
            selector.optionStyles.showDateMonth(true)
            selector.optionStyles.showMonth(false)
            selector.optionStyles.showYear(true)
            selector.optionStyles.showTime(false)
            break;
    
        case DateTimePickerType.MonthYear:
            selector.optionStyles.showDateMonth(false)
            selector.optionStyles.showMonth(true)
            selector.optionStyles.showYear(true)
            selector.optionStyles.showTime(false)
            break;
            
        case DateTimePickerType.Year:
            selector.optionStyles.showDateMonth(false)
            selector.optionStyles.showMonth(false)
            selector.optionStyles.showYear(true)
            selector.optionStyles.showTime(false)
            break;
            
        case DateTimePickerType.YearMonthDate:
            selector.optionStyles.showDateMonth(true)
            selector.optionStyles.showMonth(false)
            selector.optionStyles.showYear(true)
            selector.optionStyles.showTime(false)
            break;
        }

        DCUIFViewController.getTopViewController().present(selector, animated: true, completion: nil);
    
    }
    

}

extension DCUIFDateTimePicker: WWCalendarTimeSelectorProtocol{
    
    public func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
       // print("Selected \n\(date)\n---")
        
        completionHandler(date);
        //self.valueObject = date
        //self.txtFeild.text = date.stringFromFormat("d' 'MMMM' 'yyyy', 'h':'mma")
    }
    
    public func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, dates: [Date]) {
        //print("Selected Multiple Dates \n\(dates)\n---")
        if let date = dates.first {
             completionHandler(date);
           // self.txtFeild.text = date.stringFromFormat("d' 'MMMM' 'yyyy', 'h':'mma")
        }
        else {
            //dateLabel.text = "No Date Selected"
        }
        // multipleDates = dates
    }
    
    public func WWCalendarTimeSelectorShouldSelectDate(_ selector: WWCalendarTimeSelector, date: Date) -> Bool {
       
        if(multipleDates.count > 2){
             return  multipleDates[2].compare(date) == date.compare(multipleDates[0])
        }
        else{
            return true;
        }
     
        
//        if(multipleDates[0] != Date()){
//            if date.compare(multipleDates[0]) != .orderedAscending {
//                return false;
//            }
//            
//            
//            return true;
//            
//        }
//         if(multipleDates[2] != Date() ){
//            if date.compare(multipleDates[2]) != .orderedDescending {
//                return false;
//            }
//            
//            
//            return true;
//        }
//        
//        return true;
        
    }
    
}
