//
//  ImageUrlData.swift
//  Component
//
//  Created by 吴杰健 on 17/1/3.
//  Copyright © 2017年 吴杰健. All rights reserved.
//

import Foundation

enum ImageTouchEvent {
    
    case NativeViewController(identifier: String)
    case Web(url: String)
    case None
}

struct ImageUrlData {
    
    let imageUrl: String
    let touchEvent: ImageTouchEvent
    
}
