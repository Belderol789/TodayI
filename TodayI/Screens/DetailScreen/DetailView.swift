//
//  DetailView.swift
//  TodayI
//
//  Created by Kemuel Clyde Belderol on 1/20/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
  
  // ----------------------------------
  //  MARK: - Properties -
  //
  
  @Binding var selectedMemory: Memory
  @State var isDetail: Bool = true
  @Environment(\.presentationMode) var presentationMode

  // ----------------------------------
  //  MARK: - Computed -
  //
  
  var dateString: String {
    return selectedMemory.dateString ?? ""
  }
  var emotionColor: Color {
    return selectedMemory.emotion.color
  }
  var memoryImage: String {
    return selectedMemory.media?.first ?? ""
  }
  
  var body: some View {
    ZStack {
      background
      GeometryReader(content: { geometry in
        ScrollView {
          VStack(spacing: 20) {
            if isDetail {
              pullDown
                .padding(.vertical)
            }
            HStack {
              Spacer()
              menuButton
                .padding(.horizontal)
            }
            if selectedMemory.media?.first != nil {
              imageView
                .frame(maxWidth: .infinity)
                .background(Color(uiColor: .secondarySystemFill))
            }
            if let date = dateString.toDate()?.toStringWith(format: "MMMM d, yyyy") {
              Text(date)
                .font(.title3)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
            }
            contentView
            Text(selectedMemory.journalEntry ?? "")
              .textSelection(.enabled)
              .foregroundStyle(Color.white)
              .padding()
              .lineLimit(nil)
              .frame(
                minWidth: geometry.size.width,
                idealWidth: geometry.size.width,
                maxWidth: geometry.size.width,
                minHeight: geometry.size.height,
                idealHeight: geometry.size.height,
                maxHeight: .infinity,
                alignment: .topLeading)
              .background(Color(uiColor: .secondarySystemFill))
          }
        }
      })
    }
  }
}

// ----------------------------------
//  MARK: - Subviews -
//

extension DetailView {
  
  private var pullDown: some View {
    RoundedRectangle(cornerRadius: 10)
      .foregroundStyle(Color.primary)
      .frame(width: 80, height: 5)
  }
  
  private var background: some View {
    RadialGradient(colors: [
      emotionColor.opacity(0.3),
      emotionColor.opacity(0.6),
      emotionColor.opacity(0.9),
      emotionColor], center: .center, startRadius: 0, endRadius: 300)
    .frame(maxWidth: .infinity)
    .animation(.easeInOut(duration: 2), value: emotionColor)
    .brightness(-0.2)
    .ignoresSafeArea()
  }
  
  private var contentView: some View {
    VStack {
      Text("TodayI felt \(selectedMemory.emotion.name)")
        .underline()
        .font(.title2)
        .fontWeight(.bold)
        .foregroundStyle(Color.white)
        .shadow(color: Color.black.opacity(0.4), radius: 3, y: 3)
      Image(selectedMemory.emotion.image)
        .resizable()
        .frame(width: 50, height: 50)
        .foregroundStyle(Color.white)
        .shadow(color: Color.black.opacity(0.4), radius: 3, y: 3)
    }
  }
  
  private var imageView: some View {
    AnimatedImage(url: URL(string: memoryImage))
    // Supports options and context, like `.progressiveLoad` for progressive animation loading
      .onFailure { error in
        // Error
      }
      .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
      .placeholder {
        RoundedRectangle(cornerRadius: 15).foregroundStyle(Color(uiColor: .secondarySystemFill))
      }
      .indicator(SDWebImageActivityIndicator.large) // Activity Indicator
      .transition(.fade) // Fade Transition
      .scaledToFit() // Attention to call it on AnimatedImage, but not `some View` after View Modifier (Swift Protocol Extension method is static dispatched)
  }
  
  private var menuButton: some View {
    Menu {
      Button {
        MemoryManager.shared.deleteMemory(selectedMemory)
        presentationMode.wrappedValue.dismiss()
      } label: {
        Label("Delete Memory", systemImage: "minus.circle.fill")
      }
    } label: {
      Label("", systemImage: "ellipsis")
        .font(.title2)
        .fontWeight(.bold)
        .foregroundStyle(Color.white)
    }
  }
}
