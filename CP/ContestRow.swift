import SwiftUI

struct ContestRow : View {
    var contest: Contest
    
    //    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
    
    var body: some View {
        VStack {
            HStack {
                Text("Event:")
                Spacer()
                Text(verbatim: contest.event)
                    .font(.headline)
            }
            HStack {
                Text("Duration:")
                Spacer()
                Text(verbatim: convertDuration(seconds: contest.duration))
            }
            HStack {
                Text("Start:")
                Spacer()
                Text(verbatim: convertDatetime(cur_date: contest.start))
            }
            HStack {
                Text("End:")
                Spacer()
                Text(verbatim: convertDatetime(cur_date: contest.end))
            }
            HStack {
                Text("Host:")
                Spacer()
                Text(verbatim: contest.host)
            }
            HStack {
                Text("Time left:")
                Spacer()
                TimerView(setDate: getDate(cur_date: contest.start))
            }
        }
    }
}

struct TimerView: View {
    @State var nowDate:Date = Date()
    let setDate: Date
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.nowDate = Date()
        }
    }
    
    var body: some View {
        Text(TimerFunction(from: setDate))
            .onAppear(perform: {self.timer
            })
    }
    
    func TimerFunction(from date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let timeValue = calendar
            .dateComponents([.day, .hour, .minute, .second], from: nowDate, to: setDate)
        
        if timeValue.day ?? 0 > 0 {
            return String(format: "%d days %02d:%02d:%02d",
                          timeValue.day!,
                          timeValue.hour!,
                          timeValue.minute!,
                          timeValue.second!)
        } else {
            return String(format: "%02d:%02d:%02d",
                          timeValue.hour!,
                          timeValue.minute!,
                          timeValue.second!)
        }
        
    }
}
