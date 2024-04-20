//
//  DataModel.swift
//  AssignmentAcharyaPrashantJi
//
//  Created by Rajeshwari Sharma on 19/04/24.
//


import Foundation

struct DataModel: Codable {

  var id            : String?        = nil
  var title         : String?        = nil
  var language      : String?        = nil
  var thumbnail     : Thumbnail?     = Thumbnail()
  var mediaType     : Int?           = nil
  var coverageURL   : String?        = nil
  var publishedAt   : String?        = nil
  var publishedBy   : String?        = nil
  var backupDetails : BackupDetails? = BackupDetails()

  enum CodingKeys: String, CodingKey {

    case id            = "id"
    case title         = "title"
    case language      = "language"
    case thumbnail     = "thumbnail"
    case mediaType     = "mediaType"
    case coverageURL   = "coverageURL"
    case publishedAt   = "publishedAt"
    case publishedBy   = "publishedBy"
    case backupDetails = "backupDetails"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id            = try values.decodeIfPresent(String.self        , forKey: .id            )
    title         = try values.decodeIfPresent(String.self        , forKey: .title         )
    language      = try values.decodeIfPresent(String.self        , forKey: .language      )
    thumbnail     = try values.decodeIfPresent(Thumbnail.self     , forKey: .thumbnail     )
    mediaType     = try values.decodeIfPresent(Int.self           , forKey: .mediaType     )
    coverageURL   = try values.decodeIfPresent(String.self        , forKey: .coverageURL   )
    publishedAt   = try values.decodeIfPresent(String.self        , forKey: .publishedAt   )
    publishedBy   = try values.decodeIfPresent(String.self        , forKey: .publishedBy   )
    backupDetails = try values.decodeIfPresent(BackupDetails.self , forKey: .backupDetails )
 
  }

  init() {

  }

}
struct BackupDetails: Codable {

  var pdfLink       : String? = nil
  var screenshotURL : String? = nil

  enum CodingKeys: String, CodingKey {

    case pdfLink       = "pdfLink"
    case screenshotURL = "screenshotURL"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    pdfLink       = try values.decodeIfPresent(String.self , forKey: .pdfLink       )
    screenshotURL = try values.decodeIfPresent(String.self , forKey: .screenshotURL )
 
  }

  init() {

  }

}

struct Thumbnail: Codable {

  var id          : String? = nil
  var version     : Int?    = nil
  var domain      : String? = nil
  var basePath    : String? = nil
  var key         : String? = nil
  var qualities   : [Int]?  = []
  var aspectRatio : Int?    = nil

  enum CodingKeys: String, CodingKey {

    case id          = "id"
    case version     = "version"
    case domain      = "domain"
    case basePath    = "basePath"
    case key         = "key"
    case qualities   = "qualities"
    case aspectRatio = "aspectRatio"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id          = try values.decodeIfPresent(String.self , forKey: .id          )
    version     = try values.decodeIfPresent(Int.self    , forKey: .version     )
    domain      = try values.decodeIfPresent(String.self , forKey: .domain      )
    basePath    = try values.decodeIfPresent(String.self , forKey: .basePath    )
    key         = try values.decodeIfPresent(String.self , forKey: .key         )
    qualities   = try values.decodeIfPresent([Int].self  , forKey: .qualities   )
    aspectRatio = try values.decodeIfPresent(Int.self    , forKey: .aspectRatio )
 
  }

  init() {

  }

}
