//
//  ViewController.swift
//  AnimationChaining
//
//  Created by Demjén Dániel on 2019. 03. 13..
//  Copyright © 2019. Demjén Dániel. All rights reserved.
//

import UIKit

infix operator ~>: AdditionPrecedence

@discardableResult
func ~>(left: UIViewPropertyAnimator, right: UIViewPropertyAnimator)
    -> UIViewPropertyAnimator{
        
        left.addCompletion { (_) in
            right.startAnimation()
        }
        
        return right
}

class ViewController: UIViewController {
    
    private let duration: TimeInterval = 1
    private let size: CGFloat = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x: size, y: size, width: size, height: size)
        let movingView = UIView(frame: frame)
        movingView.backgroundColor = .red
        view.addSubview(movingView)
        
        let animation1 = UIViewPropertyAnimator(duration: duration, curve: .linear) {
            let size = self.size
            let x = self.view.frame.width - size
            let y = movingView.frame.origin.y
            let frame = CGRect(x: x, y: y, width: size, height: size)
            movingView.frame = frame
        }
        
        let animation2 = UIViewPropertyAnimator(duration: duration, curve: .linear) {
            let size = self.size
            let x = movingView.frame.origin.x
            let y = self.view.frame.height - size
            let frame = CGRect(x: x, y: y, width: size, height: size)
            movingView.frame = frame
        }
        
        let animation3 = UIViewPropertyAnimator(duration: duration, curve: .linear) {
            let size = self.size
            let x: CGFloat = 0
            let y = movingView.frame.origin.y
            let frame = CGRect(x: x, y: y, width: size, height: size)
            movingView.frame = frame
        }
        
        let animation4 = UIViewPropertyAnimator(duration: duration, curve: .linear) {
            let size = self.size
            let x = movingView.frame.origin.x
            let y: CGFloat = 0
            let frame = CGRect(x: x, y: y, width: size, height: size)
            movingView.frame = frame
        }
        
        animation1 ~> animation2 ~> animation3 ~> animation4
        animation1.startAnimation()
    }
}

