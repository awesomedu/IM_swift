//
//  ViewController.swift
//  IM
//
//  Created by cuna on 2025/4/30.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let enterChatButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("进入聊天", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "IM聊天演示"
        view.backgroundColor = .systemBackground
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(enterChatButton)
        
        enterChatButton.addTarget(self, action: #selector(enterChatButtonTapped), for: .touchUpInside)
        
        enterChatButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    @objc private func enterChatButtonTapped() {
        let chatViewController = ChatViewController()
        navigationController?.pushViewController(chatViewController, animated: true)
    }
}

