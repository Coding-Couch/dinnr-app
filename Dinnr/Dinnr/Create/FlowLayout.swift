//
//  FlowLayout.swift
//  Dinnr
//
//  Created by Vincent Romani on 2021-11-07.
//

import SwiftUI

struct FlowLayout< T: Hashable, V: View>: View {
    let mode: Mode
    let items: [T]
    let viewMapping: (T) -> V

    @State private var totalHeight: CGFloat

    init(mode: Mode, items: [T], viewMapping: @escaping (T) -> V) {
        self.mode = mode
        self.items = items
        self.viewMapping = viewMapping
        _totalHeight = State(initialValue: (mode == .scrollable) ? .zero : .infinity)
    }

    var body: some View {
        let stack = VStack {
            GeometryReader { geometry in
                self.content(in: geometry)
            }
        }
        return Group {
            if mode == .scrollable {
                stack.frame(height: totalHeight)
            } else {
                stack.frame(maxHeight: totalHeight)
            }
        }
    }

    private func content(in proxy: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return ZStack(alignment: .topLeading) {
            ForEach(self.items, id: \.self) { item in
                self.viewMapping(item)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { dimension in
                        if abs(width - dimension.width) > proxy.size.width {
                            width = 0
                            height -= dimension.height
                        }
                        let result = width
                        if item == self.items.last {
                            width = 0
                        } else {
                            width -= dimension.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                        let result = height
                        if item == self.items.last {
                            height = 0
                        }
                        return result
                    })
            }
        }
        .background(viewHeightReader($totalHeight))
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geo -> Color in
            DispatchQueue.main.async {
                binding.wrappedValue = geo.frame(in: .local).size.height
            }
            return .clear
        }
    }

    enum Mode {
        case scrollable, vstack
    }
}

struct FlowLayout_Previews: PreviewProvider {
    static var previews: some View {
        FlowLayout(mode: .scrollable,
                       items: ["Some long item here", "And then some longer one",
                               "Short", "Items", "Here", "And", "A", "Few", "More",
                               "And then a very very very long one"]) {
            Text($0)
                .font(.system(size: 12))
                .foregroundColor(.black)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4)
                                .border(Color.gray)
                                .foregroundColor(Color.gray))
        }.padding()
    }
}
