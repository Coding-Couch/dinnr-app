//
//  ProgressHud.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-07.
//

import SwiftUI

struct ProgressHud: View {
    var body: some View {
        ProgressView(LocalizedStringKey("Common.ProgressView.Loading"))
            .progressViewStyle(.circular)
            .frame(width: 120, height: 120, alignment: .center)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
            .transition(AnyTransition.opacity.animation(.default))
    }
}

extension View {
    /// Shows a loading indicator in the center of the page.
    func isLoading(_ isLoading: Bool) -> some View {
        GeometryReader { proxy in
            let globalFrame = proxy.frame(in: .global)

            ZStack(alignment: .center) {
                self

                if isLoading {
                    ProgressHud()
                        .position(x: globalFrame.midX, y: globalFrame.midY)
                }
            }
        }
        .ignoresSafeArea(.all, edges: .all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ProgressPopupView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProgressHud()
                .colorScheme(.light)
                .padding()
                .previewLayout(.sizeThatFits)

            ProgressHud()
                .colorScheme(.dark)
                .padding()
                .previewLayout(.sizeThatFits)

            Text("Hello World!!!!!!!!!!")
                .colorScheme(.light)
                .isLoading(true)

            Text("Hello World!!!!!!!!!!")
                .colorScheme(.light)
                .isLoading(true)
        }
    }
}
