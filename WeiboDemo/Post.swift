//
//  Post.swift
//  WeiboDemo
//
//  Created by 熊伟 on 2020/6/9.
//  Copyright © 2020 Ultra-Union. All rights reserved.
//

import SwiftUI

struct PostList: Codable {
    var list: [Post]
}

//Data Model
//继承了Identifiable之后，在列表中就可以自动用id做主键了
struct Post: Codable, Identifiable {
    //Property 属性
    let id: Int
    let avatar: String //头像.图片名称
    let vip: Bool //true, false
    let name: String
    let date: String
    
    var isFollowed: Bool
    
    let text: String
    let images: [String]
    
    var commentCount: Int
    var likeCount: Int
    var isLiked: Bool
}

extension Post {
    var avatarImage: Image {
        return loadImage(name: avatar)
    }
    
    var commentCountText: String {
        if commentCount <= 0 { return "评论" }
        if commentCount < 1000 { return "\(commentCount)" }
        return String(format: "%.1fk", Double(commentCount) / 1000)
    }
    
    var likeCountText: String {
        if likeCount <= 0 { return "点赞" }
        if likeCount < 1000 { return "\(likeCount)" }
        return String(format: "%.1fk", Double(likeCount) / 1000)
    }
}

//let postList = loadPostListData("PostListData_recommend_1.json")

func loadPostListData(_ fileName: String) -> PostList {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError("Can not find \(fileName) in main bundle")
    }
    
    guard let data = try? Data(contentsOf: url) else {
        fatalError("Can not load \(fileName)")
    }
    
    //到时试一下
//    guard let list = try? JSONDecoder().decode([Post].self, from: data) else {
//        fatalError("Can not parse post list")
//    }
    
    guard let list = try? JSONDecoder().decode(PostList.self, from: data) else {
        fatalError("Can not parse post list")
    }
    
    return list
}

func loadImage(name: String) -> Image{
    return Image(uiImage: UIImage(named: name)!)
}

struct Post_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
