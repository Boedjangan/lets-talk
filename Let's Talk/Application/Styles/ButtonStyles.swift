//
//  ButtonStyles.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.button)
            .foregroundColor(foregroundColor(for: configuration.role))
            .frame(maxWidth: CGFloat.infinity)
            .padding(Edge.Set.vertical, 17)
            .background(color(for: configuration.role))
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.25), radius: 1, x: 0, y: 4)
    }
    
    func foregroundColor(for role: ButtonRole?) -> Color? {
        role == .destructive || role == .cancel ? Color.white : Color.white
    }
    
    func color(for role: ButtonRole?) -> Color {
        switch role {
        case .cancel?, .destructive?:
            return Color.red
        default:
            return Color.buttonPrimary
        }
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle {
        PrimaryButtonStyle()
    }
}


struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.button)
            .foregroundColor(foregroundColor(for: configuration.role))
            .frame(maxWidth: CGFloat.infinity)
            .padding(Edge.Set.vertical, 17)
            .background(color(for: configuration.role))
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.25), radius: 1, x: 0, y: 4)
    }
    
    func foregroundColor(for role: ButtonRole?) -> Color? {
        role == .destructive || role == .cancel ? Color.white : Color.white
    }
    
    func color(for role: ButtonRole?) -> Color {
        switch role {
        case .cancel?, .destructive?:
            return Color.red
        default:
            return Color.buttonSecondary
        }
    }
}

extension ButtonStyle where Self == SecondaryButtonStyle {
    static var secondary: SecondaryButtonStyle {
        SecondaryButtonStyle()
    }
}
