//
//  MonthViewCalendar.swift
//  Let's Talk
//
//  Created by Elwin Johan Sibarani on 27/07/23.
//

import SwiftUI


struct MonthViewCalendar: View {
    @EnvironmentObject var loveLogVM: LoveLogViewModel
    let days: [String] = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    @State var currentMonth: Int = 6
    
    var body: some View {
        LayoutView{
            Text("\(extraData()[0]) - \(extraData()[1])")
                .padding(.bottom, 20)
            HStack{
                ForEach(days, id:\.self){day in
                    Text(day)
                        .font(.genderPickerLabel)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.addPhotoBackground)
                }
            }
            
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 30){
                ForEach(extractDate()){ value in
                    CardView(value: value)
                }
            }
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue)->some View{
        VStack{
            if value.day != -1{
                if let loveLogData = loveLogVM.loveLogs.first(where: {val in
                    return isSameDay(date1: val.createdAt, date2: value.date)
                }){
                    Text("\(value.day)")
                        .font(.dateCalendar)
                        .background(Image(loveLogData.questions[0].image ?? "coba")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .clipped()
                            .cornerRadius(100)
                        )
                    
                }
                else{
                    Text("\(value.day )")
                        .font(.dateCalendar)
                }
            }
        }
    }
    
    func isSameDay(date1: Date, date2: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2 )
    }
    
    func extraData() -> [String] {
        let formater = DateFormatter()
        formater.dateFormat = "MMMM YYYY"
        
        let date = formater.string(from: getCurrentMonth())
        
        return date.components(separatedBy: " ")
    }
    
    
    func getCurrentMonth() -> Date{
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: DateComponents(year: 2023, month: 01, day: 01))!
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: startDate) else{
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate() -> [DateValue]{
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

extension Date{
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap{day -> Date in
            return calendar.date(byAdding: .day, value: day-1 ,to: startDate )!
        }
    }
}

struct MonthViewCalendar_Previews: PreviewProvider {
    static var previews: some View {
        StatefulObjectPreviewView(LoveLogViewModel()) { vm in
            MonthViewCalendar()
                .environmentObject(vm)
        }
    }
}
