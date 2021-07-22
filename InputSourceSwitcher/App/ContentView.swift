import KeyboardShortcuts
import SwiftUI

// [ContentView]
struct ContentView: View {
    @ObservedObject var MyInputSources = InputSourcesModel()

    // Show About if user open the app for the first time or update the app.
    @State var isShowingAbout: Bool = UserDefaults.isFirstLaunchOfNewVersion() ? true : false

    var body: some View {
        let frameHeight: CGFloat = CGFloat(100) + CGFloat(MyInputSources.inputSources.count * 30) // This formula is revived from experiments on MacBook Pro 13', whose display is scaled at 1680 * 1050.

        VStack(alignment: .center) {
            VStack {
                TopOptionView(MyInputSources: MyInputSources, isShowingAbout: $isShowingAbout)

                Divider()

                SwitcherView(MyInputSources: MyInputSources)
            }
            .frame(minHeight: frameHeight)

            if isShowingAbout {
                AboutView()
            }
        }
        .padding()
    }
}

struct TopOptionView: View {
    @ObservedObject var MyInputSources: InputSourcesModel
    @Binding var isShowingAbout: Bool

    @Environment(\.openURL) var openURL

    var body: some View {
        HStack {
            Button(isShowingAbout ? "Hide About" : "About") {
                print(Time() + "[Button] About clicked")

                isShowingAbout.toggle()
            }
            .padding(.trailing)
            .keyboardShortcut("i", modifiers: .command)

            Button("Update") {
                print(Time() + "[Button] Update clicked")

                // get new InputSources from system and save KeyboardShortcuts at the same time
                withAnimation {
                    MyInputSources.Update()
                }
            }

            .keyboardShortcut("u", modifiers: .command)

            Button("Reset") {
                print(Time() + "[Button] Reset clicked")

                // reset KeyboardShortcuts and InputSources
                withAnimation {
                    MyInputSources.Reset()
                }
            }

            .keyboardShortcut("r", modifiers: .command)

            Button("Quit") {
                print(Time() + "[Button] Quit clicked")
                NSApplication.shared.terminate(self) // quit app == cmd Q
            }
            .keyboardShortcut("q", modifiers: .command)
            .padding(.leading)
        }
        .padding()
    }
}

struct SwitcherView: View {
    @ObservedObject var MyInputSources: InputSourcesModel

    var body: some View {
        // Use right alignment to put `record shortcut` who are all the same size to make SwitcherView orderly
        VStack(alignment: .trailing) {
            ForEach(MyInputSources.inputSources) { inputSource in
                HStack {
                    Button("Switch to \(inputSource.name)") {
                        print(Time() + "[Button] Switch to \(inputSource.name) Clicked")

                        MyInputSources.SwitchInputSource(to: inputSource.name)
                    }

                    KeyboardShortcuts.Recorder(for: KeyboardShortcuts.Name(inputSource.name))
                        .onAppear {
                            KeyboardShortcuts.onKeyDown(for: KeyboardShortcuts.Name(inputSource.name)) {
                                print(Time() + "[KeyboardShortcuts] shortcut of \(inputSource.name) down")

                                MyInputSources.SwitchInputSource(to: inputSource.name)
                            }
                        }
                }
            }
        }
        .padding()
    }
}
