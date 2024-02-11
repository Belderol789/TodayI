//
//  CreateViewModel.swift
//  TodayI
//
//  Created by Kemuel Clyde Belderol on 1/26/24.
//

import CoreData
import SwiftUI
import PhotosUI

class CreateViewModel: ObservableObject {
  @Published var emotion: Emotion = .Happy
  @Published var uiImage: UIImage?
  
  @Published var textEntry: String = "TodayI"
  @Published var photoPickerItems = [PhotosPickerItem]()
  @Published var selectedImage: Image?
  
  @Published var addText: Bool = false
  @Published var addImage: Bool = false
  
  @Published var selectedDate: String = Date().toString()
  @Published var viewHeight: CGFloat = 0
  
  var emotionColor: Color {
    return emotion.color
  }
  
  var currentYear: Int {
    return Int("20" + (selectedDate.components(separatedBy: "/")[2])) ?? Date().year
  }
  
  var currentDate: String {
    return (selectedDate.toDate()?.toStringWith(format: "MMMM d, yyyy") ?? Date().toString())
  }
  
  
  init(selectedDate: String = Date().toString()) {
    self.selectedDate = selectedDate
  }
  
  func getPickerImage() {
    Task {
      guard let firstItem = photoPickerItems.first else { return }
      selectedImage = nil
      do {
        if let data = try await firstItem.loadTransferable(type: Data.self) {
          if let uiimage = UIImage(data: data) {
            uiImage = uiimage
            selectedImage = Image(uiImage: uiimage)
          }
        }
      } catch {
        print("Error: \(error.localizedDescription)")
      }
    }
  }
  
  func sendJournalEntry(newMemory: Memory, sent: @escaping () -> Void) {
    FirebaseManager.shared.uploadImage(year: currentYear, with: uiImage?.pngData()) { imageURL in
      if let image = imageURL {
        newMemory.media = [image]
      }
      sent()
      FirebaseManager.shared.uploadMemory(newMemory)
    }
  }
  
  func updateMemory(_ memory: Memory) {
    memory.emotionInt = Int16(self.emotion.rawValue)
    memory.dateString = self.selectedDate
    memory.journalEntry = self.textEntry
    memory.id = Date().toString()
    memory.firstImage = self.uiImage?.pngData()
  }
  
  
  func setEmotion(_ selectedEmotion: Double) {
    switch selectedEmotion {
    case 0..<0.2:
      emotion = .Angry
    case 0.2..<0.4:
      emotion = .Disgust
    case 0.4..<0.6:
      emotion = .Happy
    case 0.6..<0.8:
      emotion = .Sad
    case 0.8..<1.0:
      emotion = .Worried
    default:
      emotion = .Fine
    }
  }
  
}
