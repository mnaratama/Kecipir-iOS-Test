//
//  PaymentMethodViewController.swift
//  Kecipir-Test-iOS
//
//  Created by Naratama on 03/12/21.
//

import UIKit

class PaymentMethodViewController: UIViewController {
    
    var paymentDataKecipir = [PaymentModel]()
    
    var paymentDataSection: [String] = []
    var greencashPaymentMethod = [PaymentModel]()
    var ewalletPaymentMethod = [PaymentModel]()
    var vaPaymentMethod = [PaymentModel]()
    var ccPaymentMethod = [PaymentModel]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
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
        
        navigationController.navigationBar.tintColor = UIColor.white
        
        setupTable()
    }
    
    private func setupTable() {
        tableView.register(HeaderNameCell.loadNib(), forCellReuseIdentifier: HeaderNameCell.className())
        tableView.register(CouponCell.loadNib(), forCellReuseIdentifier: CouponCell.className())
        
        let nibName = UINib(nibName: "HeaderNameCell", bundle: nil)
        self.tableView.register(nibName, forHeaderFooterViewReuseIdentifier: "HeaderNameCell")
        
        for i in paymentDataKecipir {
            if i.group.contains("saldo") {
                greencashPaymentMethod.append(i)
                ewalletPaymentMethod.append(i)
                vaPaymentMethod.append(i)
                ccPaymentMethod.append(i)
            }
            
            if i.group.contains("ewallet") {
                ewalletPaymentMethod.append(i)
            }
            
            if i.group.contains("virtualaccount") {
                vaPaymentMethod.append(i)
            }
            
            if i.group.contains("creditcard") {
                ccPaymentMethod.append(i)
            }
            
            paymentDataSection.append(i.group)
        }
        
        paymentDataSection = paymentDataSection.removeDuplicates()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
    }
    
    
}

