//
//  ContentConfiguration.swift
//  QR Scanner
//
//  Created by Swarup Panda on 23/11/24.
//

import Foundation

enum ContentConfiguration {
    static let contentForButtons: [String: [ImageViewContent]] = [
        "AR": [
            ImageViewContent(
                imageUrl: "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/1.png",
                mainTitle: "Make Up TryOn",
                topTitle: "Snapchat Filters",
                linkUrl: "https://en.wikipedia.org/wiki/Augmented_reality"
            ),
            ImageViewContent(
                imageUrl: "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/2.png",
                mainTitle: "Virtual Mirror",
                topTitle: "Face Detection",
                linkUrl: "https://en.wikipedia.org/wiki/Virtual_mirror"
            ),
            ImageViewContent(
                imageUrl: "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/3.png",
                mainTitle: "AR Navigation",
                topTitle: "Indoor Mapping",
                linkUrl: "https://en.wikipedia.org/wiki/AR_navigation"
            )
        ],
        "CGI": [
            ImageViewContent(
                imageUrl: "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/2.png",
                mainTitle: "3D Animation",
                topTitle: "Character Design",
                linkUrl: "https://en.wikipedia.org/wiki/Computer-generated_imagery"
            ),
            ImageViewContent(
                imageUrl: "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/3.png",
                mainTitle: "Visual Effects",
                topTitle: "Scene Composition",
                linkUrl: "https://en.wikipedia.org/wiki/Visual_effects"
            )
        ],
        "Web Apps": [
            ImageViewContent(
                imageUrl: "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/3.png",
                mainTitle: "Progressive Web Apps",
                topTitle: "Modern Web",
                linkUrl: "https://en.wikipedia.org/wiki/Progressive_web_app"
            ),
            ImageViewContent(
                imageUrl: "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/4.png",
                mainTitle: "Cloud Services",
                topTitle: "Scalable Solutions",
                linkUrl: "https://en.wikipedia.org/wiki/Cloud_computing"
            )
        ],
        "AI": [
            ImageViewContent(
                imageUrl: "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/4.png",
                mainTitle: "Machine Learning",
                topTitle: "Neural Networks",
                linkUrl: "https://en.wikipedia.org/wiki/Machine_learning"
            ),
            ImageViewContent(
                imageUrl: "https://raw.githubusercontent.com/adibkn1/FlappyBird/refs/heads/main/2.png",
                mainTitle: "Computer Vision",
                topTitle: "Image Recognition",
                linkUrl: "https://en.wikipedia.org/wiki/Computer_vision"
            )
        ]
    ]
}
