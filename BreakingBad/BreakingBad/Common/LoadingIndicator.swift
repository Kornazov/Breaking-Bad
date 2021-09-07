//
//  LoadingIndicator.swift
//  BreakingBad
//
//  Created by Kristiyan Kornazov on 7.09.21.
//

import Foundation
import UIKit

class Indicator {

    public static let shared = Indicator()
    private var blurImage = UIImageView()
    private var indicator = UIActivityIndicatorView()

    private init() {
        blurImage.frame = UIScreen.main.bounds
        blurImage.backgroundColor = .orange
        blurImage.isUserInteractionEnabled = true
        blurImage.alpha = 0.2
        
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.center = blurImage.center
        indicator.startAnimating()
        indicator.color = .orange
    }

    func showIndicator() {
        DispatchQueue.main.async {
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(self.blurImage)
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(self.indicator)
        }
    }
    
    func hideIndicator() {
        DispatchQueue.main.async {
                self.blurImage.removeFromSuperview()
                self.indicator.removeFromSuperview()
        }
    }
}

