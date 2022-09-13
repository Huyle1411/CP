import Foundation
import SwiftUI

struct ContestListView: View {
    
    @StateObject var viewmodel = ContestListViewModel()
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
        //viewmodel.loadAPI()
    }
    
    let favoriteContests = ["atcoder.jp",
                            "codeforces.com",
                            "codechef.com",
                            "codingcompetitions.withgoogle.com",
                            "facebook.com",
                            "leetcode.com"
    ]
    
    func checkFavoriteContest(cur_contest: Contest)->Bool {
        let result = favoriteContests.contains(where: cur_contest.host.contains)
        if result == false {
            return false
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        if let date = dateFormatter.date(from: cur_contest.start) {
            let now = Date()
            if now > date {
                return false
            }
        }
        
        return true
    }
    
    @ViewBuilder
    func buildContent() -> some View {
        switch viewmodel.apiState {
        case .loading:
            ZStack {
                RoundedRectangle(cornerRadius: 15).fill(Color.gray.opacity(0.1))
                ProgressView {
                    Text("Loading...")
                        .font(.title2)
                }
            }.frame(width: 120, height: 120, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 25).stroke(Color.gray,lineWidth: 2))
            
        case .success:
            NavigationView {
                List(viewmodel.contests.filter { return checkFavoriteContest(cur_contest: $0)}) { item in
                    ContestRow(contest: item)
                        .scaleEffect(x: -1, y: 1, anchor: .center)
                        .rotationEffect(.radians(.pi))
                }
                .scaleEffect(x: -1, y: 1, anchor: .center)
                .rotationEffect(.radians(.pi))
                .listStyle(GroupedListStyle())
            }
        case .failure(let error):
            Text(error)
                .font(.title)
        }
    }
    
    var body: some View {
        HStack {
            buildContent()
        }
        .onAppear {
            viewmodel.loadAPI()
        }
    }
}

struct ContestListView_Previews: PreviewProvider {
    static var previews: some View {
        ContestListView()
    }
}
