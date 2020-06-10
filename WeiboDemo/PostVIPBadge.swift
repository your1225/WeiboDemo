//
//  PostVIPBadge.swift
//  WeiboDemo
//
//  Created by 熊伟 on 2020/6/9.
//  Copyright © 2020 Ultra-Union. All rights reserved.
//

import SwiftUI

struct PostVIPBadge: View {
    let vip:Bool
    
    var body: some View {
        Group{
            if vip {
                Text("V")
                    .bold()
                    .font(.system(size: 11))
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color.yellow)
                    .background(Color.red)
                    .clipShape(Circle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 7.5)
                            .stroke(Color.white, lineWidth: 1)
                )
            }
        }
    }
}

struct PostVIPBadge_Previews: PreviewProvider {
    static var previews: some View {
        PostVIPBadge(vip: true)
    }
}
