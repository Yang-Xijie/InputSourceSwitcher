import SwiftUI

struct AboutView: View {
    @Environment(\.openURL) var openURL

    var body: some View {
        VStack(alignment: .leading) {
            Text("A menu bar App to **switch input sources** swiftly by shortcuts on `macOS 11 Big Sur or later`.")

            Divider()

            VStack(alignment: .leading) {
                ButtonInstructionView(buttonName: "About", shortcut: "⌘I", instruction: "Open this window.")
                ButtonInstructionView(buttonName: "Update", shortcut: "⌘U", instruction: "Update input sources and preserve shortcuts if you add or remove input sources.")
                ButtonInstructionView(buttonName: "Reset", shortcut: "⌘R", instruction: "Reset input sources and shortcuts. Use it when you change system language.")
                ButtonInstructionView(buttonName: "Quit", shortcut: "⌘Q", instruction: "Quit the app.")
            } // TODO: macOS 12 will support markdown format.

            Divider()

            VStack(alignment: .leading) {
                Button("View it on GitHub") {
                    openURL(URL(string: "https://github.com/Yang-Xijie/InputSourceSwitcher")!)
                }
                Button("Report a bug") {
                    openURL(URL(string: "https://github.com/Yang-Xijie/InputSourceSwitcher/issues")!)
                }

                HStack {
                    Button("Support") {
                        openURL(URL(string: "https://yang-xijie.github.io/postscript/support.html")!)
                    }
                    Text("WeChat Pay / Alipay")
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
    }
}

struct ButtonInstructionView: View {
    var buttonName: String = ""
    var shortcut: String = ""
    var instruction: String = ""

    var body: some View {
        HStack {
            Text("\(buttonName) \(shortcut)")
                .fontWeight(.bold)
            Text("-")
            Text(instruction)
        }
    }
}
