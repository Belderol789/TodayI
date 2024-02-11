//
//  FirebaseManager.swift
//  TodayI
//
//  Created by Kemuel Clyde Belderol on 1/23/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

class FirebaseManager: NSObject {

  static let shared = FirebaseManager()
  
  private let userID = "Kem"
  private let db = Firestore.firestore()
  private let storage = Storage.storage()
  private var storageReference: StorageReference {
    return storage.reference()
  }
  
  func uploadMemory(_ memory: Memory) {
    Task {
      do {
        try await db.collection("\(memory.year)").document(UUID().uuidString).setData([
          "userID": userID,
          "dateString": memory.dateString ?? "",
          "emotion": memory.emotion.rawValue,
          "journalEntry": memory.journalEntry ?? "",
          "media": memory.media ?? []
        ])
        print("Document successfully written!")
      } catch {
        print("Error writing document: \(error)")
      }
    }
  }
  
  
  func uploadImage(year: Int, with image: Data?, completion: @escaping (String?) -> Void) {
    
    print("Uploading \(image != nil)")
    
    guard let imageData = image else {
      completion(nil)
      return
    }
    let fileName = UUID().uuidString
    let storageRef = storage.reference(withPath: "/\(year)/memory_images/\(fileName)")
    storageRef.putData(imageData, metadata: nil) { (metadata, error) in
      if let error = error {
        print("Error uploading image to Firebase: \(error.localizedDescription)")
        return
      }
      print("Image successfully uploaded to Firebase!")
      storageRef.downloadURL { url, error in
        guard let imageUrl = url?.absoluteString else { return }
        completion(imageUrl)
      }
    }
  }
  
  func getAllMemories(for year: Int, completed: @escaping ([[String: Any]]) -> Void) {
    db.collection("\(year)").whereField("userID", isEqualTo: "Kem").getDocuments { snapshot, error in
      guard error == nil else { return }
      if let allDocumentData = snapshot?.documents.compactMap({$0.data()}) {
        completed(allDocumentData)
      }
    }
  }
  
  func delete(_ memory: Memory) {
    db.collection("\(memory.year)").whereField("dateString", isEqualTo: memory.date).getDocuments { snapshot, error in
      guard error == nil, let documents = snapshot?.documents, !documents.isEmpty else {
        print("Hello")
        return
      }
      for document in documents {
        document.reference.delete { err in
          print("Delete error \(err)")
        }
      }
    }
  }
}
