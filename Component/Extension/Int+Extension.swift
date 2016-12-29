//
//  Int+Extension.swift
//  Component
//
//  Created by 吴杰健 on 16/12/29.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

extension Int {
    
    func times(block: () -> Void) {
        guard self > 0 else {
            return
        }
        (0..<self).forEach { _ in
            block()
        }
    }
    
}
