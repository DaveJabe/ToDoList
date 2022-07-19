//
//  APICommentModel.swift
//  ToDoList
//
//  Created by David Jabech on 7/19/22.
//

import Foundation

struct APIComment: Codable, JSONDecodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
