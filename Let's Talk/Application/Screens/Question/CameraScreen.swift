//
//  CameraScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 26/07/23.
//

import SwiftUI

struct CameraScreen: View {
    @EnvironmentObject var navigation: DashboardNavigationManager
    @EnvironmentObject var questionVM: QuestionViewModel
    
    private static let barHeightFactor = 0.15
    
    var body: some View {
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
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .task {
            await questionVM.camera.start()
        }
        .navigationTitle("Camera")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .statusBar(hidden: true)
    }
    
    private func CameraButtonsView() -> some View {
        HStack {
            Spacer()
            Button {
                navigation.push(to: .add_media)
            } label: {
                Label("", systemImage: questionVM.isImageSaved ? "checkmark.circle.fill" : "x.circle.fill")
                    .font(.headingBig)
                    .foregroundColor(.white)
            }
            .disabled(!questionVM.isImageSaved)
            
            Spacer()
            
            Button {
                if let currentQuestion = questionVM.currentQuestion {
                    questionVM.camera.takePhoto()
                    
                    Task {
                        await questionVM.handleCameraPhotos(questionId: currentQuestion.id)
                    }
                }
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
        .onAppear {
            questionVM.isImageSaved = false
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
