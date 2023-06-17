//
//  MainPageViewController.swift
//  Movies Explorer
//
//  Created by Temirlan on 4.06.2023.
//

import UIKit

class MainPageViewController: UIViewController {
    private let viewModel: MainPageViewModel
    private var collectionView: UICollectionView!
    
    init(viewModel: MainPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.getAllCategoriesMovies()
    }
    
    private func setupUI() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        collectionView.register(MoviePosterCollectionViewCell.self, forCellWithReuseIdentifier: MoviePosterCollectionViewCell.identifier)
        collectionView.register(SectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: SectionHeaderCollectionReusableView.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.didGetMovies = { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
}

extension MainPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var posterMovies: [MoviePosterModel] = []
        switch viewModel.sections[indexPath.section] {
        case .nowPlaying(let movies):
            posterMovies = movies
        case .popular(let movies):
            posterMovies = movies
        case .topRated(let movies):
            posterMovies = movies
        case .upcoming(let movies):
            posterMovies = movies
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCollectionViewCell.identifier, for: indexPath) as? MoviePosterCollectionViewCell else { fatalError() }
        cell.configure(movie: posterMovies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .nowPlaying(let movies):
            return movies.count
        case .popular(let movies):
            return movies.count
        case .topRated(let movies):
            return movies.count
        case .upcoming(let movies):
            return movies.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
}

extension MainPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case "header":
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderCollectionReusableView.identifier, for: indexPath) as? SectionHeaderCollectionReusableView else { fatalError() }
            header.configure(title: viewModel.sections[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

extension MainPageViewController {
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex: Int,
                                                                        layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            return self.cellLayout()
        }
        
        return layout
    }
    
    private func cellLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(116),
                                              heightDimension: .absolute(200.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(200.9))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(16)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 16, bottom: 6, trailing: 16)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .estimated(24))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
}
