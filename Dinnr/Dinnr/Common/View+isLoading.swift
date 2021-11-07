//
//  View+isLoading.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-07.
//

import SwiftUI

extension View {
    func isLoading(_ isLoading: Bool) -> some View {
        GeometryReader { proxy in
            let globalFrame = proxy.frame(in: .global)

            self

            if isLoading {
                ProgressView(LocalizedStringKey("Common.ProgressView.Loading"))
                    .progressViewStyle(.circular)
                    .frame(width: 120, height: 120, alignment: .center)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .transition(AnyTransition.opacity.animation(.default))
                    .position(x: globalFrame.midX, y: globalFrame.midY)
            }
        }
        .ignoresSafeArea(.all, edges: .all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
