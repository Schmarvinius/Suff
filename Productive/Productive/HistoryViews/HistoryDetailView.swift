//
//  HistoryDetailView.swift
//  Productive
//
//  Created by Weber, Til on 27.04.23.
//

import SwiftUI

struct HistoryDetailView: View {
    @State private var group: Group
    
    init(pGroup: Group){
        group = pGroup
    }
    
    var body: some View {
        Text(group.name)
    }
}

struct HistoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        HistoryDetailView()
        HistoryView()
            .environmentObject(DataManager())
    }
}
