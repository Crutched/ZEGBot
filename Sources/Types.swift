//
//  Types.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/30/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

public struct Update {
	
	public var updateId: Int
	
	/* Optional. */
	public var message: Message?
	public var editedMessage: Message?
	//	public var inlineQuery: InlineQuery?
	//	public var chosenInlineResult: ChosenInlineResult?
	//	public var callbackQuery: CallbackQuery?
	
}


public class Message {
	
	public var messageId: Int
	public var date: Int
	public var chat: Chat
	
	/* Optional. */
	public var from: User?
	public var forwardFrom: User?
	public var forwardFromChat: Chat?
	public var forwardDate: Int?
	public var replyToMessage: Message?
	public var editDate: Int?
	public var text: String?
	public var entities: [MessageEntity]?
	public var audio: Audio?
	public var document: Document?
	public var photo: [PhotoSize]?
	public var sticker: Sticker?
	public var video: Video?
	public var voice: Voice?
	public var caption: String?
	public var contact: Contact?
	public var location: Location?
	public var venue: Venue?
	public var newChatMember: User?
	public var leftChatMember: User?
	public var newChatTitle: String?
	public var newChatPhoto: [PhotoSize]?
	public var deleteChatPhoto: Bool?
	public var groupChatCreated: Bool?
	public var supergroupChatCreated: Bool?
	public var channelChatCreated: Bool?
	public var migrateToChatId: Int?
	public var migrateFromChatId: Int?
	public var pinnedMessage: Message?
	
	public init() {
		self.messageId = 0
		self.date = 0
		self.chat = Chat(id: 0, type: .PRIVATE)
	}
	
}


public struct Chat {
	
	public var id: Int
	public var type: sType
	
	/* Optional. */
	public var title: String?
	public var username: String?
	public var firstName: String?
	public var lastName: String?
	
	public init(id: Int, type: sType) {
		
		self.id = id
		self.type = type
		
	}
	
	public enum sType: String {
		
		public init?(from string: String?) {
			guard let typeString = string else { return nil }
			guard let instance = sType(rawValue: typeString.uppercased()) else { return nil }
			self = instance
		}
		
		case PRIVATE, GROUP, SUPERGROUP, CHANNEL
	}
	
}


public struct User {
	
	public var id: Int
	public var firstName: String
	
	/* OPTIONAL. */
	public var lastName: String?
	public var username: String?
	
	public init(id: Int,
	            firstName: String,
	            lastName: String? = nil,
	            username: String? = nil
		) {
		
		self.id = id
		self.firstName = firstName
		self.lastName = lastName
		self.username = username
		
	}
	
}


public struct MessageEntity {
	
	public var type: sType
	public var offset: Int
	public var length: Int
	
	/* OPTIONAl. */
	public var url: String?
	public var user: User?
	
	public enum sType: String {
		public init?(from string: String?) {
			guard let typeString = string else { return nil }
			guard let instance = sType(rawValue: typeString.uppercased()) else { return nil }
			self = instance
		}
		
		case MENTION, HASHTAG, BOTCOMMAND, URL, EMAIL, BOLD, ITALIC, CODE, PRE, TEXTLINK, TEXTMENTION
		
	}
	
}


public struct Audio {
	
	public var fileId: String
	public var duration: Int
	
	/* OPTIONAL. */
	public var performer: String?
	public var title: String?
	public var mimeType: String?
	public var fileSize: Int?
	
	public init(fileId: String,
	            duration: Int,
	            performer: String? = nil,
	            title: String? = nil,
	            mimeType: String? = nil,
	            fileSize: Int? = nil
		) {
		
		self.fileId = fileId
		self.duration = duration
		self.performer = performer
		self.title = title
		self.mimeType = mimeType
		self.fileSize = fileSize
		
	}
	
}


public struct Document {
	
	public var fileId: String
	
	/* OPTIONAL. */
	public var thumb: PhotoSize?
	public var fileName: String?
	public var mimeType: String?
	public var fileSize: Int?
	
