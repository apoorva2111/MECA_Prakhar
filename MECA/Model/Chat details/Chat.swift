//Chat.swift
/*
 * ChatUI
 * Created by penumutchu.prasad@gmail.com on 07/04/19
 * Is a product created by abnboys
 * For the ChatUI in the ChatUI
 avatar = "public/upload/distributors/users/60acf80769fcc.jpg";
 "created_at" = 1621988655370;
 fileurl = "";
 isadmin = 0;
 isfile = "";
 message = "stables ";
 "user_id" = 2;
 username = "MebitCampus Concierge";
 * Here the permission is granted to this file with free of use anywhere in the IOS Projects.
 * Copyright © 2018 ABNBoys.com All rights reserved.
*/

import Foundation
public class Chat {
    
    public var user_name: String!
    public var avatar: String!
    public var fileurl: String!
    public var created_at:Int!
    public var isadmin :Int!
    public var isfile: String!
    public var message:String!
    public var user_id:Int!
    
    
    /**
        Returns an array of models based on given dictionary.
        
        Sample usage:
        let json4Swift_Base_list = Json4Swift_Base.chatsFromDictionaryArray(someDictionaryArrayFromJSON)

        - parameter array:  NSArray from JSON dictionary.

        - returns: Array of Json4Swift_Base Instances.
    */
        public class func chatsFromDictionaryArray(array:NSMutableArray) -> [Chat]
        {
            var models:[Chat] = []
            if array.count > 0 {
                array.removeAllObjects()
            }
            for item in array
            {
                models.append(Chat(dictionary: item as! NSDictionary)!)
            }
            return models
        }
    
    /**
        Constructs the object based on the given dictionary.
        
        Sample usage:
        let json4Swift_Base = Json4Swift_Base(someDictionaryFromJSON)

        - parameter dictionary:  NSDictionary from JSON.

        - returns: Json4Swift_Base Instance.
    */
        required public init?(dictionary: NSDictionary) {
            if let id = dictionary["user_id"] as? Int {
                user_id = id
            } else {
                return nil
            }
            user_name = dictionary["username"] as? String
            avatar = dictionary["avatar"] as? String
            fileurl = dictionary["fileurl"] as? String
            created_at = dictionary["created_at"] as? Int
            isadmin = dictionary["isadmin"] as? Int
            isfile = dictionary["isfile"] as? String
           
            message = dictionary["message"] as? String
        }
    /**
        Returns the dictionary representation for the current instance.
        
        - returns: NSDictionary.
    */
        public func dictionaryRepresentation() -> NSDictionary {

            let dictionary = NSMutableDictionary()

            dictionary.setValue(self.avatar, forKey: "avatar")
            dictionary.setValue(self.user_name, forKey: "user_name")
            dictionary.setValue(self.fileurl, forKey: "fileurl")
            dictionary.setValue(self.created_at, forKey: "created_at")
            dictionary.setValue(self.isadmin, forKey: "isadmin")
            dictionary.setValue(self.isfile, forKey: "isfile")
            dictionary.setValue(self.user_id, forKey: "user_id")
            dictionary.setValue(self.message, forKey: "message")
            

            return dictionary
        }
}
