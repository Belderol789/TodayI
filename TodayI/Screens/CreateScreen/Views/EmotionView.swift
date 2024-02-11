//
//  EmotionView.swift
//  TodayI
//
//  Created by Kemuel Clyde Belderol on 1/21/24.
//

import SwiftUI

struct EmotionView: View {
  
  @State private(set) var selectedEmotion: Double = 0.5
  @ObservedObject var vm: CreateViewModel
  
  var circlePadding: Double {
    return selectedEmotion == 1.0 ? 30 : 20
  }
  
  var body: some View {
    VStack(spacing: 30) {
      Text(vm.emotion.name)
        .font(.largeTitle)
        .fontWeight(.bold)
        .colorInvert()
        .animation(.spring, value: selectedEmotion)
        .shadow(color: Color.black.opacity(0.4), radius: 3, y: 3)
      
      Image(vm.emotion.image)
        .colorInvert()
        .shadow(color: Color.black.opacity(0.4), radius: 3, y: 3)
      
      GeometryReader(content: { geometry in
        ZStack(alignment: .leading) {
          LinearGradient(gradient: Gradient(colors: Emotion.allCases.compactMap({$0.color})), startPoint: .leading, endPoint: .trailing)
            .frame(height: 10)
            .shadow(color: Color.black.opacity(0.4), radius: 3, y: 3)
            .overlay {
              RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white.opacity(0.5), lineWidth: 1.0)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
          ZStack {
            Circle()
              .stroke(Color.white, lineWidth: 5.0)
              .foregroundStyle(Color.clear)
              .shadow(color: Color.black.opacity(0.4), radius: 3, y: 3)
          }
          .offset(x: CGFloat(selectedEmotion) * geometry.size.width - circlePadding)
          .gesture(
            DragGesture()
              .onChanged({ gesture in
                let dragValue = gesture.location.x / geometry.size.width
                selectedEmotion = min(max(Double(dragValue), 0), 1)
                vm.setEmotion(selectedEmotion)
              })
          )
        }
      })
      .padding(.horizontal, 20)
      .frame(width: 300, height: 50)
    }
  }
}
