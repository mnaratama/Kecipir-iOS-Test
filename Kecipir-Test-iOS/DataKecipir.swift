//
//  DataKecipir.swift
//  Kecipir-Test-iOS
//
//  Created by Naratama on 03/12/21.
//

import Foundation

struct DataKecipir: Codable {
    var code: Int
    var message: String
    var data: DataModelKecipir
}

struct DataModelKecipir: Codable {
    var payment: Bool
    var address: AddressModel
    var warning: [WarningModel]
//    var toast: Bool
//    var toast_color: Bool
    var promotion: PromotionModel
    var checkout: CheckoutModel
//    var total: [WarningModel]?
    var summary: [SummaryModel]
    var bill: [BillModel]
    var netto: NettoModel
    var pcode: String
//    var harvest_date: [WarningModel] = [WarningModel]()
    var delivery: [DeliveryModel]
    var packaging: [PackagingModel]
    var payment_option: [PaymentModel]
}

struct AddressModel: Codable {
    var name: String
    var address: String
    var phone: String
    var street: String
}

struct WarningModel: Codable {
    var message: String
    var col_ft: String
    var col_bg: String
    var col_bt: String
}

struct SummaryModel: Codable {
    var photo: String
    var qty: String
    var stock: String
    var title: String
    var price_promo: String
    var price_sell: String
    var unit: String
    var farmer: String
    var price_sell_text: String
    var discount: String
}

struct BillModel: Codable {
    var title: String
    var total: String
    var text_color: String
}

struct DeliveryModel: Codable {
    var id_delivery: String
    var delivery_name: String
    var ongkir: Int
    var free_ongkir: String
    var ket: String
    var free_text: String
    var promo_text: String
    var antar: String
}

struct PackagingModel: Codable {
    var ket: String
    var name: String
    var button: Bool
    var button_text: String
}

struct PaymentModel: Codable {
    var id: String
    var group: String
    var group_title: String
    var name_va: String
    var desc_va: String
    var value: String
    var prefix: String
    var img: String
    var balance: Int
    var use_split: Bool
}

struct PromotionModel: Codable {
    var discount: Int
    var type: String
    var model: String
    var desc: String
    var code: String
}

struct CheckoutModel: Codable {
    var harvest_date: String
}

struct NettoModel: Codable {
    var title: String
    var total: String
    var text_color: String
}
