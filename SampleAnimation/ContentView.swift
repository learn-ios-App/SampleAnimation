//
//  ContentView.swift
//  SampleAnimation
//
//  Created by 渡邊魁優 on 2023/05/10.
//

import SwiftUI

enum SpinningMethods {
    case none
    case vertical
    case lateral
}

//常に止まっている縁を描くView
struct ResetEllipse: View {
    var body: some View {
        Rectangle()
            .frame(width: 200, height: 300)
            .foregroundColor(.orange)
    }
}

//常に横回転している円を描くView
struct SpinningLateral: View {
    @State private var width: CGFloat = 200
    
    var body: some View {
        Rectangle()
            .frame(width: width, height: 300)
            .foregroundColor(.orange)
            .onAppear {
                withAnimation(.easeInOut.repeatForever().speed(0.4)) {
                    width = 0
                }
            }
    }
}

//常に縦回転している円を描くView
struct SpinningVertical: View {
    @State private var height: CGFloat = 300
    
    var body: some View {
        Rectangle()
            .frame(width: 200, height: height)
            .foregroundColor(.orange)
            .onAppear {
                withAnimation(.easeInOut.repeatForever(autoreverses: true).speed(0.4)) {
                    height = 0
                }
            }
    }
}

//isSpinningの値によってViewを切り替える
struct SpinningView: View {
    @State private var spinningMethod: SpinningMethods = SpinningMethods.none
    
    var body: some View {
        VStack {
            
            Spacer()
            
            switch spinningMethod {
            case .none:
                ResetEllipse()
            case .vertical:
                SpinningVertical()
            case .lateral:
                SpinningLateral()
            }
            
            Spacer()
            
            HStack(spacing: 40) {
                Button(action: {
                    spinningMethod = SpinningMethods.none
                }) {
                    Text("止める")
                }
                Button(action: {
                    spinningMethod = SpinningMethods.vertical
                }) {
                    Text("縦回転")
                }
                Button(action: {
                    spinningMethod = SpinningMethods.lateral
                }) {
                    Text("横回転")
                }
            }
        }
    }
}

struct SpinningView_Previews: PreviewProvider {
    static var previews: some View {
        SpinningView()
    }
}
