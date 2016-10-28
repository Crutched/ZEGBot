//
//  Converting.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/30/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

import PerfectLib

protocol JSONConvertible {
	
	init?(from jsonConvertibleObject: Any?)
	
}

protocol ArrayConvertible {
	
	static func array(from jsonConvertibleObject: Any?) -> [Self]?
	
}

extension Update: JSONConvertible {
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let updateId = jsonDictionary[PARAM.UPDATE_ID] as? Int
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.updateId = updateId
		self.message = Message(from: jsonDictionary[PARAM.MESSAGE])
		self.editedMessage = Message(from: jsonDictionary[PARAM.EDITED_MESSAGE])
		
	}
	
}

extension Message {
	
	internal convenience init?(from jsonConvertibleObject: Any?) {
		
		self.init()
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let messageId = jsonDictionary[PARAM.MESSAGE_ID] as? Int,
			let date = jsonDictionary[PARAM.DATE] as? Int,
			let chat = Chat(from: jsonDictionary[PARAM.CHAT])
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.messageId = messageId
		self.date = date
		self.chat = chat
		self.from = User(from: jsonDictionary[PARAM.FROM])
		self.forwardFrom = User(from: jsonDictionary[PARAM.FORWARD_FROM])
		self.forwardFromChat = Chat(from: jsonDictionary[PARAM.FORWARD_FROM_CHAT])
		self.forwardDate = jsonDictionary[PARAM.FORWARD_DATE] as? Int
		self.replyToMessage = Message(from: jsonDictionary[PARAM.REPLY_TO_MESSAGE])
		self.editDate = jsonDictionary[PARAM.EDIT_DATE] as? Int
		self.text = jsonDictionary[PARAM.TEXT] as? String
		self.entities = MessageEntity.array(from: jsonDictionary[PARAM.ENTITIES])
		self.audio = Audio(from: jsonDictionary[PARAM.AUDIO])
		self.document = Document(from: jsonDictionary[PARAM.DOCUMENT])
		self.photo = PhotoSize.array(from: jsonDictionary[PARAM.PHOTO])
		self.sticker = Sticker(from: jsonDictionary[PARAM.STICKER])
		self.video = Video(from: jsonDictionary[PARAM.VIDEO])
		self.voice = Voice(from: jsonDictionary[PARAM.VOICE])
		self.caption = jsonDictionary[PARAM.CAPTION] as? String
		self.contact = Contact(from: jsonDictionary[PARAM.CONTACT])
		self.location = Location(from: jsonDictionary[PARAM.LOCATION])
		self.venue = Venue(from: jsonDictionary[PARAM.VENUE])
		self.newChatMember = User(from: jsonDictionary[PARAM.NEW_CHAT_MEMBER])
		self.leftChatMember = User(from: jsonDictionary[PARAM.LEFT_CHAT_MEMBER])
		self.newChatTitle = jsonDictionary[PARAM.NEW_CHAT_TITLE] as? String
		self.newChatPhoto = PhotoSize.array(from: jsonDictionary[PARAM.NEW_CHAT_PHOTO])
		self.deleteChatPhoto = jsonDictionary[PARAM.DELETE_CHAT_PHOTO] as? Bool
		self.groupChatCreated = jsonDictionary[PARAM.GROUP_CHAT_CREATED] as? Bool
		self.supergroupChatCreated = jsonDictionary[PARAM.SUPER_GROUP_CHAT_CREATED] as? Bool
		self.channelChatCreated = jsonDictionary[PARAM.CHANNEL_CHAT_CREATED] as? Bool
		self.migrateToChatId = jsonDictionary[PARAM.MIGRATE_TO_CHAT_ID] as? Int
		self.migrateFromChatId = jsonDictionary[PARAM.MIGRATE_FROM_CHAT_ID] as? Int
		self.pinnedMessage = Message(from: jsonDictionary[PARAM.PINNED_MESSAGE])
		
	}
	
}

extension Chat: JSONConvertible {
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let id = jsonDictionary[PARAM.ID] as? Int,
			let type = Chat.sType(from: jsonDictionary[PARAM.TYPE] as? String)
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.id = id
		self.type = type
		self.title = jsonDictionary[PARAM.TITLE] as? String
		self.username = jsonDictionary[PARAM.USERNAME] as? String
		self.firstName = jsonDictionary[PARAM.FIRST_NAME] as? String
		self.lastName = jsonDictionary[PARAM.LAST_NAME] as? String
		
	}
	
}

extension User: JSONConvertible {
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let id = jsonDictionary[PARAM.ID] as? Int,
			let firstName = jsonDictionary[PARAM.FIRST_NAME] as? String
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.id = id
		self.firstName = firstName
		self.lastName = jsonDictionary[PARAM.LAST_NAME] as? String
		self.username = jsonDictionary[PARAM.USERNAME] as? String
		
	}
	
}

