//
//  BottomSheetContainerViewController.swift
//  KBTUApp
//
//  Created by User on 09.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

open class BottomSheetContainerViewController<Content: UIViewController, BottomSheet: UIViewController> : UIViewController , UIGestureRecognizerDelegate{
    
    // MARK: - Initialization
    public init(contentViewController: Content,
                bottomSheetViewController: BottomSheet,
                bottomSheetConfiguration: BottomSheetConfiguration) {
        
        self.contentViewController = contentViewController
        self.bottomSheetViewController = bottomSheetViewController
        self.configuration = bottomSheetConfiguration
        
        super.init(nibName: nil, bundle: nil)
    }
    // MARK: - Configuration
    public struct BottomSheetConfiguration {
        let height: CGFloat
        let initialOffset: CGFloat
    }
    
    private let configuration: BottomSheetConfiguration
    
    // MARK: - State
    public enum BottomSheetState {
        case initial
        case full
    }
    
    var state: BottomSheetState = .initial

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    // MARK: - Children
    let contentViewController: Content
    let bottomSheetViewController: BottomSheet
  
    
    private var topConstraint = NSLayoutConstraint()
    
    // MARK: - UIGestureRecognizer Delegate
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    private func setupUI() {
        // 1
        self.addChild(contentViewController)
        self.addChild(bottomSheetViewController)
        
        // 2
        self.view.addSubview(contentViewController.view)
        self.view.addSubview(bottomSheetViewController.view)
        
        // 3
        bottomSheetViewController.view.addGestureRecognizer(panGesture)
        
        // 4
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // 5
        NSLayoutConstraint.activate([
            contentViewController.view.leftAnchor
                .constraint(equalTo: self.view.leftAnchor),
            contentViewController.view.rightAnchor
                .constraint(equalTo: self.view.rightAnchor),
            contentViewController.view.topAnchor
                .constraint(equalTo: self.view.topAnchor),
            contentViewController.view.bottomAnchor
                .constraint(equalTo: self.view.bottomAnchor)
            ])
        
        // 6
        contentViewController.didMove(toParent: self)
        
        // 7
        topConstraint = bottomSheetViewController.view.topAnchor
            .constraint(equalTo: self.view.bottomAnchor,
                        constant: -configuration.initialOffset)
        
        // 8
        NSLayoutConstraint.activate([
            bottomSheetViewController.view.heightAnchor
                .constraint(equalToConstant: configuration.height),
            bottomSheetViewController.view.leftAnchor
                .constraint(equalTo: self.view.leftAnchor),
            bottomSheetViewController.view.rightAnchor
                .constraint(equalTo: self.view.rightAnchor),
            topConstraint
            ])
        
        // 9
        bottomSheetViewController.didMove(toParent: self)
    }
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: bottomSheetViewController.view)
        let velocity = sender.velocity(in: bottomSheetViewController.view)
        
        let yTranslationMagnitude = translation.y.magnitude
        switch sender.state {
        case .began, .changed:
            if self.state == .full {
                // 1
                guard translation.y > 0 else { return }
                
                // 2
                topConstraint.constant = -(configuration.height - yTranslationMagnitude)
                
                // 3
                self.view.layoutIfNeeded()
            } else {
                // 4
                let newConstant = -(configuration.initialOffset + yTranslationMagnitude)
                
                // 5
                guard translation.y < 0 else { return }
                
                // 6
                guard newConstant.magnitude < configuration.height else {
                    self.showBottomSheet()
                    return
                }
                
                // 7
                topConstraint.constant = newConstant
                
                // 8
                self.view.layoutIfNeeded()
            }
        case .ended:
            if self.state == .full {
                // 1
                if yTranslationMagnitude >= configuration.height / 2 || velocity.y > 1000 {
                    // 2
                    self.hideBottomSheet()
                } else {
                    // 3
                    self.showBottomSheet()
                }
            } else {
                // 4
                if yTranslationMagnitude >= configuration.height / 2 || velocity.y < -1000 {
                    // 5
                    self.showBottomSheet()
                } else {
                    // 6
                    self.hideBottomSheet()
                }
            }
        case .failed:
            if self.state == .full {
                self.showBottomSheet()
            } else {
                self.hideBottomSheet()
            }
        default: break
        }
    }

    
    lazy var panGesture: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer()
        pan.delegate = self
        pan.addTarget(self, action: #selector(handlePan))
        return pan
    }()
    
    
    // MARK: - Bottom Sheet Actions
    public func showBottomSheet(animated: Bool = true) {
        self.topConstraint.constant = -configuration.height
        
        if animated {
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.state = .full
            })
        } else {
            self.view.layoutIfNeeded()
            self.state = .full
        }
    }
    
    public func hideBottomSheet(animated: Bool = true) {
        self.topConstraint.constant = -configuration.initialOffset
        
        if animated {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0.5,
                           options: [.curveEaseOut],
                           animations: {
                            self.view.layoutIfNeeded()
            }, completion: { _ in
                self.state = .initial
            })
        } else {
            self.view.layoutIfNeeded()
            self.state = .initial
        }
    }
}
