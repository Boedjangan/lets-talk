//
//  CameraScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 26/07/23.
//

import SwiftUI

struct CameraScreen: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var questionVM: QuestionViewModel
    
    var questionId: UUID
    var imageName : String
    private static let barHeightFactor = 0.15
    
    var body: some View {
//        NavigationStack {
            GeometryReader { geometry in
                CameraViewfinderView(image: $questionVM.viewfinderImage)
                    .overlay(alignment: .top) {
                        Color.black
                            .opacity(0.75)
                            .frame(height: geometry.size.height * Self.barHeightFactor)
                    }
                    .overlay(alignment: .bottom) {
                        CameraButtonsView()
                            .frame(height: geometry.size.height * Self.barHeightFactor)
                            .background(.black.opacity(0.75))
                    }
                    .overlay(alignment: .center)  {
                        Color.clear
                            .frame(height: geometry.size.height * (1 - (Self.barHeightFactor * 2)))
                            .accessibilityElement()
                            .accessibilityLabel("View Finder")
                            .accessibilityAddTraits([.isImage])
                    }
                    .background(.black)
            }
            .task {
                await questionVM.camera.start()
                //                await model.loadPhotos()
                //                await model.loadThumbnail()
            }
            .navigationTitle("Camera")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .statusBar(hidden: true)
//        }
    }
    
    private func CameraButtonsView() -> some View {
        HStack {
            Spacer()
            Button {
                //
            } label: {
                Label("", systemImage: "arrow.triangle.2.circlepath")
                    .font(.headingBig)
                    .foregroundColor(.white)
            }
            .hidden()
            Spacer()
            Button {
                questionVM.camera.takePhoto()
                Task {
                        await questionVM.handleCameraPhotos(questionId: questionId,imageName: imageName)
                    }
                dismiss()
            } label: {
                Label {
                    Text("Take Photo")
                } icon: {
                    ZStack {
                        Circle()
                            .strokeBorder(.white, lineWidth: 3)
                            .frame(width: 72, height: 72)
                        Circle()
                            .fill(.white)
                            .frame(width: 60, height: 60)
                    }
                }
            }
            Spacer()
            Button {
                questionVM.camera.switchCaptureDevice()
            } label: {
                Label("Switch Camera", systemImage: "arrow.triangle.2.circlepath")
                    .font(.headingBig)
                    .foregroundColor(.white)
            }
            Spacer()
        }
        .buttonStyle(.plain)
        .labelStyle(.iconOnly)
        .padding()
    }
}

//struct CameraScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraScreen()
//    }
//}
