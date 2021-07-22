import SwiftUI

struct AboutView: View {
    @Environment(\.openURL) var openURL
    let appVersionString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    let buildNumber: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String

    var body: some View {
        // TODO: macOS 12 will support markdown format.

        VStack(alignment: .leading) {
            Text("A menu bar app to switch input sources")
            Text("swiftly by shortcuts on macOS 11 Big Sur or later.")
            Text("Version \(appVersionString) (\(buildNumber))")

            Divider()

            VStack(alignment: .leading) {
                SingleLineInstructionView(name: "About", shortcut: "⌘I", instruction: "Open this window.")
                SingleLineInstructionView(name: "Update", shortcut: "⌘U", instruction: "Update input sources and preserve shortcuts.")
                SingleLineInstructionView(name: "Reset", shortcut: "⌘R", instruction: "Reset input sources and shortcuts.")
                SingleLineInstructionView(name: "Quit", shortcut: "⌘Q", instruction: "Quit the app.")
            }

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
//                    Text("WeChat Pay / Alipay")
                }
            }

            Divider()

            // Open Source Project
            Text("Referenced open source projects:")
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
        .frame(minHeight: 350)
    }
}

struct SingleLineInstructionView: View {
    var name: String = ""
    var shortcut: String = ""
    var instruction: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(name) \(shortcut)")
                .fontWeight(.bold)

            Text(instruction)
        }
    }
}
