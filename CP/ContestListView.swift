import Foundation
import SwiftUI

struct ContestListView: View {
    
    @StateObject var viewmodel = ContestListViewModel()
    
    init() {
        //viewmodel.loadAPI()
    }

    let favoriteContests = ["atcoder.jp",
        "codeforces.com",
        "codechef.com",
        "codingcompetitions.withgoogle.com",
        "facebook.com"]
        
    func checkFavoriteContest(str: String)->Bool {
        print(str)
        let result = favoriteContests.contains(where: str.contains)
        print(result)
        return result
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
                List(viewmodel.contests.filter { return checkFavoriteContest(str: $0.host)}) { item in
                // List(viewmodel.contests) { item in
                    ContestRow(contest: item)
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle(Text("Contests"))
            }
        case .failure(let error):
            Text(error)
                .font(.title)
        }
    }
    
    var body: some View {
        HStack {
            buildContent()
            // stateContent
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
