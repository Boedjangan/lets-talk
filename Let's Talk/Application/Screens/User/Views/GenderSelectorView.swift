//
//  GenderSelectorView.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import SwiftUI

enum Gender: Int {
    case male = 0
    case female = 1
}

struct GenderSelectorView: View {
    @Binding var gender: Gender
    @State private var rectanglePosition: CGPoint = CGPoint(x:-86,y:0)
    
    var genderIsMale: Bool {
        gender == .male
    }
    
    var genderIsFemale: Bool {
        gender == .female
    }
    
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
                    Image("Male")
                        .foregroundColor(Color.white)
                        .font(.system(size: 80))
                        .padding(.bottom,10)
                    Text("Male")
                        .foregroundColor(genderIsMale ? Color.white: Color.black)
                }
                
                Spacer()
                VStack{
                    Image("Female")
                        .foregroundColor(Color.white)
                        .font(.system(size: 80))
                        .padding(.bottom,10)
                    Text("Female")
                        .foregroundColor(genderIsFemale ? Color.white: Color.black)
                }
                Spacer()
            }
        }
        .onTapGesture {
            withAnimation {
                if genderIsMale{
                    gender = .female
                    rectanglePosition = CGPoint(x: -86, y: 0)
                } else {
                    gender = .male
                    rectanglePosition = CGPoint(x: 86, y: 0)
                }
            }
        }
    }
}

struct GenderSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelectorView(gender:.constant(.male))
    }
}
