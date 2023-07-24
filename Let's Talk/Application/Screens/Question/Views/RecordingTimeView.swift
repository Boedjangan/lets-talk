//
//  RecordingTimeView.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 21/07/23.
//

import SwiftUI
/// Recording time view untuk perhitungan detik, menggunakan second (INT)
///     RecordingTimeView(timer:$timer)
struct RecordingTimeView: View {
    @Binding var timer:Int
    var hours: Int{
        timer / 3600
    }
    var minutes:Int{
        (timer % 3600) / 60
    }
    var seconds:Int{
        timer % 60
    }
  
    var body: some View {
        Text("\(timeUnit(time:hours)):\(timeUnit(time:minutes)):\(timeUnit(time:seconds))")
    }
    
    func timeUnit(time:Int) -> String{
        let timeUnitStr = String(time)
        return  time < 10 ? "0" + timeUnitStr : timeUnitStr
    }
    
 
}

struct RecordingTimeView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewView(1) { timer in
            RecordingTimeView(timer: timer)
                    }
//        RecordingTimeView(timer:50)
    }
}
