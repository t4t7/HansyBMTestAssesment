//
//  ArtisMediaViewController.swift
//  GMTestCoding
//
//  Created by Hansy Enrique Abrego on 30/07/21.
//

import Foundation
import UIKit
import Combine

class ArtistListMediaViewController: UIViewController {
    
    @IBOutlet var stackContainer: UIStackView!
    @IBOutlet var loading: UIActivityIndicatorView!
    @IBOutlet var txtSearchArtist: UITextField!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var btnSearchArtist: UIButton!
    var cancellables = Set<AnyCancellable>()
    let viewModel = ArtistMediaViewModel()
    
    lazy var collectionDataSource: UICollectionViewDiffableDataSource<Int, ArtistMediaViewModelCell> = {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(140))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(140))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        var section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: section)
        return UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                  cellProvider: Self.dequeuCell(collectionView:indexPath:artist:))
    }()
    
    // MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewDidLoadViewModel()
        
        viewDidLoadCollectionView()
        
        viewDidLoadUIStyle()
    }
    
    private func viewDidLoadViewModel() {
        viewModel.$artistListMedia
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] listArtisViewModel in
            
            DispatchQueue.main.async {
                hiddeLoading()
                DispatchQueue.main.async {
                    var snapShot = NSDiffableDataSourceSnapshot<Int, ArtistMediaViewModelCell>()
                    snapShot.appendSections([0])
                    snapShot.appendItems(listArtisViewModel)
                    collectionDataSource.apply(snapShot)
                }
            }
        }.store(in: &cancellables)
        
        viewModel.$errorMedia
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] error in
                self.hiddeLoading()
                guard let error = error else {
                    return
                }
                self.show(error)
            }.store(in: &cancellables)
    }
    
    private func viewDidLoadCollectionView() {
        collectionView.register(ArtisMediaViewCell.nib,
                                forCellWithReuseIdentifier: ArtisMediaViewCell.reusableName)
        collectionView.dataSource = collectionDataSource
    }
    
    private func viewDidLoadUIStyle() {
        btnSearchArtist.cornerRadious = 5.0
        stackContainer.cornerRadious = 5.0
    }

    private func show(_ messageError: String) {
        let alertController = UIAlertController(title: "Error",
                                                message: messageError,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertController, animated: true)
    }
    
    @IBAction func searchArtist(_ sender: Any) {
        guard let artist = txtSearchArtist.text?.trimmingCharacters(in: .whitespaces), !artist.isEmpty else {
            return
        }
        DispatchQueue.main.async {
            self.view.endEditing(true)
            self.showLoading()
            DispatchQueue.main.async {
                self.viewModel.keyWord = self.txtSearchArtist.text?.trimmingCharacters(in: .whitespaces) ?? ""
            }
        }
    }
    
    // MARK: - CollectionView
    
    static func dequeuCell(collectionView: UICollectionView,
                           indexPath: IndexPath,
                           artist: ArtistMediaViewModelCell) -> UICollectionViewCell? {
        
        let artistCell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtisMediaViewCell.reusableName,
                                                           for: indexPath) as? ArtisMediaViewCell
        artistCell?.set(viewModel: artist)
        artistCell?.contentView.cornerRadious = 5.0
        return artistCell
    }
    
    // MARK:- Loading
    
    private func showLoading() {
        view.bringSubviewToFront(loading)
        loading.startAnimating()
        UIView.animate(withDuration: 0.2) {
            self.collectionView.alpha = 0
        }
    }
    
    private func hiddeLoading() {
        loading.stopAnimating()
        view.sendSubviewToBack(loading)
        UIView.animate(withDuration: 0.2) {
            self.collectionView.alpha = 1
        }
    }
}

