//
//  Photo.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import Foundation

class Photo {
    /* The number of likes the photo has. */
    var likes : Int!
    /* The string of the url to the photo file. */
    var url : String!
    /* The username of the photographer. */
    var username : String!
    /* The string of the url to the photo file. */
    var urlThumbnail : String!
    /*Date of the photo. */
    var datePosted: NSDate!
    
    /*If the photo was liked*/
    var liked: Bool!
    
    /* Parses a NSDictionary and creates a photo object. */
    init (data: NSDictionary) {
        likes = data.valueForKey("likes")!.valueForKey("count") as! Int
        urlThumbnail = data.valueForKey("images")!.valueForKey("thumbnail")!.valueForKey("url") as! String
        url = data.valueForKey("images")!.valueForKey("standard_resolution")!.valueForKey("url") as! String
        username = data.valueForKey("user")!.valueForKey("username") as! String
        let datePostedRaw = data.valueForKey("created_time") as! String
        datePosted = NSDate(timeIntervalSince1970 : Double(datePostedRaw)!)
        liked = false
        // FILL ME IN
        // HINT: use nested .valueForKey() calls, and then cast using 'as! TYPE'
    }
    
}