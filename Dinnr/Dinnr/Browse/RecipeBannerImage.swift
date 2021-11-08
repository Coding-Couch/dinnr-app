//
//  RecipeBannerImage.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-07.
//

import SwiftUI

struct RecipeBannerImage: View {
    var url: URL?

    var body: some View {
        AsyncImage(url: url, transaction: .init(animation: .interactiveSpring())) { imagePhase in
            switch imagePhase {
            case .empty:
                Color(uiColor: .tertiarySystemFill)
                    .overlay(
                        ProgressView().progressViewStyle(.circular)
                            .scaleEffect(2.0)
                    )
            case let .success(image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure:
                AsyncImagePlaceholderView()
            @unknown default:
                AsyncImagePlaceholderView()
            }
        }
    }
}

// swiftlint:disable line_length
struct RecipeBannerImage_Previews: PreviewProvider {
    static var previews: some View {
        RecipeBannerImage(url: URL(string: "https://cdn.dribbble.com/users/1964284/screenshots/14254179/media/00cddbeea477b855b06d32dcb75e34c4.jpg?compress=1&resize=1000x750")!)
    }
}
// swiftlint:enable line_length
