//
//  ContentView.swift
//  InputSourceSwitcher
//
//  Created by 杨希杰 on 2021/6/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
            Button("ToggleDarkMode") {
                print("Button ToggleDarkMode Clicked!")
                ToggleDarkMode()
            }
            Button("SwitchToHiragana") {
                print("Button SwitchToHiragana Clicked!")
                SwitchInputSource(to: "Hiragana")
            }
            Button("SwitchToABC") {
                print("Button SwitchToHiragana Clicked!")
                SwitchInputSource(to: "ABC")
            }
            Button("SwitchToPinyinSimplified") {
                print("Button SwitchToHiragana Clicked!")
                SwitchInputSource(to: "Pinyin - Simplified")
            }
        }
        .padding()
        .frame(minWidth: 240, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)

//        GeometryReader { geometry in
//            VStack {
//                Text("\(geometry.size.width) x \(geometry.size.height)")
//            }.frame(width: geometry.size.width, height: geometry.size.height)
//        }
    }
}

// struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
// }
