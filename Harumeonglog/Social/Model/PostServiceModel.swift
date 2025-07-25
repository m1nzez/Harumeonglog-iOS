//
//  postServiceModel.swift
//  Harumeonglog
//
//  Created by 김민지 on 4/21/25.
//

import Foundation


// MARK: 게시글 조회 API
struct PostListResponse : Codable {
    let cursor : Int?
    let hasNext : Bool
    let items : [PostItem]

}

struct PostItem : Codable {
    let postId : Int
    let title : String
    let content : String
    let likeNum : Int
    let commentNum : Int
    let isLiked: Bool
    let createdAt : String?
    let postCategory : String
    let memberInfoResponse : MemberInfoResponse?
    let imageKeyName: String?
}

struct MemberInfoResponse : Codable {
    let memberId : Int
    let email : String
    let nickname : String
    let image : String?
}



// MARK: 게시글 상세 조회 API
struct PostDetailResponse : Codable {
    let postId : Int
    let content : String?
    let title : String
    let createdAt: String?
    let likeNum : Int
    let commentNum : Int
    let isLiked: Bool
    let isOwn : Bool
    let postCategory : String
    let memberInfoResponse : MemberInfoResponse
    let postImageList : [String?]
}


// MARK: 게시글 생성 API
struct AddPostRequest : Encodable {
    let postCategory : String
    let title: String?
    let content : String?
    let postImageList : [String]
}

struct AddPostResponse: Codable {
    let postId : Int
    let createAt : String
    let updateAt : String
}


// MARK: 게시글 수정 API
struct ModifyPostRequest : Encodable {
    let postCategory : String
    let title: String?
    let content : String?
    let postImageList : [String?]
}

struct ModifyPostResponse : Codable {
    let postId: Int
    let title: String?
    let content : String?
    let postCategory : String
    let postImageList : [String?]
    let updateAt : String
}
