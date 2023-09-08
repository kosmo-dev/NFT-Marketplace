//
//  CollectionScreenAssembler.swift
//  NFT Marketplace
//
//  Created by Dzhami on 08.09.2023.
//

import UIKit

final class CollectionScreenAssembler {
    
    func assemblyCollectionScreen(with model: NFTCollection) -> UIViewController {
        let presenter = CatalogСollectionPresenter(nftModel: model)
        let vc = CatalogСollectionViewController(presenter: presenter)
        vc.hidesBottomBarWhenPushed = true
        return vc
    }
}
