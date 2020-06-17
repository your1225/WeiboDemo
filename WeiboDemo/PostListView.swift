//
//  PostListView.swift
//  WeiboDemo
//
//  Created by 熊伟 on 2020/6/10.
//  Copyright © 2020 Ultra-Union. All rights reserved.
//

import SwiftUI
import BBSwiftUIKit

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
        BBTableView(userData.postList(for: category).list) { it in
            NavigationLink(destination: PostDetailView(post: it)) {
                PostCell(post: it)
            }
            .buttonStyle(OriginalButtonStyle())
        }
        .bb_setupRefreshControl{ control in
            control.attributedTitle = NSAttributedString(string: "加载中...")
        }
        .bb_pullDownToRefresh(isRefreshing: $userData.isRefeshing) {
            print("Refresh")
            self.userData.loadingError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error"])
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.userData.isRefeshing = false
                self.userData.loadingError = nil
            }
        }
        .bb_pullUpToLoadMore(bottomSpace: 30) {
            if self.userData.isLoadingMore { return }
            self.userData.isLoadingMore = true
            print("Load more")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.userData.isLoadingMore = false
            }
        }
        .overlay(
            Text(userData.loadingErrorText)
                .bold()
                .frame(width: 200)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .opacity(0.8)
                )
                .animation(nil)
                .scaleEffect(userData.showLoadingError ? 1 : 0.5)
                .animation(.spring(dampingFraction: 0.5))  //回弹动画对上面的放大缩小有用
                .opacity(userData.showLoadingError ? 1 : 0)
                .animation(.easeInOut)
        )
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
