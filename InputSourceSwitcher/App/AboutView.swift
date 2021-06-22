import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("An App to change Input Sources swiftly by shortcuts on macOS Big Sur or later.")
            Spacer()
            Text("Click to `Reset` (⌘R) or `Quit` (⌘Q) to restart Source Switcher after you change `Input Sources` in `System Preferences -> Keyboard`.")
        }
        .padding()
        .frame(width: 300, height: 200)
    }
}
