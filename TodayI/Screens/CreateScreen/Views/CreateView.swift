//
//  CreateView.swift
//  TodayI
//
//  Created by Kemuel Clyde Belderol on 1/20/24.
//

import SwiftUI
import PhotosUI

struct CreateView: View {
  
  // ----------------------------------
  //  MARK: - Properties -
  //
  
  @Binding var showTabbar: Bool
  @StateObject var vm: CreateViewModel = CreateViewModel()

  @Environment(\.colorScheme) var colorScheme
  @Environment(\.presentationMode) var presentationMode
  @Environment(\.managedObjectContext) private var viewContext
  
  // View specific properties
  @State var isLoading: Bool = false
  @FocusState private var focused: Bool
  
  
  var body: some View {
    ZStack {
      background
      VStack {
        journalizeButon
        GeometryReader { geometry in
          ScrollView {
            ScrollViewReader(content: { proxy in
              VStack(spacing: 20) {
                title
                EmotionView(vm: vm)
                  .frame(width: geometry.size.width - 40, height: 300)
                divider
                addMedia
                if vm.addText {
                  textView
                    .id(1)
                    .onChange(of: vm.textEntry, {
                      proxy.scrollTo(1, anchor: .bottom)
                    })
                }
                if vm.selectedImage != nil {
                  imageView
                }
              }
            })
          }
          .frame(height: geometry.size.height)
          .scrollIndicators(.never)
        }
      }
      
      if isLoading {
        ZStack {
          ProgressView()
            .progressViewStyle(.circular)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5))
      }
      
    }
    .onTapGesture {
      hideKeyboard()
    }
    .adaptsToKeyboard()
    .onChange(of: vm.photoPickerItems, {
      vm.getPickerImage()
    })
    .photosPicker(isPresented: $vm.addImage, selection: $vm.photoPickerItems, maxSelectionCount: 1, matching: .images)
  }
}


// ----------------------------------
//  MARK: - Subview -
//

extension CreateView {
  
  private var journalizeButon: some View {
    HStack {
      Text(vm.currentDate)
        .colorInvert()
      Spacer()
      Button("Journalize", systemImage: "pencil.and.scribble", action: {
        // Send to Firebase
        isLoading = true
        focused = false
        let memory = Memory(context: viewContext)
        vm.updateMemory(memory)
        vm.sendJournalEntry(newMemory: memory) {
          MemoryManager.shared.save()
          isLoading = false
          presentationMode.wrappedValue.dismiss() // For when this view is shown as a sheet
        }
      })
      .foregroundStyle(.primary.opacity(0.8))
      .tint(colorScheme == .dark ? .black.opacity(0.8) : .white)
      .buttonStyle(.borderedProminent)
      .controlSize(.small)
    }
    .shadow(color: Color.black.opacity(0.6), radius: 3, y: 3)
    .padding()
  }
  
  private var title: some View {
    Text("TodayI felt...")
      .font(.title2)
      .fontWeight(.semibold)
      .foregroundStyle(.primary)
      .colorInvert()
    
  }
  
  private var background: some View {
    RadialGradient(colors: [
      vm.emotionColor.opacity(0.3),
      vm.emotionColor.opacity(0.6),
      vm.emotionColor.opacity(0.9),
      vm.emotionColor], center: .center, startRadius: 0, endRadius: 300)
    .frame(maxWidth: .infinity)
    .animation(.easeIn, value: vm.emotionColor)
    .brightness(-0.1)
    .ignoresSafeArea()
  }
  
  private var divider: some View {
    Rectangle()
      .foregroundStyle(Color.white)
      .frame(height: 1)
  }
  
  private var addMedia: some View {
    HStack {
      Button("Add Text", systemImage: "text.badge.plus", action: {
        vm.addText.toggle()
        focused = true
      })
      .foregroundStyle(.primary.opacity(vm.addText ? 0.4 : 0.8))
      .buttonStyle(.borderedProminent)
      .tint(colorScheme == .dark ? .black.opacity(0.8) : .white)
      .controlSize(.regular)
      Button("Add Image", systemImage: "photo.badge.plus", action: {
        focused = false
        vm.addImage.toggle()
      })
      .foregroundStyle(.primary.opacity(vm.selectedImage != nil ? 0.4 : 0.8))
      .buttonStyle(.borderedProminent)
      .tint(colorScheme == .dark ? .black.opacity(0.8) : .white)
      .controlSize(.regular)
      Spacer()
    }
    .padding()
    .shadow(color: Color.black.opacity(0.4), radius: 3, y: 3)
  }
  
  private var textView: some View {
    VStack {
      Text("Write about today")
        .frame(maxWidth: .infinity, alignment: .leading)
        .fontWeight(.semibold)
        .font(.title3)
        .underline()
        .colorInvert()
        .shadow(color: Color.black.opacity(0.6), radius: 3, y: 3)
      
      TextField("TodayI", text: $vm.textEntry,  axis: .vertical)
        .foregroundStyle(.black.opacity(0.8))
        .padding()
        .foregroundStyle(.primary)
        .focused($focused)
        .font(.title3)
        .background(
          Color.white.opacity(0.5)
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
    .padding()
  }
  
  private var imageView: some View {
    VStack {
      Text("Today's photo memory is...")
        .frame(maxWidth: .infinity, alignment: .leading)
        .colorInvert()
        .fontWeight(.semibold)
        .font(.title3)
        .underline()
      
      if let image = vm.selectedImage {
        ZStack(alignment: .topTrailing) {
          image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay {
              RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white, lineWidth: 2.0)
                .background(Color.clear)
                .frame(height: 250)
            }
          Button {
            vm.photoPickerItems.removeAll()
            vm.selectedImage = nil
          } label: {
            Image(systemName: "xmark.circle.fill")
              .resizable()
              .foregroundStyle(Color.red)
              .clipShape(Circle())
          }
          .frame(width: 25, height: 25)
          .padding()
        }
      }
    }
    .padding()
    .shadow(color: Color.black.opacity(0.6), radius: 3, y: 3)
  }
}
