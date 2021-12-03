//
//  ViewController.swift
//  Kecipir-Test-iOS
//
//  Created by Naratama on 02/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    var dataModelKecipir: DataModelKecipir?
    var addressDataKecipir: AddressModel?
    var warningDataKecipir = [WarningModel]()
    var summaryDataKecipir = [SummaryModel]()
    var deliveryDataKecipir = [DeliveryModel]()
    var packagingDataKecipir = [PackagingModel]()
    var paymentDataKecipir = [PaymentModel]()
    var promotionDataKecipir: PromotionModel?
    var nettoDataKecipir: NettoModel?
    var checkoutDataKecipir: CheckoutModel?
    var billDataKecipir = [BillModel]()
    
    @IBOutlet var totalPrice: UILabel!
    @IBOutlet var checkoutBtn: UIButton!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://staging.kecipir.com/response_checkout.json"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
        
        setupView()
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonDataKecipir = try? decoder.decode(DataKecipir.self, from: json) {
            dataModelKecipir = jsonDataKecipir.data
            addressDataKecipir = dataModelKecipir?.address
            warningDataKecipir = dataModelKecipir!.warning
            summaryDataKecipir = dataModelKecipir!.summary
            deliveryDataKecipir = dataModelKecipir!.delivery
            packagingDataKecipir = dataModelKecipir!.packaging
            paymentDataKecipir = dataModelKecipir!.payment_option
            promotionDataKecipir = dataModelKecipir?.promotion
            nettoDataKecipir = dataModelKecipir?.netto
            checkoutDataKecipir = dataModelKecipir?.checkout
            billDataKecipir = dataModelKecipir!.bill
            tableView.reloadData()
        }
    }
    
    func setupView() {
        //GradientNavbar
        guard
            let navigationController = navigationController,
            let greenGradientImage = CAGradientLayer.primaryGradient(on: navigationController.navigationBar)
        else {
            print("Error creating gradient color!")
            return
        }
        
        navigationController.navigationBar.barTintColor = UIColor(patternImage: greenGradientImage)
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        totalPrice.text = nettoDataKecipir?.total
        totalPrice.textColor = UIColor.init(hexString: nettoDataKecipir?.text_color ?? "000000")
        
        checkoutBtn.layer.cornerRadius = 25
        setupTable()
    }
    
    private func setupTable() {
        tableView.register(HeaderWarningCell.loadNib(), forCellReuseIdentifier: HeaderWarningCell.className())
        tableView.register(ShoppingItemCell.loadNib(), forCellReuseIdentifier: ShoppingItemCell.className())
        tableView.register(AddShoppingItemCell.loadNib(), forCellReuseIdentifier: AddShoppingItemCell.className())
        tableView.register(HeaderNameCell.loadNib(), forCellReuseIdentifier: HeaderNameCell.className())
        tableView.register(PackagingCell.loadNib(), forCellReuseIdentifier: PackagingCell.className())
        tableView.register(CouponCell.loadNib(), forCellReuseIdentifier: CouponCell.className())
        tableView.register(NotesCell.loadNib(), forCellReuseIdentifier: NotesCell.className())
        tableView.register(PaymentMethodCell.loadNib(), forCellReuseIdentifier: PaymentMethodCell.className())
        tableView.register(ShippingAddressCell.loadNib(), forCellReuseIdentifier: ShippingAddressCell.className())
        tableView.register(BillCell.loadNib(), forCellReuseIdentifier: BillCell.className())
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 1))
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 1))
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 6 {
            return 32
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 8
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            let total = summaryDataKecipir.count + 1
            return total
        } else if section == 2 {
            return 4
        } else if section == 3 {
            return 2
        } else if section == 4 {
            return 2
        } else if section == 5 {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            guard let warningCell = tableView.dequeueReusableCell(withIdentifier: HeaderWarningCell.className(), for: indexPath) as? HeaderWarningCell else { fatalError("Cell Not Found") }
            
            if warningDataKecipir.count > indexPath.row {
                let warningDataKecipirSingle = warningDataKecipir[indexPath.row]
                
                warningCell.backgroundColor = UIColor.init(hexString: warningDataKecipirSingle.col_bg)
                warningCell.leftLbl.text = warningDataKecipirSingle.message
                warningCell.leftLbl.textColor = UIColor.init(hexString: warningDataKecipirSingle.col_ft)
                warningCell.rightLbl.textColor = UIColor.init(hexString: warningDataKecipirSingle.col_bt)
            }
            
            return warningCell
        } else if indexPath.section == 1 {
            if summaryDataKecipir.count > indexPath.row {
                guard let shoppingItemCell = tableView.dequeueReusableCell(withIdentifier: ShoppingItemCell.className(), for: indexPath) as? ShoppingItemCell else { fatalError("Cell Not Found") }
                
                let summaryDataKecipirSingle = summaryDataKecipir[indexPath.row]
                
                shoppingItemCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
                shoppingItemCell.productItem.load(urlString: summaryDataKecipirSingle.photo)
                if summaryDataKecipirSingle.discount == "0%" {
                    shoppingItemCell.discView.isHidden = true
                } else {
                    shoppingItemCell.discView.isHidden = true
                }
                shoppingItemCell.itemName.text = summaryDataKecipirSingle.title
                shoppingItemCell.itemPrice.text = summaryDataKecipirSingle.price_sell_text
                shoppingItemCell.itemStock.text = "/ \(summaryDataKecipirSingle.unit)"
                shoppingItemCell.itemFarm.text = summaryDataKecipirSingle.farmer
                shoppingItemCell.stockLbl.text = "Stok \(summaryDataKecipirSingle.stock)"
                
                return shoppingItemCell
            } else {
                guard let addShoppingItemCell = tableView.dequeueReusableCell(withIdentifier: AddShoppingItemCell.className(), for: indexPath) as? AddShoppingItemCell else { fatalError("Cell Not Found") }
                
                addShoppingItemCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
                
                return addShoppingItemCell
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                guard let headerSendCell = tableView.dequeueReusableCell(withIdentifier: HeaderNameCell.className(), for: indexPath) as? HeaderNameCell else { fatalError("Cell Not Found") }
                
                headerSendCell.headerLbl.text = "Pengiriman"
                headerSendCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
                
                return headerSendCell
            } else if indexPath.row == 1 {
                guard let shippingAddressCell = tableView.dequeueReusableCell(withIdentifier: CouponCell.className(), for: indexPath) as? CouponCell else { fatalError("Cell Not Found") }
                
                shippingAddressCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
                
                shippingAddressCell.settingLbl.text = addressDataKecipir?.address
                shippingAddressCell.settingImg.image = UIImage.init(systemName: "house.fill")
                shippingAddressCell.settingImg.tintColor = UIColor.init(hex: 0x4CB245)
                shippingAddressCell.rightImg.image = UIImage.init(systemName: "arrowtriangle.right.fill")
                shippingAddressCell.rightImg.tintColor = UIColor.init(hex: 0x4CB245)
                
                return shippingAddressCell
            } else if indexPath.row == 2 {
                guard let shippingDateCell = tableView.dequeueReusableCell(withIdentifier: CouponCell.className(), for: indexPath) as? CouponCell else { fatalError("Cell Not Found") }
                
                shippingDateCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
                
                let date = "\(checkoutDataKecipir?.harvest_date ?? "")"
                
                let formatter1 = DateFormatter()
                formatter1.dateFormat = "yyyy-MM-dd"
                formatter1.locale = Locale(identifier: "en_US_POSIX")
                
                if let date2 = formatter1.date(from: date) {
                    let formatter2 = DateFormatter()
                    formatter2.dateFormat = "dd MMMM, yyyy"
                    formatter2.locale = Locale(identifier: "en_US_POSIX")
                    
                    let dateString = formatter2.string(from: date2)
                    shippingDateCell.settingLbl.text = dateString
                }
                shippingDateCell.settingImg.image = UIImage.init(systemName: "calendar")
                shippingDateCell.settingImg.tintColor = UIColor.init(hex: 0x4CB245)
                shippingDateCell.rightImg.image = UIImage.init(systemName: "arrowtriangle.right.fill")
                shippingDateCell.rightImg.tintColor = UIColor.init(hex: 0x4CB245)
                
                return shippingDateCell
            } else if indexPath.row == 3 {
                guard let shippingPaymentCell = tableView.dequeueReusableCell(withIdentifier: ShippingAddressCell.className(), for: indexPath) as? ShippingAddressCell else { fatalError("Cell Not Found") }
                
                let deliveryDataKecipirSingle = deliveryDataKecipir.first
                
                shippingPaymentCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
                shippingPaymentCell.addressHeaderLbl.text = deliveryDataKecipirSingle?.delivery_name
                shippingPaymentCell.addressBodyLbl.text = deliveryDataKecipirSingle?.ket
                
                return shippingPaymentCell
            }
        } else if indexPath.section == 3 {
            if indexPath.row == 0 {
                guard let headerPackageCell = tableView.dequeueReusableCell(withIdentifier: HeaderNameCell.className(), for: indexPath) as? HeaderNameCell else { fatalError("Cell Not Found") }
                
                headerPackageCell.headerLbl.text = "Kemasan"
                headerPackageCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
                
                return headerPackageCell
            } else {
                guard let packagingCell = tableView.dequeueReusableCell(withIdentifier: PackagingCell.className(), for: indexPath) as? PackagingCell else { fatalError("Cell Not Found") }
                
                let packagingDataKecipirSingle = packagingDataKecipir.first
                
                packagingCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
                packagingCell.packagingHeaderLbl.text = packagingDataKecipirSingle?.name
                packagingCell.packagingBodyLbl.text = packagingDataKecipirSingle?.ket
                packagingCell.btnLbl.text = packagingDataKecipirSingle?.button_text
                
                return packagingCell
            }
        } else if indexPath.section == 4 {
            if indexPath.row == 0 {
                guard let headerNoteCell = tableView.dequeueReusableCell(withIdentifier: HeaderNameCell.className(), for: indexPath) as? HeaderNameCell else { fatalError("Cell Not Found") }
                
                headerNoteCell.headerLbl.text = "Buat Catatan"
                headerNoteCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
                
                return headerNoteCell
            } else {
                guard let notesCell = tableView.dequeueReusableCell(withIdentifier: NotesCell.className(), for: indexPath) as? NotesCell else { fatalError("Cell Not Found") }
                
                notesCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
                
                return notesCell
            }
        } else if indexPath.section == 5 {
            guard let couponCell = tableView.dequeueReusableCell(withIdentifier: CouponCell.className(), for: indexPath) as? CouponCell else { fatalError("Cell Not Found") }
            
            couponCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
            couponCell.settingLbl.text = "Makin Hemat Pakai Kupon"
            couponCell.settingLbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            couponCell.changeLbl.isHidden = true
            
            return couponCell
        } else {
            if indexPath.row == 0 {
                guard let paymentMethodCell = tableView.dequeueReusableCell(withIdentifier: PaymentMethodCell.className(), for: indexPath) as? PaymentMethodCell else { fatalError("Cell Not Found") }
                
                let paymentDataKecipirSingle = paymentDataKecipir.first
                
                paymentMethodCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
                paymentMethodCell.lblPayment.text = paymentDataKecipirSingle?.name_va
                paymentMethodCell.imgView.load(urlString: paymentDataKecipirSingle?.img ?? "")
                
                return paymentMethodCell
            } else {
                guard let billCell = tableView.dequeueReusableCell(withIdentifier: BillCell.className(), for: indexPath) as? BillCell else { fatalError("Cell Not Found") }
                
                let billDataKecipirSingleFirst = billDataKecipir.first
                let billDataKecipirSingleMid = billDataKecipir[1]
                let billDataKecipirSingleLast = billDataKecipir.last
                
                billCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
                billCell.totPriceLbl.text = billDataKecipirSingleFirst?.title
                billCell.totPriceValueLbl.text = billDataKecipirSingleFirst?.total
                billCell.totPriceValueLbl.textColor = UIColor.init(hexString: billDataKecipirSingleFirst?.text_color ?? "000000")
                billCell.discLbl.text = "Diskon Produk"
                billCell.discValueLbl.text = "\(promotionDataKecipir?.discount ?? 0)"
                billCell.discValueLbl.textColor = UIColor.init(hexString: billDataKecipirSingleMid.text_color)
                billCell.deliveryLbl.text = billDataKecipirSingleMid.title
                billCell.deliveryValueLbl.text = billDataKecipirSingleMid.total
                billCell.deliveryValueLbl.textColor = UIColor.init(hexString: billDataKecipirSingleMid.text_color)
                billCell.packageLbl.text = billDataKecipirSingleLast?.title
                billCell.packageValueLbl.text = billDataKecipirSingleLast?.total
                billCell.packageValueLbl.textColor = UIColor.init(hexString: billDataKecipirSingleLast?.text_color ?? "000000")
                billCell.totBillLbl.text = nettoDataKecipir?.title
                billCell.totBillValueLbl.text = nettoDataKecipir?.total
                billCell.totBillValueLbl.textColor = UIColor.init(hexString: nettoDataKecipir?.text_color ?? "000000")
                
                return billCell
            }
        }
        
        guard let billCell2 = tableView.dequeueReusableCell(withIdentifier: BillCell.className(), for: indexPath) as? BillCell else { fatalError("Cell Not Found") }
        
        return billCell2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 40
        } else if indexPath.section == 1 {
            if summaryDataKecipir.count > indexPath.row {
                return 124
            }
            return 40
        } else if indexPath.section == 2 {
            if indexPath.row == 3 {
                return 64
            }
            return 48
        } else if indexPath.section == 3 {
            if indexPath.row == 1 {
                return 144
            }
            return 48
        } else if indexPath.section == 4 {
            if indexPath.row == 1 {
                return 144
            }
            return 48
        } else if indexPath.section == 5 {
            return 48
        } else {
            if indexPath.row == 1 {
                return 192
            }
            return 96
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 5 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PaymentMethodViewController") as? PaymentMethodViewController
            vc?.paymentDataKecipir = paymentDataKecipir
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
}

