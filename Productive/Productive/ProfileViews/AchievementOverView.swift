//
//  AchievementOverView.swift
//  Productive
//
//  Created by Weber, Til on 25.04.23.
//

import SwiftUI

struct AchievementOverView: View {
    
    @State private var ach : Achievement
    
    init(achievement: Achievement){
        self.ach = achievement
    }
    
    var body: some View {
        VStack {
            Image(systemName: ach.img)
                .font(.system(size: 100))
            Text(ach.desc)
        }
        .navigationTitle(ach.name)
    }
}

struct AchievementOverView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
