import Foundation
import RxSwift
import RxCocoa

class ChatViewModel {
    private let socketService = MockSocketService()
    private let disposeBag = DisposeBag()
    
    // 使用BehaviorRelay管理消息列表
    private let messagesRelay = BehaviorRelay<[Message]>(value: [])
    
    // 对外暴露只读Observable
    var messages: Observable<[Message]> {
        return messagesRelay.asObservable()
    }
    
    init() {
        // 订阅socket服务的消息
        socketService.messageObservable
            .subscribe(onNext: { [weak self] message in
                self?.addMessage(message)
            })
            .disposed(by: disposeBag)
    }
    
    func connect() {
        socketService.connect()
    }
    
    func disconnect() {
        socketService.disconnect()
    }
    
    func sendMessage(content: String) {
        guard !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let message = socketService.sendMessage(content)
        addMessage(message)
    }
    
    private func addMessage(_ message: Message) {
        // 获取当前消息数组
        var currentMessages = messagesRelay.value
        // 添加新消息
        currentMessages.append(message)
        // 更新relay
        messagesRelay.accept(currentMessages)
    }
    
    // 为UITableView提供便利方法
    func numberOfMessages() -> Int {
        return messagesRelay.value.count
    }
    
    func message(at index: Int) -> Message {
        return messagesRelay.value[index]
    }
} 