//
//  SearchHeaderVeiw.swift
//  TableViewDemo
//
//  Created by Sandeep on 20/07/23.
//

import Foundation

import UIKit

protocol SearchHeaderVeiwDelegate: AnyObject {
    func didChangeSearchField(text : String)
    func didTapSearchField()
}

class SearchHeaderVeiw: UICollectionReusableView {
    
    static let headerIdentifier = "SearchHeaderVeiw"
    
    var leadingConstraints: NSLayoutConstraint?
    var trailingConstraints: NSLayoutConstraint?
    weak var delegate: SearchHeaderVeiwDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        [searchTextField, divider].forEach{addSubview($0)}
        setUpConstrains()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isSticky: Bool? {
        didSet{
            guard let isSticky = isSticky else {
                return
            }
            if isSticky {
                divider.isHidden = false
                leadingConstraints?.constant = 17
                trailingConstraints?.constant = -17
            }else {
                divider.isHidden = true
                leadingConstraints?.constant = 2
                trailingConstraints?.constant = -2
            }
        }
    }
    
    lazy var searchTextField : UISearchTextField = {
        let searchTextField = UISearchTextField()
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.textColor = .label.withAlphaComponent(0.8)
        searchTextField.text = ""
        searchTextField.placeholder = "Search"
        searchTextField.font = UIFont.systemFont(ofSize: 12,weight: .regular)
        searchTextField.addTarget(self, action: #selector(didChangeCharacter), for: .editingChanged)
        searchTextField.addTarget(self, action: #selector(didTapTextField), for: .editingDidBegin)
        return searchTextField
    }()
    
    lazy var divider: UIView = {
        let d = UIView()
        d.translatesAutoresizingMaskIntoConstraints = false
        d.backgroundColor = .secondaryLabel
        d.isHidden = true
        return d
    }()
    
    func setUpConstrains(){
        NSLayoutConstraint.activate([
            searchTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: -10),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 0.4),
            divider.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        leadingConstraints = searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2)
        leadingConstraints?.isActive = true

        trailingConstraints = searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2)
        trailingConstraints?.isActive = true

    }
    
    @objc func didChangeCharacter() {
        let text = self.searchTextField.text ?? ""
        self.delegate?.didChangeSearchField(text: text)
    }
    
    @objc func didTapTextField() {
        self.delegate?.didTapSearchField()
    }
}
