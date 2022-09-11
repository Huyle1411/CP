import SwiftUI

struct ContestRow : View {
    var contest: Contest

    var body: some View {
        VStack {
            HStack {
                Text("duration:")
                Spacer()
                Text(contest.duration)
            }
            HStack {
                Text("start:")
                Spacer()
                Text(verbatim: contest.start)
            }
            HStack {
                Text("host:")
                Spacer()
                Text(verbatim: contest.host)
            }
        }
    }
}