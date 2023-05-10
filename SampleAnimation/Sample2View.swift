//
//  Sample2View.swift
//  SampleAnimation
//
//  Created by 渡邊魁優 on 2023/05/11.
//

import SwiftUI

struct Flip<Front: View, Back: View>: View {
    var isFront: Bool
    @State var canShowFrontView: Bool
    let duration: Double
    let front: () -> Front
    let back: () -> Back

    init(isFront: Bool,
         duration: Double = 1.0,
         @ViewBuilder front: @escaping () -> Front,
         @ViewBuilder back: @escaping () -> Back) {
        self.isFront = isFront
        self._canShowFrontView = State(initialValue: isFront)
        self.duration = duration
        self.front = front
        self.back = back
    }

    var body: some View {
        ZStack {
            if self.canShowFrontView {
                front()
            }
            else {
                back()
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
            }
        }
        .onChange(of: isFront, perform: {
            value in
            DispatchQueue.main.asyncAfter(deadline: .now() + duration/2.0) {
                self.canShowFrontView = value
            }
        })
        .animation(nil)
        .rotation3DEffect(isFront ? Angle(degrees: 0): Angle(degrees: 180), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
        .animation(.easeInOut(duration: duration))
    }
}

struct Sample2View: View {
    @State var isFront = true
    
    var body: some View {
        VStack {
            Flip(isFront: isFront, // 先に作っておいた変数 isFront
                 front: {
                Image("H1") // 表面 ハートのA
            },
                 back: {
                Image("Back") // カード裏面
            })
            Spacer()
            Button(action: {
                isFront.toggle()
            }) {
                Text("SS")
            }
        }
        
        
    }
}

struct Sample2View_Previews: PreviewProvider {
    static var previews: some View {
        Sample2View()
    }
}
