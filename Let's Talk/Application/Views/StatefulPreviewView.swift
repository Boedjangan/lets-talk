//
//  StatefulPreviewView.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 20/07/23.
//

import SwiftUI

/// A view that let you have a stateful preview
///
/// If we want to use a state for preview that receive binding, it's not allowed to add it directly in preview.
/// That's why we need a view that wraps the view that receive binding.
/// Just put the default value to the paremeter of this stateful preview.
///
///     StatefulPreviewView(stateValue) { state in
///         ViewAcceptBinding(bind: $state)
///     }
///
struct StatefulPreviewView<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content

    var body: some View {
        VStack {
            content($value)
        }
    }

    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(wrappedValue: value)
        self.content = content
    }
}
