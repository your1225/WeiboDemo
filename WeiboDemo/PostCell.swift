//
//  PostCell.swift
//  WeiboDemo
//
//  Created by 熊伟 on 2020/6/9.
//  Copyright © 2020 Ultra-Union. All rights reserved.
//

import SwiftUI

struct PostCell: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("用户昵称")
                    .font(Font.system(size: 16))
                    .foregroundColor(Color(red: 242/255, green: 99/255, blue: 4/255))
                    .lineLimit(1)
                Text("2020-01-01 00:00")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
            }
            
            Button(action: {
                print("Click follow button")
            }){
                Text("关注")
                    .font(.system(size: 14))
                    .foregroundColor(.orange)
                    .frame(width: 50, height:26)
                    .overlay(
                        RoundedRectangle(cornerRadius: 13)
                            .stroke(Color.orange, lineWidth: 1))
            }
        }
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell()
    }
}