extension MessageEntity: JSONConvertible, ArrayConvertible {
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let type = MessageEntity.sType(from: jsonDictionary[PARAM.TYPE] as? String),
			let offset = jsonDictionary[PARAM.OFFSET] as? Int,
			let length = jsonDictionary[PARAM.LENGTH] as? Int
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.type = type
		self.offset = offset
		self.length = length
		self.url = jsonDictionary[PARAM.URL] as? String
		self.user = User(from: jsonDictionary[PARAM.USER])
	}
	
	internal static func array(from jsonConvertibleObject: Any?) -> [MessageEntity]? {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonArray = jsonConvertibleObject as? [Any]
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		var messageEntities = [MessageEntity]()
		
		for jsonDictionaryObject in jsonArray {
			
			if let messageEntity = MessageEntity(from: jsonDictionaryObject) {
				
				messageEntities.append(messageEntity)
				
			}
			
		}
		
		return messageEntities
		
	}
	
}

extension Audio: JSONConvertible {
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let fileId = jsonDictionary[PARAM.FILE_ID] as? String,
			let duration = jsonDictionary[PARAM.DURATION] as? Int
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.fileId = fileId
		self.duration = duration
		self.performer = jsonDictionary[PARAM.PERFORMER] as? String
		self.title = jsonDictionary[PARAM.TITLE] as? String
		self.mimeType = jsonDictionary[PARAM.MIME_SIZE] as? String
		self.fileSize = jsonDictionary[PARAM.FILE_SIZE] as? Int
		
	}
	
}

extension Document: JSONConvertible {
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let fileId = jsonDictionary[PARAM.FILE_ID] as? String
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.fileId = fileId
		self.thumb = PhotoSize(from: jsonDictionary[PARAM.THUMB])
		self.fileName = jsonDictionary[PARAM.FILE_NAME] as? String
		self.mimeType = jsonDictionary[PARAM.MIME_TYPE] as? String
		self.fileSize = jsonDictionary[PARAM.FILE_SIZE] as? Int
		
	}
	
}

extension PhotoSize: JSONConvertible, ArrayConvertible {
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let fileId = jsonDictionary[PARAM.FILE_ID] as? String,
			let width = jsonDictionary[PARAM.WIDTH] as? Int,
			let height = jsonDictionary[PARAM.HEIGHT] as? Int
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.fileId = fileId
		self.width = width
		self.height = height
		self.fileSize = jsonDictionary[PARAM.FILE_SIZE] as? Int
		
	}
	
	internal static func array(from jsonConvertibleObject: Any?) -> [PhotoSize]? {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonArray = jsonConvertibleObject as? [Any]
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		var photoSizes = [PhotoSize]()
		
		for jsonDictionaryObject in jsonArray {
			
			if let photoSize = PhotoSize(from: jsonDictionaryObject) {
				
				photoSizes.append(photoSize)
				
			}
			
		}
		
		return photoSizes
		
	}
	
}

extension Sticker: JSONConvertible {
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let fileId = jsonDictionary[PARAM.FILE_ID] as? String,
			let width = jsonDictionary[PARAM.WIDTH] as? Int,
			let height = jsonDictionary[PARAM.HEIGHT] as? Int
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.fileId = fileId
		self.width = width
		self.height = height
		self.thumb = PhotoSize(from: jsonDictionary[PARAM.THUMB])
		self.emoji = jsonDictionary[PARAM.EMOJI] as? String
		self.fileSize = jsonDictionary[PARAM.FILE_SIZE] as? Int
		
	}
	
}

extension Video: JSONConvertible {
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let fileId = jsonDictionary[PARAM.FILE_ID] as? String,
			let width = jsonDictionary[PARAM.WIDTH] as? Int,
			let height = jsonDictionary[PARAM.HEIGHT] as? Int,
			let duration = jsonDictionary[PARAM.DURATION] as? Int
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.fileId = fileId
		self.width = width
		self.height = height
		self.duration = duration
		self.thumb = PhotoSize(from: jsonDictionary[PARAM.THUMB])
		self.mimeType = jsonDictionary[PARAM.MIME_TYPE] as? String
		self.fileSize = jsonDictionary[PARAM.FILE_SIZE] as? Int
		
	}
	
}

extension Voice: JSONConvertible {
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let fileId = jsonDictionary[PARAM.FILE_ID] as? String,
			let duration = jsonDictionary[PARAM.DURATION] as? Int
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.fileId = fileId
		self.duration = duration
		self.mimeType = jsonDictionary[PARAM.MIME_TYPE] as? String
		self.fileSize = jsonDictionary[PARAM.FILE_SIZE] as? Int
		
	}
	
}

extension Contact: JSONConvertible {
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let phoneNumber = jsonDictionary[PARAM.PHONE_NUMBER] as? String,
			let firstName = jsonDictionary[PARAM.FIRST_NAME] as? String
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.phoneNumber = phoneNumber
		self.firstName = firstName
		self.lastName = jsonDictionary[PARAM.LAST_NAME] as? String
		self.userId = jsonDictionary[PARAM.USER_ID] as? Int
		
	}
	
}

extension Location: JSONConvertible {
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let longitude = jsonDictionary[PARAM.LONGITUDE] as? Double,
			let latitude = jsonDictionary[PARAM.LATITUDE] as? Double
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.longitude = longitude
		self.latitude = latitude
		
	}
	
}

extension Venue: JSONConvertible {
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let location = Location(from: jsonDictionary[PARAM.LOCATION]),
			let title = jsonDictionary[PARAM.TITLE] as? String,
			let address = jsonDictionary[PARAM.ADDRESS] as? String
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.location = location
		self.title = title
		self.address = address
		self.foursquareId = jsonDictionary[PARAM.FOURSQUARE_ID] as? String
		
	}
}
