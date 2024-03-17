//
//  CommonMessageAPI.swift
//  SwiftDataSumpleApp
//
//  Created by TakahashiKotomi on 2024/01/03.
//

import SwiftUI

final class CommonMessageAPI {
    // 全ての要素を取得する
    func fetchAll(ofUserId: Int, completion: @escaping ([Message]?) -> Void) {}
    // 特定の何かを取得する
    func fetch(id: Int, completion: @escaping (Message?) -> Void) {}
    // テキストのメッセージを送信する
//    func sendTextMessage(text: String, completion: @escaping (TextMessage?) -> Void) {}
    // 画像メッセージを送信する
//    func sendImageMessage(image: UIImage, text: String?, completion: @escaping (ImageMessage?) -> Void) {}
}

/*
 メッセージの概念3つ
 - TextMassage
 - ImageMessage
 - OfficialMessage
 
 メッセージを送信するという債務を持っている。
 - メッセージ送信の元となる入力値を保持し、その値をサーバに送信する
 - 通信結果を保持し、delegateに結果を伝える
 
 良い抽象化 =「複雑な実装詳細が隠蔽されてシンプルなインターフェイスが提供されていること」
 どのプロパティに依存しているか、明確に示されていないと影響範囲が定まらない。
 
 */

enum MessageType: String, Codable {
    case text = "text"
    case image = "image"
    case official = "official"
}

protocol MessageSenderDelegate:class {
    func validではないことを伝える()
    func 通信完了を伝える()
}


final class MessageSender {
    private let api = CommonMessageAPI()
    let messageType: MessageType
    var delegate: MessageSenderDelegate?
    // MessageType.officialをセットするのは禁止!!
    init(messageType: MessageType) {
        self.messageType = messageType
    }
    // 送信するメッセージの入力値
    var text: String? {
        // TextMessage,ImageMessageどちらの場合も使う
        didSet {
            if self.isTextValid {
                delegate?.validではないことを伝える()
            }
        }
    }
    var image: UIImage? {
        // ImageMessageの場合に使う
        didSet {
            if !isImageValid {
                delegate?.validではないことを伝える()
            }
        }
    }
    // 通信結果
    private(set) var isLoading: Bool = false
    private(set) var result: Message? // 送信成功したら値が入る
    private var isTextValid: Bool {
        switch messageType {
        case .text: return text != nil && text!.count <= 300 // 300 字以内
        case .image: return text == nil || text!.count <= 80 // 80 字以内 or nil case .official: return false // OfficialMessageはありえない
        default: return false
        }
    }
    
    private var isImageValid: Bool {
        return image != nil // imageの場合だけ考慮する }
        var isValid: Bool {
            
            switch messageType {
            case .text: return isTextValid
            case .image: return isTextValid && isImageValid
            case .official: return false // OfficialMessageはありえない }
            }
            func send() {
                guard isValid else { delegate?.validではないことを伝える()
                }
                isLoading = true
                switch messageType {
                    
                case .text:
                    api.sendTextMessage(text: text!) { [weak self] in self?.isLoading = false
//                        self?.result = $0
                        self?.delegate?.通信完了を伝える ()
                    }
                case .image:
                    api.sendImageMessage(image: image!, text: text) {}
                case .official:
                    fatalError()
                }
            }
        }
    }
}
