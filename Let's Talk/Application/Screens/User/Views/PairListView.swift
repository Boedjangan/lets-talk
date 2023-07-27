//
//  PairListView.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 21/07/23.
//

import SwiftUI

struct PairListView: View {
    @ObservedObject var multipeerHandler: MultipeerHandler
    @ObservedObject var userVM:UserViewModel
    let circleSize: CGFloat = 40.0
    let circularRegionRadius: CGFloat = 170
    @State private var circleRadius:CGFloat = 150
    
    var body: some View {
        VStack(alignment: .leading){
            GeometryReader{Geo in
                ForEach(Array(zip(multipeerHandler.persons.indices, multipeerHandler.persons)), id:  \.0) { (index, phone) in
                    PairItemView(name: phone.displayName)
                        .position(getCirclePosition(for: index, in: Geo.size, total: multipeerHandler.persons.count))
                        .onTapGesture {
                            multipeerHandler.invitePeer(phone)
                        }
                }
            }
            
        }
    }
    
    func getCirclePosition(for index: Int, in size: CGSize, total: Int) -> CGPoint {
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        let newRadius = circleRadius
        let angle = 2 * CGFloat.pi * CGFloat(index) / CGFloat(total)
        let x = center.x + newRadius * cos(angle)
        let y = center.y + newRadius * sin(angle)
        return CGPoint(x: x, y: y)
    }
}

extension CGFloat {
    func randomScaledValue() -> CGFloat {
        let randomFactor = CGFloat.random(in: 0.7...1.3)
        return self * randomFactor
    }
    
}

struct PairListView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView {
            //            PairListView()
        }
    }
}
