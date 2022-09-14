import SwiftUI

struct ContestRow : View, UIViewController {
    var contest: Contest
    
    var body: some View {
        VStack {
            Text(verbatim: contest.event)
                .multilineTextAlignment(.center)
//            Spacer()
//            HStack {
//                Text("Duration:")
//                Spacer()
//                Text(verbatim: convertDuration(seconds: contest.duration))
//            }
//            HStack {
//                Text("Start:")
//                Spacer()
//                Text(verbatim: convertDatetime(cur_date: contest.start))
//            }
//            HStack {
//                Text("End:")
//                Spacer()
//                Text(verbatim: convertDatetime(cur_date: contest.end))
//            }
//            HStack {
//                Text("Host:")
//                Spacer()
//                Text(verbatim: contest.host)
//            }
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
        if timeValue.day ?? 0 > 2 {
            return String(format: "%d days",
                          timeValue.day!)
        }else if timeValue.day ?? 0 > 0 {
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
