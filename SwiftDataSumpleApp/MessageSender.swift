////
////  MessageSender.swift
////  SwiftDataSumpleApp
////
////  Created by TakahashiKotomi on 2024/01/03.
////
//
//import Foundation
//
//final class MessageSender {
//    private let api = CommonMessageAPI()
//    let messageType: MessageType
//    var delegate: MessageSenderDelegate?
//
//    // MessageType.officialをセットするのは禁止！！
//    init(messageType: MessageType) {
//        self.messageType = messageType
//    }
//
//    // 送信するメッセージの入力値
//    var text: String? {
//        // TextMessage,ImageMessageどちらの場合も使う
//        didSet {
//            if !isTextValid {
//                delegate?.validではないことを伝える()
//            }
//        }
//    }
//
//    var image: UIImage? {
//        // ImageMessageの場合に使う
//        didSet {
//            if !isImageValid {
//                delegate?.validではないことを伝える()
//            }
//        }
//    }
//
//    // 通信結果
//    private(set) var isLoading: Bool = false
//    private(set) var result: Message?
//
//    /*
//    - isValidには引数がありません。どういう条件でisValidが変化するのでしょうか。
//    - 依存しているプロパティは暗黙的で、コードを丹念に追わないと分かりません。
//
//    正直このレベルの複雑さを問題だとさえ思っていなかった節がある。
//    読めばわかるし、ノリでケースを増やすこともできそう。
//    */
//
//    /*
//    - SOLID原則
//    1. 単一責任原則 Single Responsibility Principle
//    • クラス（型）を変更する理由はふたつ以上存在してはならない
//    モジュール内での責務がまとまっている状態を、凝集度が高い状態と表現する。
//    開発のしやすさと再利用性はトレードオフ
//    バランスは、プロジェクトの時期・要件により流動する。
//    変更可能性のない責務を無意味に切り離すことは、「不必要な複雑さ」に結びつく恐れがある。
//    変更の理由は、必要性が生じた時に初めて「理由」になる。
//
//    確かに、今後メッセージ種別を増やそうって話になった時、どこで変更されるのかよくわからない messageType
//    に依存して isValid が変更されるのは困る。
//
//    似たような処理を行う部分を集めたモジュール。
//
//    > Message の種別ごとに必要なバリデーションロジックが違うなら、そもそもまとめて switch する必要がないのです。
//    ほんとに？
//
//
//    2.
//    */
//
//    func send() {
//        guard MessageInputValidator.isValid else {
//            delegate?.validではないことを伝える()
//        }
//
//        isLoading = true
//        switch messageType {
//        case .text:
//            api.sendTextMessage(text: text!) {
//                [weak self] in self?.isLoading = false self?.result = $0
//                self?.delegate?.通信完了を伝える()
//            }
//        case .image: api.sendImageMessage(image: image!, text: text)
//            { ... }
//        case .official:
//            fatalError()
//        }
//    }
//
//}
