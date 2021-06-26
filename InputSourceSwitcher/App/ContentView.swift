import KeyboardShortcuts
import SwiftUI

// [ContentView]
struct ContentView: View {
    @ObservedObject var MyInputSources = InputSourcesModel()
    @State var isShowingAbout: Bool = true

    var body: some View {
        VStack {
            VStack {
                TopOptionView(MyInputSources: MyInputSources, isShowingAbout: $isShowingAbout)

                Divider()

                SwitcherView(MyInputSources: MyInputSources)
            }
            .frame(minHeight: 250)
            // FIXME: The `.frame()` modifier is not really intelligent... and the size of popover is not adjustable... I write it to fixed with 5 input sources and I'm not so sure that it works great with all resolutions.

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