	public init(fileId: String,
	            thumb: PhotoSize? = nil,
	            fileName: String? = nil,
	            mimeType: String? = nil,
	            fileSize: Int? = nil
		) {
		
		self.fileId = fileId
		self.thumb = thumb
		self.fileName = fileName
		self.mimeType = mimeType
		self.fileSize = fileSize
		
	}
	
}


public struct PhotoSize {
	
	public var fileId: String
	public var width: Int
	public var height: Int
	
	/* Optional. */
	public var fileSize: Int?
	
	public init(fileId: String,
	            width: Int,
	            height: Int,
	            fileSize: Int? = nil
		){
		
		self.fileId = fileId
		self.width = width
		self.height = height
		self.fileSize = fileSize
		
	}
	
}


public struct Sticker {
	
	public var fileId: String
	public var width: Int
	public var height: Int
	
	/* Optional. */
	public var thumb: PhotoSize?
	public var emoji: String?
	public var fileSize: Int?
	
	public init(fileId: String,
	            width: Int,
	            height: Int,
	            thumb: PhotoSize? = nil,
	            emoji: String? = nil,
	            fileSize: Int? = nil
		) {
		
		self.fileId = fileId
		self.width = width
		self.height = height
		self.thumb = thumb
		self.emoji = emoji
		self.fileSize = fileSize
		
	}
	
}


public struct Video {
	
	public var fileId: String
	public var width: Int
	public var height: Int
	public var duration: Int
	
	/* OPTIONAL. */
	public var thumb: PhotoSize?
	public var mimeType: String?
	public var fileSize: Int?
	
	public init(fileId: String,
	            width: Int,
	            height: Int,
	            duration: Int,
	            thumb: PhotoSize? = nil,
	            mimeType: String? = nil,
	            fileSize: Int? = nil
		){
		
		self.fileId = fileId
		self.width = width
		self.height = height
		self.duration = duration
		self.thumb = thumb
		self.mimeType = mimeType
		self.fileSize = fileSize
		
	}
	
}


public struct Voice {
	
	public var fileId: String
	public var duration: Int
	
	/* Optional. */
	public var mimeType: String?
	public var fileSize: Int?
	
	public init(fileId: String,
	            duration: Int,
	            mimeType: String? = nil,
	            fileSize: Int? = nil
		) {
		
		self.fileId = fileId
		self.duration = duration
		self.mimeType = mimeType
		self.fileSize = fileSize
		
	}
	
}


public struct Contact {
	
	public var phoneNumber: String
	public var firstName: String
	
	/* OPTIONAL. */
	public var lastName: String?
	public var userId: Int?
	
	public init(phoneNumber: String,
	            firstName: String,
	            lastName: String? = nil,
	            userId: Int? = nil
		) {
		
		self.phoneNumber = phoneNumber
		self.firstName = firstName
		self.lastName = lastName
		self.userId = userId
		
	}
	
}


public struct Location {
	
	public var longitude: Double
	public var latitude: Double
	
	public init(longitude: Double,
	            latitude: Double
		) {
		
		self.longitude = longitude
		self.latitude = latitude
		
	}
}


public struct Venue {
	
	public var location: Location
	public var title: String
	public var address: String
	
	/* OPTIONAL. */
	public var foursquareId: String?
	
	public init(location: Location,
	            title: String,
	            address: String,
	            foursquareId: String? = nil
		) {
		
		self.location = location
		self.title = title
		self.address = address
		self.foursquareId = foursquareId
		
	}
	
}

public enum ParseMode: String {
	case MARKDOWN
	case HTML
}

public enum ChatAction: String {
	case TYPING
	case UPLOADPHOTO
	case RECORDVIDEO
	case UPLOADVIDEO
	case RECORDAUDIO
	case UPLOADAUDIO
	case UPLOADDOCUMENT
	case FINDLOCATION
}
