import Foundation
import RxSwift
import RxCocoa

class MockSocketService {
    // 使用PublishSubject发送消息
    private let messageSubject = PublishSubject<Message>()
    
    // 对外暴露为Observable
    var messageObservable: Observable<Message> {
        return messageSubject.asObservable()
    }
    
    private var timer: Timer?
    private let currentUserId = "current_user"
    private let otherUserIds = ["user1", "user2", "user3"]
    private let otherUserNames = ["张三", "李四", "王五"]
    
    private let mockMessages = [
        "你好啊！",
        "最近工作怎么样？",
        "周末有什么计划吗？",
        "我们明天开会，别忘了。",
        "这个项目进展如何？",
        "需要我帮忙吗？",
        "晚上一起吃饭？",
        "文档已经发你邮箱了。",
        "谢谢你的帮助！",
        "我稍后回复你。"
    ]
    
    func connect() {
        print("Socket服务已连接")
        
        // 模拟每隔几秒收到一条消息
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            self?.simulateIncomingMessage()
        }
    }
    
    func disconnect() {
        timer?.invalidate()
        timer = nil
        print("Socket服务已断开")
    }
    
    func sendMessage(_ content: String) -> Message {
        // 创建一条发出的消息
        let message = Message(
            content: content,
            senderId: currentUserId,
            senderName: "我",
            isOutgoing: true
        )
        
        // 在实际应用中，这里会将消息发送到服务器
        print("发送消息: \(content)")
        
        return message
    }
    
    private func simulateIncomingMessage() {
        // 随机选择一个用户和一条消息
        let randomUserIndex = Int.random(in: 0..<otherUserIds.count)
        let randomMessageIndex = Int.random(in: 0..<mockMessages.count)
        
        let senderId = otherUserIds[randomUserIndex]
        let senderName = otherUserNames[randomUserIndex]
        let content = mockMessages[randomMessageIndex]
        
        let message = Message(
            content: content,
            senderId: senderId,
            senderName: senderName,
            isOutgoing: false
        )
        
        // 通过Subject发送消息
        messageSubject.onNext(message)
    }
} 