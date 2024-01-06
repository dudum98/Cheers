//
//  GIFImageView.swift
//  mlhios1
//
//  Created by Nethmee Perera on 1/5/24.
//

import Foundation
import SwiftUI
import UIKit
import ImageIO

struct GIFImageView: UIViewRepresentable {
    let gifURL: URL

    func makeUIView(context: Context) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.clear
        let gifImageView = UIImageView()
        gifImageView.loadGif(from: gifURL)
        containerView.addSubview(gifImageView)
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gifImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            gifImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            gifImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            gifImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        return containerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // No update needed for now
    }
}

extension UIImageView {
    func loadGif(from url: URL) {
        guard let gifSource = CGImageSourceCreateWithURL(url as CFURL, nil) else { return }

        let gifCount = CGImageSourceGetCount(gifSource)
        var images = [UIImage]()

        for i in 0..<gifCount {
            guard let imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, nil) else { continue }
            let uiImage = UIImage(cgImage: imageRef)
            images.append(uiImage)
        }

        self.animationImages = images
        self.animationDuration = Double(gifCount) / 10.0  // Adjust the speed as needed
        self.startAnimating()
    }
}

