//
//  TagCreationView.swift
//  Dinnr
//
//  Created by Vincent Romani on 2021-11-07.
//

import SwiftUI

struct TagCreationView: View {
    @State var text: String = ""
    @Binding var tags: [String]
    
    var body: some View {
            VStack {
                TextField("Placeholder", text: $text)
                    .onSubmit {
                        tags.append(text)
                        text = ""
                    }
                
                FlowLayout(mode: .vstack, items: tags) {
                    Text($0)
                        .frame(minWidth: 50, alignment: .center)
                        .padding([.horizontal])
                        .padding([.vertical], .paddingSmall)
                        .foregroundColor(.tertiaryForeground)
                        .background(Color.tertiaryBackground)
                        .cornerRadius(.cornerCapsule)
                }
                .frame(maxHeight: .infinity)
                .fixedSize(horizontal: false, vertical: true)
            }
    }
}

struct TagCreationView_Previews: PreviewProvider {
    struct TestView: View {
        @State var tags: [String] = []
        
        var body: some View {
            TagCreationView(tags: $tags)
        }
    }
    
    static var previews: some View {
        TestView()
    }
}
