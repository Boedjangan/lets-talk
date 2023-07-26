/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct CameraViewfinderView: View {
    @Binding var image: Image?
    
    var body: some View {
        GeometryReader { geometry in
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

struct ViewfinderView_Previews: PreviewProvider {
    static var previews: some View {
        CameraViewfinderView(image: .constant(Image(systemName: "pencil")))
    }
}
