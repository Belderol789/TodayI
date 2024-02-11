//
//  ContentView.swift
//  TodayI
//
//  Created by Kemuel Clyde Belderol on 1/20/24.
//

import SwiftUI
import CoreData

struct MemoryGrid: View {
  
  @Binding var memories: [Memory]
  @StateObject var vm: MemoryGridViewModel
  
  var body: some View {
    VStack {
      headerTitle
      grid
    }
    .sheet(isPresented: $vm.goToCreate , content: {
      CreateView(showTabbar: .constant(false),
                 vm: CreateViewModel(selectedDate: vm.selectedDate))
    })
    .animation(.easeIn, value: memories)
    .sheet(isPresented: $vm.showDetail) {
      vm.showDetail = false
    } content: {
      DetailView(selectedMemory: $vm.selectedMemory)
    }
  }
}


// ----------------------------------
//  MARK: - Subviews -
//

extension MemoryGrid {
  

  private var headerTitle: some View {
    Text(vm.timeLine.title)
      .frame(maxWidth: .infinity, alignment: .leading)
      .font(.largeTitle)
      .fontWeight(.semibold)
  }
  
  private var grid: some View {
    LazyVGrid(columns: vm.columns, spacing: 12) {
      ForEach(vm.timeLine.dates, id: \.self) { date in
        let memory = vm.getMemory(memories: memories, for: date)
        let dateComponents = date.components(separatedBy: "/")
        let color = memory == nil ? Color(UIColor.secondarySystemFill) : memory?.emotion.color ?? .primary
        ZStack {
          RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(color)
          if vm.timeLine.type == .months {
            Text(dateComponents[1])
          } else {
            Text(dateComponents[1] + "/" + dateComponents[0])
          }
        }
        .onTapGesture(perform: {
          if let mem = memory {
            vm.selectedMemory = mem
            vm.showDetail = true
          } else {
            vm.selectedDate = date
            vm.goToCreate = true
          }
        })
        .shadow(color: color, radius: 3)
        .frame(width: vm.itemWidth, height: vm.itemWidth)
      }
    }
  }
}
