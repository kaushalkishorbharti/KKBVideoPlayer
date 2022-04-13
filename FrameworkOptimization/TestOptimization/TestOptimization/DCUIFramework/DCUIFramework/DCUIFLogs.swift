//
//  DCUIFLogs.swift
//  DCUIFramework
//
//  Created by Deva Gupta on 28/08/18.
//  Copyright © 2018 Abhinav Agarwal. All rights reserved.
//

import UIKit
import os

public enum DCFLogType {
    
    case debug
    case fault
    case error
    case Default
    case info
}





public class DCUIFLogs: SwiftyBeaver {
    public static func initiliseLogging(){
        /// This will disable auto layout log
        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        #if DEBUG
        #else
        return
        #endif
        
        let log = self;
        let console = ConsoleDestination()  // log to Xcode Console
        
        // set custom level strings to add color
        console.levelString.verbose = "☺️ VERBOSE"
        console.levelString.debug = "🔵 DEBUG"
        console.levelString.info = "⚪️ INFO"
        console.levelString.warning = "⚠️ WARNING"
        console.levelString.error = "🔴 ERROR"
        
        _ = FileDestination()  // log to default swiftybeaver.log file
        _ = SBPlatformDestination(appID: "JXQljn", appSecret: "c7golkXf0bmav7wXt8k0ffVgIwNhqnCp", encryptionKey: "hXojzfsvnuGyH2eHk6tuklguKljsyb8W") // to cloud
        
        // use custom format and set console output to short time, log level & message
        console.format = "$DHH:mm:ss$d $L $M"
        // or use this for JSON output: console.format = "$J"
        
        // add the destinations to SwiftyBeaver
        if(true){
            log.addDestination(console)
        }
        //log.addDestination(file)
        // log.addDestination(cloud)
        
        
        // Now let’s log!
        log.verbose("not so important")  // prio 1, VERBOSE in silver
        log.debug("something to debug")  // prio 2, DEBUG in green
        log.info("a nice information")   // prio 3, INFO in blue
        log.warning("oh no, that won’t be good")  // prio 4, WARNING in yellow
        log.error("ouch, an error did occur!")  // prio 5, ERROR in red
        
        // log anything!
        log.verbose(123)
        log.info(-123.45678)
        log.warning(Date())
        log.error(["I", "like", "logs!"])
        log.error(["name": "Mr Beaver", "address": "7 Beaver Lodge"])
        
        // optionally add context to a log message
        console.format = "$L: $M $X"
        log.debug("age", "123")  // "DEBUG: age 123"
        log.info("my data", context: [1, "a", 2]) // "INFO: my data [1, \"a\", 2]
        
    }
    
    
    
    public static func log(message:StaticString, argument:String, type:DCFLogType) {
        
        //  return
        
        switch type{
            
        case .debug:
            printDebug(message: message, argument: argument)
            break;
        case .fault:
            printFault(message: message, argument: argument)
            break;
        case .error:
            printError(message: message, argument: argument)
            break;
        case .Default:
            printDefault(message: message, argument: argument)
            break;
        case .info:
            printInfo(message: message, argument: argument)
            break;
        }
        
        
    }
    
    
    
    
    
    public  static func printDebug(message:StaticString , argument:String ) {
        
        if #available(iOS 10.0, *) {
            #if DEBUG
            //print("Cancelled")
            os_log(message, log: OSLog.default, type: .debug, argument)
            #endif
            
            // os_log(message, log: OSLog.default, type: .debug, argument)
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    
    static func printInfo(message:StaticString , argument:String ) {
        
        if #available(iOS 10.0, *) {
            
            os_log(message, log: OSLog.default, type: .info, argument)
            
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    
    static func printError(message:StaticString , argument:String ) {
        
        if #available(iOS 10.0, *) {
            
            os_log(message, log: OSLog.default, type: .error, argument)
            
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    
    static func printFault(message:StaticString , argument:String ) {
        
        if #available(iOS 10.0, *) {
            
            os_log(message, log: OSLog.default, type: .fault, argument)
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    
    static func printDefault(message:StaticString , argument:String ) {
        
        if #available(iOS 10.0, *) {
            
            os_log(message, log: OSLog.default, type: .default, argument)
            
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    
    
    
    
    
}
