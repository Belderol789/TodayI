//
//  MainView.swift
//  TodayI
//
//  Created by Kemuel Clyde Belderol on 1/20/24.
//

import SwiftUI

struct MainView: View {
  
  @Binding var showTabbar: Bool
  @Environment(\.managedObjectContext) private var viewContext
  @FetchRequest(entity: Memory.entity(), sortDescriptors: []) var allMemories: FetchedResults<Memory>
  @StateObject var vm: MainViewModel = MainViewModel()
  
  var body: some View {
    NavigationStack {
      VStack {
        pickerView
        yearPicker
        dateMatrix
      }
      .padding()
      .onChange(of: allMemories.count, { oldValue, newValue in
        vm.loadLocalMemories(allMemories)
      })
      .onChange(of: vm.selectedYear) {
        vm.getAllMemories(allMemories: allMemories,
                          viewContext: viewContext)
        vm.updateTimelines()
      }
      .task {
        vm.getAllMemories(allMemories: allMemories,
                          viewContext: viewContext)
        vm.updateTimelines()
      }
    }
  }
}

// ----------------------------------
//  MARK: - Subviews -
//

extension MainView {
  
  private var pickerView: some View {
    Picker("Timelines", selection: $vm.selectedTimeline) {
      ForEach($vm.timelineTypes, id: \.self) { type in
        Text(type.wrappedValue.rawValue)
      }
    }
    .frame(height: 30)
    .pickerStyle(.segmented)
  }
  
  private var yearPicker: some View {
    Picker("Years", selection: $vm.selectedYear) {
      ForEach(2023...Date().year, id: \.self) { type in
        Text(verbatim: "\(type)")
      }
    }
    .tint(Color.primary)
  }
  
  private var dateMatrix: some View {
    GeometryReader(content: { geometry in
      ScrollView {
        ForEach(vm.selectedTimelines, id: \.self) { timeLine in
          MemoryGrid(memories: $vm.memories, 
                     vm: MemoryGridViewModel(geometry: geometry.size.width, 
                                             timeline: timeLine))
        }
      }
      .scrollIndicators(.hidden)
    })
  }
  
}

#Preview {
  MainView(showTabbar: .constant(true))
}
