//
//  AsyncImagePlaceholderView.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-07.
//

import SwiftUI

struct AsyncImagePlaceholderView: View {
    var body: some View {
        GeometryReader { proxy in
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: proxy.size.width / 2, maxHeight: proxy.size.height / 2)
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.gray, Color(uiColor: .systemFill))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(uiColor: .tertiarySystemFill))

        }
    }
}

struct AsyncImagePlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImagePlaceholderView()
    }
}
