//
//  RandomScreen.swift
//  TodayI
//
//  Created by Kemuel Clyde Belderol on 1/26/24.
//

import SwiftUI

struct RandomView: View {
  
  @FetchRequest(entity: Memory.entity(), sortDescriptors: []) var allMemories: FetchedResults<Memory>
  @StateObject var vm: RandomViewModel = RandomViewModel()
  @Binding var showTabbar: Bool
  
  var body: some View {
    ZStack {
      VStack {
        if let randomMemory = vm.randomMemory {
          DetailView(selectedMemory: .constant(randomMemory), isDetail: false)
        } else {
          Spacer()
          Text(vm.emptyText)
          Spacer()
        }
        filterView
      }
    }
    .padding(.bottom, 60)
  }
}


// ----------------------------------
//  MARK: - Subviews -
//

extension RandomView {
  
  private var filterView: some View {
    HStack {
      Button(action: {
        if vm.selectedEmotion == "All", !allMemories.isEmpty {
          vm.emptyText = ""
          vm.randomMemory = allMemories[Int.random(in: 0..<allMemories.count)]
        } else {
          let filteredMemory = allMemories.filter({$0.emotion.name == vm.selectedEmotion})
          guard !filteredMemory.isEmpty else {
            vm.emptyText = "No memory available"
            vm.randomMemory = nil
            return
          }
          vm.emptyText = ""
          vm.randomMemory = filteredMemory[Int.random(in: 0..<filteredMemory.count)]
        }
      }, label: {
        Text("Random Memory")
          .foregroundStyle(Color.primary)
          .padding()
          .background(Color(uiColor: .secondarySystemFill))
          .clipShape(RoundedRectangle(cornerRadius: 15))
      })
      .shadow(color: Color.black.opacity(0.6), radius: 3, y: 3)
      Picker("Emotions", selection: $vm.selectedEmotion) {
        ForEach(vm.emotionNames, id: \.self) { type in
          Text(verbatim: "\(type)")
            .font(.headline)
            .fontWeight(.bold)
        }
      }
      .tint(vm.selectedColor)
    }
  }
  
  private var background: some View {
    RadialGradient(colors: [
      vm.emotionColor.opacity(0.3),
      vm.emotionColor.opacity(0.6),
      vm.emotionColor.opacity(0.9),
      vm.emotionColor], center: .center, startRadius: 0, endRadius: 300)
    .frame(maxWidth: .infinity)
    .animation(.easeInOut(duration: 2), value: vm.randomMemory)
    .brightness(-0.1)
    .ignoresSafeArea()
  }
}
