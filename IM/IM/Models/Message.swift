import Foundation
import RxSwift

struct Message: Codable, Equatable {
    let id: String
    let content: String
    let senderId: String
    let senderName: String
    let timestamp: Date
    let isOutgoing: Bool
    
    init(id: String = UUID().uuidString, 
         content: String, 
         senderId: String, 
         senderName: String, 
         timestamp: Date = Date(), 
         isOutgoing: Bool) {
        self.id = id
        self.content = content
        self.senderId = senderId
        self.senderName = senderName
        self.timestamp = timestamp
        self.isOutgoing = isOutgoing
    }
} 