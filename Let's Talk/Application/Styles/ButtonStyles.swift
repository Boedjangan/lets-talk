//
//  ButtonStyles.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import SwiftUI

enum FillButtonRole {
    case primary
    case secondary
    case cancel
    case destructive
}

enum OutlineButtonRole {
    case commitment
    case trust
    case honesty
    case execution
}

struct FillButtonStyle: ButtonStyle {
    let role: FillButtonRole
    
    init(_ role: FillButtonRole) {
        self.role = role
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.button)
            .foregroundColor(foregroundColor(for: role))
            .frame(maxWidth: CGFloat.infinity)
            .padding(Edge.Set.vertical, 17)
            .background(color(for: role, isPressed: configuration.isPressed))
            .buttonBorderShape(.roundedRectangle(radius: 10))
            .border(
                configuration.isPressed ? Color.buttonHoverBorderPrimary : Color.clear,
                width: configuration.isPressed ? 1 : 0
            )
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
    }
    
    func foregroundColor(for role: FillButtonRole?) -> Color? {
        role == .destructive || role == .cancel ? Color.white : Color.white
    }
    
    func color(for role: FillButtonRole?, isPressed: Bool) -> Color {
        switch role {
        case .primary:
            return isPressed ? Color.buttonHoverPrimary : Color.buttonPrimary
        case .secondary:
            return Color.buttonSecondary
        case .cancel?, .destructive?:
            return isPressed ? Color.red.opacity(0.8) : Color.red
        default:
            return isPressed ? Color.buttonHoverPrimary : Color.buttonPrimary
        }
    }
}

extension ButtonStyle where Self == FillButtonStyle {
    static func fill(_ role: FillButtonRole = .primary) -> FillButtonStyle {
        FillButtonStyle(role)
    }
}

struct OutlineButtonStyle: ButtonStyle {
    let role: OutlineButtonRole
    
    init(_ role: OutlineButtonRole) {
        self.role = role
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.topicButton)
            .foregroundColor(foregroundColor(for: role))
            .frame(maxWidth: CGFloat.infinity)
            .padding(Edge.Set.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(color(for: role), lineWidth: 1)
            )
    }
    
    func foregroundColor(for role: OutlineButtonRole?) -> Color? {
        switch role {
        case .commitment:
            return Color.buttonOutlineCommitment
        case .trust:
            return Color.buttonOutlineTrust
        case .honesty:
            return Color.buttonOutlineHonesty
        case .execution:
            return Color.buttonOutlineExecution
        default:
            return Color.buttonOutlineCommitment
        }
    }
    
    func color(for role: OutlineButtonRole?) -> Color {
        switch role {
        case .commitment:
            return Color.buttonOutlineCommitment
        case .trust:
            return Color.buttonOutlineTrust
        case .honesty:
            return Color.buttonOutlineHonesty
        case .execution:
            return Color.buttonOutlineExecution
        default:
            return Color.buttonOutlineCommitment
        }
    }
}

extension ButtonStyle where Self == OutlineButtonStyle {
    static func outline(_ role: OutlineButtonRole = .commitment) -> OutlineButtonStyle {
        OutlineButtonStyle(role)
    }
}