extension PaymentMethodViewController: UITableViewDelegate {
    
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
        if section == 3 {
            return 32
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
}



extension PaymentMethodViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return paymentDataKecipir.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return greencashPaymentMethod.count + 1
        } else if section == 1 {
            return ewalletPaymentMethod.count
        } else if section == 2 {
            return vaPaymentMethod.count
        } else if section == 3 {
            return ccPaymentMethod.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            if indexPath.row == 0 {
                guard let headerGreenCell = tableView.dequeueReusableCell(withIdentifier: HeaderNameCell.className(), for: indexPath) as? HeaderNameCell else { fatalError("Cell Not Found") }
                
                headerGreenCell.headerLbl.text = "Dana di Kecipir"
                headerGreenCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
                
                return headerGreenCell
            } else {
                guard let greenCell = tableView.dequeueReusableCell(withIdentifier: CouponCell.className(), for: indexPath) as? CouponCell else { fatalError("Cell Not Found") }
                
                let greencashPaymentMethodSingle = greencashPaymentMethod[0]
                
                greenCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
                greenCell.settingLbl.text = greencashPaymentMethodSingle.name_va
                greenCell.bodyLbl.isHidden = false
                greenCell.bodyLbl.text = "Rp \(greencashPaymentMethodSingle.balance)"
                greenCell.bodyLbl.textColor = UIColor.init(hex: 0xFF9913)
                greenCell.settingImg.load(urlString: greencashPaymentMethodSingle.img)
                greenCell.rightImg.image = UIImage.init(systemName: "arrowtriangle.right.fill")
                greenCell.rightImg.tintColor = UIColor.init(hex: 0x4CB245)
                greenCell.changeLbl.isHidden = true
                
                return greenCell
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                guard let headerVaCell = tableView.dequeueReusableCell(withIdentifier: HeaderNameCell.className(), for: indexPath) as? HeaderNameCell else { fatalError("Cell Not Found") }
                
                headerVaCell.headerLbl.text = "Transfer Virtual Account"
                headerVaCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
                
                return headerVaCell
            } else {
                guard let ewalletCell = tableView.dequeueReusableCell(withIdentifier: CouponCell.className(), for: indexPath) as? CouponCell else { fatalError("Cell Not Found") }
                
                if ewalletPaymentMethod.count > indexPath.row {
                    let ewalletPaymentMethodSingle = ewalletPaymentMethod[indexPath.row]
                    
                    ewalletCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
                    ewalletCell.settingLbl.text = ewalletPaymentMethodSingle.name_va
                    ewalletCell.bodyLbl.isHidden = true
                    ewalletCell.settingImg.load(urlString: ewalletPaymentMethodSingle.img)
                    ewalletCell.rightImg.image = UIImage.init(systemName: "arrowtriangle.right.fill")
                    ewalletCell.rightImg.tintColor = UIColor.init(hex: 0x4CB245)
                    ewalletCell.changeLbl.isHidden = true
                }
                
                return ewalletCell
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                guard let headerEwalletCell = tableView.dequeueReusableCell(withIdentifier: HeaderNameCell.className(), for: indexPath) as? HeaderNameCell else { fatalError("Cell Not Found") }
                
                headerEwalletCell.headerLbl.text = "E-Wallet"
                headerEwalletCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
                
                return headerEwalletCell
            } else {
                guard let vaCell = tableView.dequeueReusableCell(withIdentifier: CouponCell.className(), for: indexPath) as? CouponCell else { fatalError("Cell Not Found") }
                
                if vaPaymentMethod.count > indexPath.row {
                    let vaPaymentMethodSingle = vaPaymentMethod[indexPath.row]
                    
                    vaCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
                    vaCell.settingLbl.text = vaPaymentMethodSingle.name_va
                    vaCell.bodyLbl.isHidden = true
                    vaCell.settingImg.load(urlString: vaPaymentMethodSingle.img)
                    vaCell.rightImg.image = UIImage.init(systemName: "arrowtriangle.right.fill")
                    vaCell.rightImg.tintColor = UIColor.init(hex: 0x4CB245)
                    vaCell.changeLbl.isHidden = true
                }
                
                return vaCell
            }
        } else {
            if indexPath.row == 0 {
                guard let headerCCCell = tableView.dequeueReusableCell(withIdentifier: HeaderNameCell.className(), for: indexPath) as? HeaderNameCell else { fatalError("Cell Not Found") }
                
                headerCCCell.headerLbl.text = "Kartu Kredit"
                headerCCCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
                
                return headerCCCell
            } else {
                guard let ccCell = tableView.dequeueReusableCell(withIdentifier: CouponCell.className(), for: indexPath) as? CouponCell else { fatalError("Cell Not Found") }
                
                if ccPaymentMethod.count > indexPath.row {
                    let ccPaymentMethodSingle = ccPaymentMethod[indexPath.row]
                    
                    ccCell.backgroundColor = UIColor.init(hex: 0xF5F5F5)
                    ccCell.settingLbl.text = ccPaymentMethodSingle.name_va
                    ccCell.bodyLbl.isHidden = true
                    ccCell.settingImg.load(urlString: ccPaymentMethodSingle.img)
                    ccCell.rightImg.image = UIImage.init(systemName: "arrowtriangle.right.fill")
                    ccCell.rightImg.tintColor = UIColor.init(hex: 0x4CB245)
                    ccCell.changeLbl.isHidden = true
                }
                
                return ccCell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 48
        } else if indexPath.section == 1 {
            return 48
        } else if indexPath.section == 2 {
            return 48
        } else {
            return 48
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                print("Ini Header")
            } else {
                navigationController?.popViewController(animated: true)
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                print("Ini Header")
            } else {
                navigationController?.popViewController(animated: true)
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                print("Ini Header")
            } else {
                navigationController?.popViewController(animated: true)
            }
        } else if indexPath.section == 3 {
            if indexPath.row == 0 {
                print("Ini Header")
            } else {
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
