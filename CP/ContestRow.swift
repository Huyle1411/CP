import SwiftUI

struct ContestRow : View {
    var contest: Contest
    
    func convertDatetime(cur_date: String)->String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy EEE HH:mm"
        
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

    var body: some View {
        VStack {
            HStack {
                Text("event:")
                Spacer()
                Text(contest.event)
            }
            HStack {
                Text("duration:")
                Spacer()
                Text(verbatim: convertDuration(seconds: contest.duration))
            }
            HStack {
                Text("start:")
                Spacer()
                Text(verbatim: convertDatetime(cur_date: contest.start))
            }
            HStack {
                Text("end:")
                Spacer()
                Text(verbatim: convertDatetime(cur_date: contest.end))
            }
            HStack {
                Text("host:")
                Spacer()
                Text(verbatim: contest.host)
            }
        }
    }
}
