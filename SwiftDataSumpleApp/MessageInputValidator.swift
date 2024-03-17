//
//  MessageInputValidator.swift
//  SwiftDataSumpleApp
//
//  Created by TakahashiKotomi on 2024/01/03.
//

import Foundation

struct MessageInputValidator {
    let messageType: MessageType
    let image: UIImage?
    let text: String?
    private var isValid: Bool {
        switch messageType {
        case .text:
        return isTextValid
        case .image:
        return isTextValid && isImageValid
        case .official:
        return false
        // OfficialMessageはありえない
        }
    }
    // 送信成功したら値が入る
    private var isTextValid: Bool {
        switch messageType {
        case .text:
        return text != nil && text!.count <= 300
            // 300字以内
        case .image:
        return text == nil || text!.count <= 80
            // 80字以内 or nil
        case .official:
        return false
            // OfficialMessageはありえない
        }
    }
    private var isImageValid: Bool {
        return image != nil
        // imageの場合だけ考慮する
    }
}
