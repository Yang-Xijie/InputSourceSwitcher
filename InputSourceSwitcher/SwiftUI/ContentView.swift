//
//  ContentView.swift
//  InputSourceSwitcher
//
//  Created by 杨希杰 on 2021/6/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var MyInputSources: InputSourcesModel

    var body: some View {
        VStack {
            // show switch buttons
            ForEach(MyInputSources.currentInputSources) { inputSource in
                HStack {
                    Text(inputSource.name)
                    Button("Switch To \(inputSource.name)") {
                        print("[UI] Button Switch To \(inputSource.name) Clicked!")
                        SwitchInputSource(to: inputSource.name)
                    }
                }
            }

            Spacer()

            HStack {
                // get input sources from menu bar
                Button("Reset") {
                    print("[UI] Button Reset Clicked!")
                    MyInputSources.Reset()
//                    currentInputSources = GetCurrentInputSourcesInMenubar()
                }

                Spacer()

                Button("Quit") {
                    print("[UI] Button Quit Clicked!")

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
