import SwiftUI

struct AboutView: View {
    static let height = CGFloat(390)

    var body: some View {
        VStack(alignment: .leading) {
            IntroductionView()

            Divider()

            InstructionsView()

            Divider()

            ExternalLinksView()

            Divider()

            ReferecedOpenSourceProjectsView()
        }
        .padding()
        .frame(minHeight: AboutView.height)
    }

    struct IntroductionView: View {
        var body: some View {
            VStack(alignment: .leading) {
                Text("A menu bar app to switch input sources")
                Text("swiftly using shortcuts on")
                Text("macOS 11 Big Sur or later.")
                // TODO: macOS 12 will support markdown format.
            }
        }
    }

    struct InstructionsView: View {
        var body: some View {
            VStack(alignment: .leading) {
                SingleLineInstructionView(name: "About", shortcut: "⌘I", instruction: "Open this window.")
                SingleLineInstructionView(name: "Update", shortcut: "⌘U", instruction: "Update input sources and preserve shortcuts.")
                SingleLineInstructionView(name: "Reset", shortcut: "⌘R", instruction: "Reset input sources and shortcuts.")
                SingleLineInstructionView(name: "Quit", shortcut: "⌘Q", instruction: "Quit the app.")
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
    }

    struct ExternalLinksView: View {
        @Environment(\.openURL) var openURL
        var body: some View {
            VStack(alignment: .leading) {
                Text("Version \(appVersionString) (\(buildNumber))")

                Button("View it on GitHub") {
                    openURL(URL(string: "https://github.com/Yang-Xijie/InputSourceSwitcher")!)
                }

                Button("Report a bug") {
                    openURL(URL(string: "https://github.com/Yang-Xijie/InputSourceSwitcher/issues")!)
                }

                Button("Support") {
                    openURL(URL(string: "https://yang-xijie.github.io/postscript/support.html")!)
                }
            }
        }
    }

    struct ReferecedOpenSourceProjectsView: View {
        var body: some View {
            VStack(alignment: .leading) {
                Text("Referenced open source projects")

                OpenSourceProjectView(
                    projectName: "KeyboardShortcuts",
                    repositoryURL: "https://github.com/sindresorhus/KeyboardShortcuts",
                    licenseURL: "https://github.com/sindresorhus/KeyboardShortcuts/blob/main/license")
                OpenSourceProjectView(
                    projectName: "menubarpopoverswiftui2",
                    repositoryURL: "https://github.com/zaferarican/menubarpopoverswiftui2",
                    licenseURL: "https://github.com/zaferarican/menubarpopoverswiftui2/blob/master/LICENSE")
            }
        }

        struct OpenSourceProjectView: View {
            var projectName: String = ""
            var repositoryURL: String = ""
            var licenseURL: String = ""

            var body: some View {
                HStack {
                    Link(projectName,
                         destination: URL(string: repositoryURL)!)
                    Link("LICENSE",
                         destination: URL(string: licenseURL)!)
                }
            }
        }
    }
}
