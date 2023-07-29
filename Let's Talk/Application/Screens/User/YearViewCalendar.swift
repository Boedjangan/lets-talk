//
//  YearViewCalendar.swift
//  Let's Talk
//
//  Created by Elwin Johan Sibarani on 28/07/23.
//

import SwiftUI

struct YearViewCalendar: View {
    var body: some View {
        LayoutView{
            ScrollView{
                LazyVStack{
                    ForEach(0...11, id: \.self){month in
                        MonthViewCalendar(currentMonth: month)
                            .padding(.bottom, 50)
                    }
                }
            }
        }
    }
}

struct YearViewCalendar_Previews: PreviewProvider {
    static var previews: some View {
        StatefulObjectPreviewView(LoveLogViewModel()) { vm in
            YearViewCalendar()
                .environmentObject(vm)
        }
    }
}
