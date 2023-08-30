//
//  HomeVC.swift
//  TableViewDemo
//
//  Created by Sandeep on 20/07/23.
//

import UIKit

class HomeVC: UIViewController {
    let viewModel = HomeVM()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setUpNavigation()
        setUpConstrains()
        configureCompositionalLayout()
        bindData()
        self.viewModel.searchImageList(title: "")
        self.viewModel.getFeatureImageList()
        HomeViewLayouts.shared.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavigation()
    }
    
    // MARK: Properties
    let navigationView : UIView = {
        let nv = UIView()
        nv.translatesAutoresizingMaskIntoConstraints = false
        nv.backgroundColor = .systemBackground
        return nv
    }()
    
    lazy var searchHeaderView: SearchHeaderVeiw = {
        let searchHeaderView = SearchHeaderVeiw()
        searchHeaderView.translatesAutoresizingMaskIntoConstraints = false
        searchHeaderView.isHidden = true
        searchHeaderView.delegate = self
        return searchHeaderView
    }()
    
    lazy var collectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.registerCellNib(ImageItemCVC.self)
        cv.registerCellNib(CarouselCVC.self)
        cv.register(SearchHeaderVeiw.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: SearchHeaderVeiw.headerIdentifier)
        cv.register(PagerView.self, forSupplementaryViewOfKind: "Footer", withReuseIdentifier: PagerView.headerIdentifier)

        cv.backgroundColor = .systemBackground
        return cv
    }()
    
    func setUpNavigation(){
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isHidden = false
        
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 20,weight: .bold)
        label.textColor = .label
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
    }
    
    func configureUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(navigationView)
        view.addSubview(collectionView)
        view.addSubview(searchHeaderView)
    }
    
    func setUpConstrains(){
        collectionView.setUp(to: view)
        NSLayoutConstraint.activate([
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.topAnchor.constraint(equalTo: view.topAnchor, constant: -(windowConstant.getTopPadding + 64)),
            navigationView.heightAnchor.constraint(equalToConstant: windowConstant.getTopPadding + 64),
            
            searchHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchHeaderView.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    func bindData() {
        self.viewModel.imageListData.bind { [weak self] _ in
            self?.collectionView.reloadSections(IndexSet(integer: 2))
        }
    }
}


extension HomeVC : SearchHeaderVeiwDelegate {
    func didChangeSearchField(text: String) {
        DispatchQueue.main.asyncDeduped(target: self, after: 1.0) {
            self.viewModel.searchImageList(title: text)
        }
        DispatchQueue.main.async {
            if text.isEmpty {
                self.configureCompositionalLayout()
            } else {
                self.configureCompositionalLayoutOnSearch()
            }
        }
    }
    func didTapSearchField() {
        // action on tap
        configureCompositionalLayoutOnSearch()
    }
}


extension HomeVC  {
    func configureCompositionalLayout(){
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            switch sectionIndex {
            case 0 :
                return HomeViewLayouts.shared.carouselSection()
            case 1 :
                return HomeViewLayouts.shared.searchSection()
            default:
                return HomeViewLayouts.shared.imageListSection()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    func configureCompositionalLayoutOnSearch(){
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            switch sectionIndex {
            case 0 :
                return HomeViewLayouts.shared.carouselSectionOnSearch()
            case 1 :
                return HomeViewLayouts.shared.searchSection()
            default:
                return HomeViewLayouts.shared.imageListSection()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

extension HomeVC : CarouselDelegate {
    func getCurrentPage(page: Int) {
        let indexPath = IndexPath(row: 0, section: 0)
        if let footerView = collectionView.supplementaryView(forElementKind: "Footer", at: indexPath) as? PagerView {
            footerView.selectedPage = page
        }
    }
}
