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
    func updateUserProfile(with data: UploadProfileModel, completion: @escaping (Result<UserProfile, Error>) -> Void)
}

protocol NFTFetchingProtocol {
    func fetchNFTs(completion: @escaping (Result<[NFTModel], Error>) -> Void)
}

protocol ProfileServiceProtocol: ProfileFetchingProtocol, ProfileUpdatingProtocol {}

struct ProfileService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }

}

extension ProfileService: ProfileServiceProtocol {
    func fetchUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        let request = UserProfileRequest(userId: "1")
        networkClient.send(request: request, type: UserProfile.self, onResponse: completion)
    }

    func updateUserProfile(with data: UploadProfileModel, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        let request = UserProfileUpdateRequest(userId: "1", updateProfile: data)
        networkClient.send(request: request, type: UserProfile.self, onResponse: completion)
    }
}

extension ProfileService: NFTFetchingProtocol {
    func fetchNFTs(completion: @escaping (Result<[NFTModel], Error>) -> Void) {
        let request = NFTRequest()
        networkClient.send(request: request, type: [NFTModel].self, onResponse: completion)
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
    let updateProfile: UploadProfileModel

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

struct NFTRequest: NetworkRequest {
    var endpoint: URL? {
        return URL(string: "https://64858e8ba795d24810b71189.mockapi.io/api/v1/nft")
    }

    var httpMethod: HttpMethod {
        return .get
    }
}
