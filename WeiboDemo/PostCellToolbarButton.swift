//
//  PostCellToolbarButton.swift
//  WeiboDemo
//
//  Created by 熊伟 on 2020/6/10.
//  Copyright © 2020 Ultra-Union. All rights reserved.
//

import SwiftUI

struct PostCellToolbarButton: View {
    let image: String
    let text: String
    let color: Color
    let action: () -> Void
    
    var body: some View{
        Button(action: action) {
            HStack(spacing: 5) {
                Image(systemName: image)
                .resizable()
                .scaledToFit()
                    .frame(width: 18, height: 18)
                Text(text)
                    .font(.system(size: 15))
            }
        }
        .foregroundColor(color)
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct PostCellToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
        PostCellToolbarButton(image: "heart", text: "点赞", color: Color.red) {
            print("点赞")
        }
    }
}
