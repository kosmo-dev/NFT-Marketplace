//
//  ProfileService.swift
//  NFT Marketplace
//
//  Created by Денис on 29.08.2023.
//

import Foundation

protocol ProfileServiceProtocol {
    func fetchUserProfile(competion: @escaping (Result<UserProfile, Error>) -> Void)
}

struct ProfileService: ProfileServiceProtocol {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchUserProfile(competion: @escaping (Result<UserProfile, Error>) -> Void) {
        let request = UserProfileRequest(userId: "1")
        networkClient.send(request: request, type: UserProfile.self, onResponse: competion)
    }
}

struct UserProfileRequest: NetworkRequest {
    let userId: String
    
    var endpoint: URL? {
        return URL(string: "https://64e794e8b0fd9648b7902516.mockapi.io/api/v1/profile/\(userId)")
    }
    
    var httpMethod: HttpMethod {
        return .get
    }
}
