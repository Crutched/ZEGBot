//
//  TypeExtension.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/30/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

/* Protocol. */
protocol Receivable {
	
	var params: [String: String] { get }
	
}

protocol ReplyMarkup {

	func JSONEncode() -> String?
	
}

/* Extension protocol. */
extension Chat: Receivable {
	
	var params: [String: String] { return ["chat_id": "\(self.id)"] }
	
}

extension Message: Receivable {
	
	var params: [String: String] { return ["chat_id": "\(self.chat.id)", "reply_to_message_id": "\(self.message_id)"] }
	
}

/* Support types. */
enum ParseMode: String {
	
	case Markdown
	case HTML
	
}


enum ChatAction: String {
	
	case typing
	case upload_photo
	case record_video
	case upload_video
	case record_audio
	case upload_audio
	case upload_document
	case find_location
	
}

extension InlineKeyboardMarkup: ReplyMarkup {
	
	func JSONEncode() -> String? {
		var JSONDictionary = [String: Any]()
		var buttonsArray = [[Any]]()
		for row in self.inline_keyboard {
			var rowArray = [Any]()
			for button in row {
				var buttonDictionary = [String: Any]()
				guard button.url != nil || button.callback_data != nil || button.switch_inline_query != nil else { continue }
				buttonDictionary["text"] = button.text
				if let url = button.url { buttonDictionary["url"] = url }
				if let callback_data = button.callback_data { buttonDictionary["callback_data"] = callback_data }
				if let switch_inline_query = button.switch_inline_query { buttonDictionary["switch_inline_query"] = switch_inline_query }
				rowArray.append(buttonDictionary)
			}
			buttonsArray.append(rowArray)
		}
		JSONDictionary["inline_keyboard"] = buttonsArray
		do {
			return try ZEGJSONEncoding(JSONDictionary)
		} catch {
			return nil
		}
	}
	
}