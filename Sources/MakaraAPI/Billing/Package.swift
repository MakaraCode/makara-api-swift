//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 5/9/20.
//

import Foundation


public struct Package: PubliclyIdentified, Codable {
    
    public let publicId: String
    public let price: Amount
    public let outstanding: Amount
    public let payments: Array<Payment>
    
    internal enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case price
        case outstanding
        case payments
    }
    
    public static let demoPackage1 = Package(
        publicId: "demo_package_1",
        price: Amount(
            magnitude: Decimal(400),
            iso4217: .aud
        ),
        outstanding: Amount(
            magnitude: Decimal(0),
            iso4217: .aud
        ),
        payments: [
            Payment(
                publicId: "demo_payment_2882015",
                amount: Amount(
                    magnitude: Decimal(400),
                    iso4217: .aud
                ),
                method: .card,
                time: Date()
            )
        ]
    )

}
