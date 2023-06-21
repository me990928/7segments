//
//  ContentView.swift
//  7segments
//
//  Created by Yuya Hirose on 2023/06/21.
//

import SwiftUI

struct SevenSegmentView: View {
    let isSegmentOn: Bool
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(isSegmentOn ? Color.red : Color.gray)
//            .frame(width: 20, height: 80)
         .frame(width: width, height: height)
    }
}

struct SevenSegmentSpotView: View{
    
    let digit: Int
    
    let segments: [[Bool]] = [
        [true, true, true, true, true, true, false],  // 0
        [false, true, true, false, false, false, false],  // 1
        [true, true, false, true, true, false, true],  // 2
        [true, true, true, true, false, false, true],  // 3
        [false, true, true, false, false, true, true],  // 4
        [true, false, true, true, false, true, true],  // 5
        [true, false, true, true, true, true, true],  // 6
        [true, true, true, false, false, true, false],  // 7
        [true, true, true, true, true, true, true],  // 8
        [true, true, true, true, false, true, true],  // 9
        // 他の数字のセグメント情報も追加
    ]
    
    var body: some View{
        VStack(spacing: 0){
            // a
            SevenSegmentView(isSegmentOn: segments[digit][0], width: 40, height: 10)
            HStack{
                // f
                SevenSegmentView(isSegmentOn: segments[digit][5], width: 10, height: 40)
                Spacer().frame(width: 40)
                // b
                SevenSegmentView(isSegmentOn: segments[digit][1], width: 10, height: 40)
            }
            // g
            SevenSegmentView(isSegmentOn: segments[digit][6], width: 40, height: 10)
            
            HStack(){
                // e
                SevenSegmentView(isSegmentOn: segments[digit][4], width: 10, height: 40)
                Spacer().frame(width: 40)
                // c
                SevenSegmentView(isSegmentOn: segments[digit][2], width: 10, height: 40)
            }
            // d
            SevenSegmentView(isSegmentOn: segments[digit][3], width: 40, height: 10)
            
        }
    }
}

class NowDateTimer:ObservableObject {
    @Published var h = Date()
    @Published var m = Date()
    @Published var s = Date()
    let dfh = DateFormatter()
    let dfm = DateFormatter()
    let dfs = DateFormatter()
    
    init() {
        dfh.dateFormat = "HH"
//        dfh.locale = Locale(identifier: "ja_jp")
        dfm.dateFormat = "mm"
//        dfm.locale = Locale(identifier: "ja_jp")
        dfs.dateFormat = "ss"
//        dfs.locale = Locale(identifier: "ja_jp")
    }
}

struct ContentView: View {
    @State var timer: Timer?
    @State var c1: Int = 0
    @ObservedObject var time = NowDateTimer()
    
    @State var a:Int = 0
    @State var b:Int = 0
    @State var c:Int = 0
    @State var d:Int = 0
    @State var e:Int = 0
    @State var f:Int = 0
    @State var g:Int = 0
    
    var body: some View {
        VStack{
            HStack(){
                SevenSegmentSpotView(digit: a)
                SevenSegmentSpotView(digit: b)
                Spacer().frame(width: 30)
                SevenSegmentSpotView(digit: c)
                SevenSegmentSpotView(digit: d)
                Spacer().frame(width: 30)
                SevenSegmentSpotView(digit: e)
                SevenSegmentSpotView(digit: f)
            }.onAppear{
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    self.time.h = Date()
                    self.time.m = Date()
                    self.time.s = Date()
                    
                    let hour:String = self.time.dfh.string(from: time.h)
                    let min = self.time.dfm.string(from: time.m)
                    let sec = self.time.dfs.string(from: time.s)
                    
                    let h1 = hour.index(hour.startIndex, offsetBy: 0)
                    let h2 = hour.index(hour.startIndex, offsetBy: 1)
                    let m1 = min.index(hour.startIndex, offsetBy: 0)
                    let m2 = min.index(hour.startIndex, offsetBy: 1)
                    let s1 = sec.index(hour.startIndex, offsetBy: 0)
                    let s2 = sec.index(hour.startIndex, offsetBy: 1)
                    
                    a = Int(String(hour[h1])) ?? 0
                    b = Int(String(hour[h2])) ?? 0
                    c = Int(String(min[m1])) ?? 0
                    d = Int(String(min[m2])) ?? 0
                    e = Int(String(sec[s1])) ?? 0
                    f = Int(String(sec[s2])) ?? 0
                    
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(time: NowDateTimer())
    }
}
