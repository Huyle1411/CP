//
//  DetailContestRow.swift
//  hai_dep_trai_i_love_you
//
//  Created by VCUEntry on 9/14/22.
//

import SwiftUI

struct DetailContestRow: View, UIViewController {
    var contest: Contest
    
    //    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack {
            Text(verbatim: contest.event)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            Spacer()
            Group {
                Text("Duration").font(.headline)
                Text(verbatim: convertDuration(seconds: contest.duration))
                Text("Start:").font(.headline)
                Text(verbatim: convertDatetime(cur_date: contest.start))
                Text("End:").font(.headline)
                Text(verbatim: convertDatetime(cur_date: contest.end))
            }
            Group {
//                let link = "[" + contest.host + "]" + "(" + contest.href + ")"
//                Text(.init(link))
                Link(contest.href, destination: URL(string: contest.href)!)
            }
            Spacer()
            TimerView(setDate: getDate(cur_date: contest.start)).font(.largeTitle).foregroundColor(.green)

        }
    }
}

