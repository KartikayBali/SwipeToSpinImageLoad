//
//  ImagesViewController.swift
//  SwipeToSpin
//
//  Created by Bali on 20/04/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController {
  
  static let CellHeight: CGFloat = 325
  
  @IBOutlet weak var tableView: UITableView!
  
  var dataInfo = DataInfo()
  var searchText: String!
  var count: Int!
  var isLoading = false
  
  var noMoreData: Bool {
    return dataInfo.nextOffset >= count || (dataInfo.totalCount <= count && dataInfo.currentOffset == dataInfo.totalCount)
  }
  
  // MARK:- Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableView()
    navigationItem.title = "Images"
    fetchImages()
  }
  
  // MARK:- Private Methods
  private func setupTableView() {
    registerNibs()
  }
  
  private func registerNibs() {
    let nib = UINib(nibName: "ImageTableViewCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: "ImageTableViewCell")
  }
  
  private func fetchImages() {
    if noMoreData || isLoading {
      return
    }
    
    if dataInfo.images.count == 0 {
      ActivityIndicatorManager.shared.show()
    }
    
    isLoading = true
    APIManager.fetchImagesForSearchText(searchText, count: count, nextOffset: dataInfo.nextOffset) { (result, error) in
      self.isLoading = false
      ActivityIndicatorManager.shared.dismiss()
      
      if error != nil {
        AlertManager.showError(message: error, viewController: self)
        return
      }
      
      if let dataInfo = result {
        self.modifyDataInfoWith(dataInfo)
        self.tableView.reloadData()
      }
    }
  }
  
  private func modifyDataInfoWith(_ newDataInfo: DataInfo) {
    dataInfo.currentOffset = newDataInfo.currentOffset
    dataInfo.nextOffset = newDataInfo.nextOffset
    dataInfo.totalCount = newDataInfo.totalCount
    dataInfo.images.append(contentsOf: newDataInfo.images)
  }
}

// MARK:- UITableViewDataSource
extension ImagesViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataInfo.images.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell") as! ImageTableViewCell
    cell.mainImage = dataInfo.images[indexPath.row]
    return cell
  }
}

// MARK:- UITableViewDelegate
extension ImagesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return type(of: self).CellHeight
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == dataInfo.images.count - 50 {
      // 50 is used so that the user doesnt have to wait for the response
      fetchImages()
    }
  }
}
