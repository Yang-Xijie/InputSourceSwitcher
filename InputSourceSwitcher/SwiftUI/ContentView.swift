//
//  ContentView.swift
//  InputSourceSwitcher
//
//  Created by 杨希杰 on 2021/6/22.
//

import SwiftUI

struct ContentView: View {
    @State var currentInputSources: [InputSource] = []

    var body: some View {
        VStack {
            // show switch buttons
            ForEach(currentInputSources) { inputSource in
                HStack {
                    Text(inputSource.name)
                    Button("Switch To \(inputSource.name)") {
                        print("[User Action] Button Switch To \(inputSource.name) Clicked!")
                        SwitchInputSource(to: inputSource.name)
                    }
                }
            }

            Spacer()

            HStack {
                // get input sources from menu bar
                Button("Reset") {
                    print("[User Action] Button Reset Clicked!")
                    currentInputSources = GetCurrentInputSourcesInMenubar()
                }

                Spacer()

                Button("Quit") {
                    print("[User Action] Button Quit Clicked!")

                    NSApplication.shared.terminate(self)
                }
            }
        }
        .padding()
        .frame(minWidth: 300, maxWidth: 600, minHeight: 200, maxHeight: 400)
    }
}

// struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
// }
