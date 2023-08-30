//
//  StringExtension.swift
//  NFT Marketplace
//
//  Created by Dzhami on 30.08.2023.
//

import Foundation

extension String{
    var encodeUrl : String
    {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl : String
    {
        return self.removingPercentEncoding!
    }
}
