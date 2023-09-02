//
//  ProfileService.swift
//  NFT Marketplace
//
//  Created by Денис on 29.08.2023.
//

import Foundation

protocol ProfileFetchingProtocol {
    func fetchUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void)
}

protocol ProfileUpdatingProtocol {
    func updateUserProfile(with data: UploadModel, completion: @escaping (Result<UserProfile, Error>) -> Void)
}

protocol ProfileServiceProtocol: ProfileFetchingProtocol, ProfileUpdatingProtocol {}


struct ProfileService: ProfileServiceProtocol {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        let request = UserProfileRequest(userId: "1")
        networkClient.send(request: request, type: UserProfile.self, onResponse: completion)
    }
    
    func updateUserProfile(with data: UploadModel, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        let request = UserProfileUpdateRequest(userId: "1", updateProfile: data)
        networkClient.send(request: request, type: UserProfile.self, onResponse: completion)
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

struct UserProfileUpdateRequest: NetworkRequest {
    var userId: String
    let updateProfile: UploadModel
    
    var endpoint: URL? {
        return URL(string: "https://64e794e8b0fd9648b7902516.mockapi.io/api/v1/profile/\(userId)")
    }
    
    var httpMethod: HttpMethod {
        return .put
    }
    
    var dto: Encodable? {
        return updateProfile
    }
    
    
}
