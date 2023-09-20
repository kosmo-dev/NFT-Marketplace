//
//  AlertModel.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 13.09.2023.
//

import UIKit

struct AlertModel {
    let title: String
    let style: UIAlertAction.Style
    let completion: (() -> Void)?
}
