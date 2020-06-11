//
//  PostCell.swift
//  WeiboDemo
//
//  Created by 熊伟 on 2020/6/9.
//  Copyright © 2020 Ultra-Union. All rights reserved.
//

import SwiftUI

//let image = UIImage(named: "d0c21786ly1gavj2c0kcej20c8096dh7.jpg")

struct PostCell: View {
    let post: Post
    
    var bindingPost: Post {
        userData.post(forId: post.id)!
    }
    
    @State var presentComment: Bool = false
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        var innerPost = bindingPost
        
        return VStack(alignment: .leading, spacing: 10){
            HStack(spacing: 5) {
                innerPost.avatarImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(
                        PostVIPBadge(vip: innerPost.vip)
                            .offset(x: 16, y: 16)
                )
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(innerPost.name)
                        .font(Font.system(size: 16))
                        .foregroundColor(Color(red: 242/255, green: 99/255, blue: 4/255))
                        .lineLimit(1)
                    Text(innerPost.date)
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                }
                .padding(.leading, 10)
                
                if !innerPost.isFollowed{
                    Spacer()
                    
                    Button(action: {
                        innerPost.isFollowed = true
                        self.userData.update(innerPost)
                    }){
                        Text("关注")
                            .font(.system(size: 14))
                            .foregroundColor(.orange)
                            .frame(width: 50, height:26)
                            .overlay(
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(Color.orange, lineWidth: 1))
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            
            Text(innerPost.text)
                .font(.system(size: 17))
            
            if !innerPost.images.isEmpty{
                PostImageCell(images: innerPost.images, width: UIScreen.main.bounds.width - 30)
            }
            
            Divider()
            
            HStack(spacing: 0){
                Spacer()
                
                PostCellToolbarButton(image: "message", text: innerPost.commentCountText, color: .black) {
                    self.presentComment = true
                }
                .sheet(isPresented: $presentComment) {
                    CommentInputView(post: innerPost).environmentObject(self.userData)
                }
                
                Spacer()
                
                PostCellToolbarButton(image: innerPost.isLiked ? "heart.fill" : "heart",
                                      text: innerPost.likeCountText,
                                      color: innerPost.isLiked ? .red : .black) {
                    if innerPost.isLiked {
                        innerPost.isLiked = false
                        innerPost.likeCount -= 1
                    } else {
                        innerPost.isLiked = true
                        innerPost.likeCount += 1
                    }
                    self.userData.update(innerPost)
                }
                
                Spacer()
            }
            
            Rectangle()
                .padding(.horizontal, -15)
                .frame(height: 10)
                .foregroundColor(Color(red: 238 / 255, green: 238/255, blue: 238/255))
        }
        .padding(.horizontal, 15)
        .padding(.top, 15)
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return PostCell(post: userData.recommendPostList.list[0]).environmentObject(userData)
    }
}
