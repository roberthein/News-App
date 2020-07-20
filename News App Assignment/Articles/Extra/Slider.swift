//
//  Slider.swift
//  News App Assignment
//
//  Created by Robert-Hein Hooijmans on 07/01/17.
//  Copyright © 2017 Robert-Hein Hooijmans. All rights reserved.
//

import UIKit

enum SliderState {
    case sliding
    case idle
}

protocol SliderDelegate {
    func didSlide(to index: Int)
}

class Slider: UIView {
    
    var delegate: SliderDelegate?
    
    var state: SliderState = .idle {
        didSet {
            guard state != oldValue else { return }
            
            switch state {
                case .sliding:
                    controlKnobWidth.constant = 30
                    controlKnobHeight.constant = 30
                case .idle:
                    controlKnobWidth.constant = 15
                    controlKnobHeight.constant = 15
            }
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.curveEaseOut, .beginFromCurrentState, .allowUserInteraction], animations: {
                self.layoutIfNeeded()
                self.controlKnobView.layer.cornerRadius = self.state == .idle ? 7.5 : 15
            }, completion: nil)
        }
    }
    
    private lazy var leftBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.tint.withAlphaComponent(0.2)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var rightBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.tint.withAlphaComponent(0.2)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var controlKnobView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.tint
        view.layer.cornerRadius = 7.5
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var controlKnobPosition: NSLayoutConstraint = controlKnobView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -150)
    private lazy var controlKnobWidth: NSLayoutConstraint = controlKnobView.widthAnchor.constraint(equalToConstant: 15)
    private lazy var controlKnobHeight: NSLayoutConstraint = controlKnobView.heightAnchor.constraint(equalToConstant: 15)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(leftBarView)
        addSubview(rightBarView)
        addSubview(controlKnobView)
        
        leftBarView.left(to: self, offset: -11.5)
        leftBarView.centerY(to: self)
        leftBarView.height(10)
        
        rightBarView.right(to: self, offset: 11.5)
        rightBarView.centerY(to: self)
        rightBarView.height(10)
        
        controlKnobView.centerY(to: self)
        controlKnobView.left(to: leftBarView, leftBarView.rightAnchor, offset: 4)
        controlKnobView.right(to: rightBarView, rightBarView.leftAnchor, offset: -4)
        
        controlKnobPosition.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            controlKnobPosition,
            controlKnobWidth,
            controlKnobHeight
        ])
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        pan.delegate = self
        addGestureRecognizer(pan)
        
        let press = UILongPressGestureRecognizer(target: self, action: #selector(press(_:)))
        press.minimumPressDuration = 0
        press.delegate = self
        addGestureRecognizer(press)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func index(from location: CGPoint) -> Int {
        let part = bounds.width / 30
        
        var index = Int(location.x / part)
        index = max(0, min(29, index))
        
        return index
    }
    
    @objc func pan(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        if case .changed = gestureRecognizer.state {
            index = index(from: gestureRecognizer.location(in: gestureRecognizer.view))
        }
    }
    
    @objc func press(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        switch gestureRecognizer.state {
            case .began:
                index = index(from: gestureRecognizer.location(in: gestureRecognizer.view))
                state = .sliding
            case .ended, .cancelled, .failed:
                state = .idle
            default:
                break
        }
    }
    
    var index: Int = 0 {
        didSet {
            if index != oldValue {
                delegate?.didSlide(to: index)
            }
        }
    }
    
    func set(_ scrollPosition: Float) {
        let halfWidth = bounds.width / 2
        var horizontalPosition = -halfWidth + ((bounds.width / 29) * CGFloat(scrollPosition))
        horizontalPosition.clamp(to: -halfWidth ... halfWidth)
        controlKnobPosition.constant = horizontalPosition
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.curveEaseOut, .beginFromCurrentState, .allowUserInteraction], animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
}

extension Slider: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}
