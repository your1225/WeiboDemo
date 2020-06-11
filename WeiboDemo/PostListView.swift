//
//  PostListView.swift
//  WeiboDemo
//
//  Created by 熊伟 on 2020/6/10.
//  Copyright © 2020 Ultra-Union. All rights reserved.
//

import SwiftUI

struct PostListView: View {
    let category: PostListCategory
    
//    var postList: PostList{
//        switch category {
//        case .recommend:
//            return loadPostListData("PostListData_recommend_1.json")
//        case .hot:
//            return loadPostListData("PostListData_hot_1.json")
//        }
//    }
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        List {
            ForEach(userData.postList(for: category).list) { it in
                ZStack{
                    PostCell(post: it)
                    NavigationLink(destination: PostDetailView(post: it)) {
                        EmptyView()
                    }
                    .hidden()
                }
                .listRowInsets(EdgeInsets())
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PostListView(category: .recommend)
                .navigationBarTitle("Title")
                .navigationBarHidden(true)
        }
        .environmentObject(UserData())
    }
}
