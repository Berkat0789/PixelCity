//
//  Constants.swift
//  pixCity
//
//  Created by berkat bhatti on 12/19/17.
//  Copyright © 2017 TKM. All rights reserved.
//

import Foundation


typealias downloadComplete = (_ Success: Bool) -> ()

let API_KEY = "3aa1afa4a03872b565c3a5769bb0ef9c"

func FlickrAURL (annotation: DroppablePin, ApiKEy: String, NumberoFPhotos: Int) -> String {
    return " https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(ApiKEy)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=mi&per_page=\(NumberoFPhotos)&format=json&nojsoncallback=1&auth_token=72157667591127989-dbacc37573d75d81&api_sig=dd46852dc73716054dc8038d772aaf73"
}
