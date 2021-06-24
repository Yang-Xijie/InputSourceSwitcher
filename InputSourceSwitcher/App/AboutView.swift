import SwiftUI

struct AboutView: View {
    @Environment(\.openURL) var openURL

    var body: some View {
        VStack(alignment: .leading) {
            Text("A menu bar App to **switch input sources** swiftly by shortcutson `macOS 11 Big Sur or later`.")

            Divider()

            VStack(alignment: .leading) {
                Text("`About`: Open this window. (⌘I)")
                Text("`Update`: Update input sources if you make changes in System Preferences. (⌘U)").lineLimit(nil)
                Text("`Reset`: Clear all shortcuts. (⌘R)")
                Text("`Quit`: Quit the app. (⌘Q)")
            } // TODO: macOS 12 will support markdown format.

            Divider()

            VStack(alignment: .leading) {
                // TODO: add
                Button("View it on GitHub") {
                    openURL(URL(string: "")!)
                }
                Button("Report a bug") {
                    openURL(URL(string: "")!)
                }

                HStack {
                    Button("Support") {
                        openURL(URL(string: "https://yang-xijie.github.io/postscript/support.html")!)
                    }
                    Text("WeChat Pay / Alipay / PayPal")
                }
            }

            Divider()

            // Open Source Project
            Text("Used Open Source Project")
            VStack(alignment: .leading) {
                HStack {
                    Link("KeyboardShortcuts",
                         destination: URL(string: "https://github.com/sindresorhus/KeyboardShortcuts")!)
                    Link("LICENSE",
                         destination: URL(string: "https://github.com/sindresorhus/KeyboardShortcuts/blob/main/license")!)
                }
                HStack {
                    Link("menubarpopoverswiftui2",
                         destination: URL(string: "https://github.com/zaferarican/menubarpopoverswiftui2")!)
                    Link("LICENSE",
                         destination: URL(string: "https://github.com/zaferarican/menubarpopoverswiftui2/blob/master/LICENSE")!)
                }
            }
        }
        .padding()

//        .frame(width: 625, height: 300)
    }
}
