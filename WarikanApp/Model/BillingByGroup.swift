//
//  BillingByGroup.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/08/02.
//

import Foundation

class BillingByGroup: ObservableObject {
    @Published var billingByGroup: [Billing]
    
    init(billingByGroup: [Billing]) {
        self.billingByGroup = billingByGroup
    }
}
