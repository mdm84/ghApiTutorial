//
//  User.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import Foundation

struct UserOverview: Codable {
  let avatarUrl: String?
  let eventsUrl: String?
  let followersUrl: String?
  let followingUrl: String?
  let gistsUrl: String?
  let gravatarId: String?
  let htmlUrl: String?
  let id: Int?
  let login: String?
  let organizationsUrl: String?
  let receivedEventsUrl: String?
  let reposUrl: String?
  let siteAdmin: Bool?
  let starredUrl: String?
  let subscriptionsUrl: String?
  let type: String?
  let url: String?


  enum CodingKeys: String, CodingKey {
    case avatarUrl = "avatar_url"
    case eventsUrl = "events_url"
    case followersUrl = "followers_url"
    case followingUrl = "following_url"
    case gistsUrl = "gists_url"
    case gravatarId = "gravatar_id"
    case htmlUrl = "html_url"
    case id
    case login
    case organizationsUrl = "organizations_url"
    case receivedEventsUrl = "received_events_url"
    case reposUrl = "repos_url"
    case siteAdmin = "site_admin"
    case starredUrl = "starred_url"
    case subscriptionsUrl = "subscriptions_url"
    case type
    case url
  }
}

struct User: Codable {
 let avatarUrl: String?
 let bio: String?
 let blog: String?
 let company: String?
 let createdAt: String?
 let email: String?
 let eventsUrl: String?
 let followers: Int?
 let followersUrl: String?
 let following: Int?
 let followingUrl: String?
 let gistsUrl: String?
 let gravatarId: String?
 let hireable: Bool?
 let htmlUrl: String?
 let id: Int?
 let location: String?
 let login: String?
 let name: String?
 let organizationsUrl: String?
 let publicGists: Int?
 let publicRepos: Int?
 let receivedEventsUrl: String?
 let reposUrl: String?
 let siteAdmin: Bool?
 let starredUrl: String?
 let subscriptionsUrl: String?
 let type: String?
 let updatedAt: String?
 let url: String?


  enum CodingKeys: String, CodingKey {
    case avatarUrl = "avatar_url"
    case bio
    case blog
    case company
    case createdAt = "created_at"
    case email
    case eventsUrl = "events_url"
    case followers
    case followersUrl = "followers_url"
    case following
    case followingUrl = "following_url"
    case gistsUrl = "gists_url"
    case gravatarId = "gravatar_id"
    case hireable
    case htmlUrl = "html_url"
    case id
    case location
    case login
    case name
    case organizationsUrl = "organizations_url"
    case publicGists = "public_gists"
    case publicRepos = "public_repos"
    case receivedEventsUrl = "received_events_url"
    case reposUrl = "repos_url"
    case siteAdmin = "site_admin"
    case starredUrl = "starred_url"
    case subscriptionsUrl = "subscriptions_url"
    case type
    case updatedAt = "updated_at"
    case url
  }
}
