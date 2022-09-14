
//import Foundation
import SwiftUI

protocol UIViewController {
    func getDate(cur_date: String)->Date
    func convertDatetime(cur_date: String)->String
    func convertDuration(seconds: Int) -> String
}

extension UIViewController {
    func getDate(cur_date: String)->Date {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatterGet.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let date = dateFormatterGet.date(from: cur_date) else { return Date() }
        return date
    }
    
    func convertDatetime(cur_date: String)->String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatterGet.timeZone = TimeZone(abbreviation: "UTC")
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy EEE HH:mm"
        //        dateFormatterPrint.timeZone = TimeZone(abbreviation: "UTC")
        
        var result:String
        
        if let date = dateFormatterGet.date(from: cur_date) {
            result = dateFormatterPrint.string(from: date)
        } else {
            result = "Error Date time!!!"
        }
        return result
    }
    
    func convertDuration(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        var result: String
        var m: String
        var h: String
        
        if(hours < 10) {
            h = "0" + String(hours)
        } else {
            h = String(hours)
        }
        if(minutes < 10) {
            m = "0"+String(minutes)
        } else {
            m = String(minutes)
        }
        if hours > 23 {
            let days = seconds / 86400
            result = String(days) + " days"
        } else {
            result = h + ":" + m
        }
        return result
    }
}
