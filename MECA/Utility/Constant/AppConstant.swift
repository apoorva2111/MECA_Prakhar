

import Foundation

var userDef = UserDefaults.standard

struct UserDefaultKey {
    static var token = "token"
    static var headerdatetitle = "datetitle"
    static var Distributorname = "Distributorname"
    static var avatar = "avatar"
    static var userId = "userId"
    static var loginResponse = "loginResponse"
    static var firebaseemail = "firebaseemail"
    static var firebasepassword = "firebasepassword"
    static var loggedusername = "loggedusername"
    static var firebaseavatar = "firebaseavatar"
    static var traininguploadid = "traininguploadid"
    static var trainingpdcauploadid = "trainingpdcauploadid"
    static var replyView = "replyView"
}

struct BoolValue {
    static var isFromDistributor = false
    static var isFromReplyComment = false
    static var isFromNewsContent = false
    static var isClickOnCategory = false

}

struct GlobalValue {
    static var tabCategory = ""
    static var newsDetailDocument = ""

}
