//
//  Constants.swift
//  pixCity
//
//  Created by berkat bhatti on 12/19/17.
//  Copyright © 2017 TKM. All rights reserved.
//

import Foundation


typealias downloadComplete = (_ Success: Bool) -> ()

let API_KEY = "ef868cd21ece3474fad248db8448c075"

func FlickrAURL (annotation: DroppablePin, ApiKEy: String, NumberoFPhotos count: Int) -> String {
    let url = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(ApiKEy)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=mi&per_page=\(count)&format=json&nojsoncallback=1"
    print(url)
    return url
}
