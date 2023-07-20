//
//  GenderSelectorView.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import SwiftUI

struct GenderSelectorView: View {
    @Binding var gender:Int
    @State private var rectanglePosition: CGPoint = CGPoint(x:-86,y:0)
    
    var body: some View {
        ZStack{
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.genderSelectorWrapper)
                .frame (width: 344, height: 150)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
                .frame (width: 172, height: 150)
                .offset(x: rectanglePosition.x, y: rectanglePosition.y)
            HStack{
                Spacer()
                VStack{
                    Image(systemName: "person.fill")
                        .foregroundColor(Color.white)
                        .font(.system(size: 80))
                        .padding(.bottom,10)
                    Text("Male")
                        .foregroundColor(gender == 0 ? Color.white: Color.black)
                }
                
                Spacer()
                VStack{
                    Image(systemName: "person.fill")
                        .foregroundColor(Color.white)
                        .font(.system(size: 80))
                        .padding(.bottom,10)
                    Text("Female")
                        .foregroundColor(gender == 1 ? Color.white: Color.black)
                }
                Spacer()
            }
//            .frame(maxWidth: 343, maxHeight:140)
            
//
        }
        .onTapGesture {
                        // Update the rectanglePosition when the HStack is clicked
                        withAnimation {
                            if gender == 1 {
                                gender = 0
                                rectanglePosition = CGPoint(x: -86, y: 0)
                            } else {
                                gender = 1
                                rectanglePosition = CGPoint(x: 86, y: 0)
                            }
                        }
                    }
    }
}

struct GenderSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelectorView(gender:.constant(0))
    }
}
