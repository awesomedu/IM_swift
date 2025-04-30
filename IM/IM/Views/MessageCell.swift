import UIKit
import SnapKit

class MessageCell: UITableViewCell {
    static let identifier = "MessageCell"
    
    // 消息气泡
    private let bubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    // 消息内容标签
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // 发送者名称标签
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)
        
        // 设置约束
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(16)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12))
        }
    }
    
    func configure(with message: Message) {
        messageLabel.text = message.content
        nameLabel.text = message.senderName
        
        // 根据消息类型设置不同的样式
        if message.isOutgoing {
            // 发出的消息显示在右侧
            bubbleView.backgroundColor = UIColor(red: 0, green: 0.5, blue: 1.0, alpha: 1.0)
            nameLabel.textAlignment = .right
            
            // 重新设置气泡位置
            bubbleView.snp.remakeConstraints { make in
                make.top.equalTo(nameLabel.snp.bottom).offset(4)
                make.trailing.equalToSuperview().offset(-16)
                make.leading.greaterThanOrEqualToSuperview().offset(80)
                make.bottom.equalToSuperview().offset(-8)
            }
        } else {
            // 收到的消息显示在左侧
            bubbleView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
            messageLabel.textColor = .black
            nameLabel.textAlignment = .left
            
            // 重新设置气泡位置
            bubbleView.snp.remakeConstraints { make in
                make.top.equalTo(nameLabel.snp.bottom).offset(4)
                make.leading.equalToSuperview().offset(16)
                make.trailing.lessThanOrEqualToSuperview().offset(-80)
                make.bottom.equalToSuperview().offset(-8)
            }
        }
    }
} 