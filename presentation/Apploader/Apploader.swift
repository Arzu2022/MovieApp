//
//  Apploader.swift
//  presentation
//
//  Created by AziK's  MAC on 21.09.22.
//

import Foundation
import UIKit
import Lottie

public class AppLoader: UIView {

    public static let instance = AppLoader()

    var viewColor: UIColor = .black
    var setAlpha: CGFloat = 0.5
    var gifName: String = ""

    lazy var transparentView: UIView = {
        let transparentView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        transparentView.backgroundColor = viewColor.withAlphaComponent(setAlpha)
        transparentView.isUserInteractionEnabled = true
        return transparentView
    }()

    lazy  var  animationView : AnimationView = {

    var animationView  = AnimationView()
        animationView.animation = Animation.named("movie1")
        animationView.backgroundColor = UIColor.clear
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false

        return animationView
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        cornerView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        cornerView()
    }

    func cornerView() {
        animationView.layer.cornerRadius = 16
        transparentView.addSubview(animationView)
        animationView.centerYAnchor.constraint(equalTo: transparentView.centerYAnchor).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        animationView.centerXAnchor.constraint(equalTo: transparentView.centerXAnchor).isActive = true
        animationView.play()
    }

    public func showLoaderView() {
        self.addSubview(self.transparentView)
        self.transparentView.addSubview(self.animationView)
        self.transparentView.bringSubviewToFront(self.animationView)
        UIApplication.shared.keyWindow?.addSubview(transparentView)
    }

    public func hideLoaderView() {
        self.transparentView.removeFromSuperview()
    }
}
