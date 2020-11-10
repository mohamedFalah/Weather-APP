//
//  BlurView.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 10/11/2020.
//

import SwiftUI

struct BlurView: UIViewRepresentable {

    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .clear
        
        let BlurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: BlurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    
    
}
