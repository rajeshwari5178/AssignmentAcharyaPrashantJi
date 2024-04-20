//
//  ViewController.swift
//  AssignmentAcharyaPrashantJi
//
//  Created by Rajeshwari Sharma on 19/04/24.
//
// ViewController.swift
// This file contains the ViewController class, which manages the main view of the app.

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // ViewModel instance to manage data
    let viewModel = ViewModel()
    
    // Cache for storing images in memory
    let imageCache = NSCache<NSString, UIImage>()
    
    // Queue for handling image loading tasks
    let imageLoadingQueue = DispatchQueue(label: "com.example.imageLoadingQueue", qos: .userInitiated)
    
    // IBOutlet for the collection view
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Call API to fetch data
        apicalling()
        // Set delegate and data source for the collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Register collection view cell
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CollectionViewCell")
        
        // Set collection view layouts
        setCollectionViewLayouts()
    }
    
    // Function to set collection view layouts
    func setCollectionViewLayouts() {
        let flowLayout = UICollectionViewFlowLayout()
        let width = (view.frame.width - 20) / 3 // Adjust spacing as needed
        flowLayout.itemSize = CGSize(width: width, height: width)
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 5
        collectionView.collectionViewLayout = flowLayout
    }
    
    // Function to call API for fetching data
    func apicalling() {
        print("API calling")
        
        // Call ViewModel function to fetch data from API
        viewModel.fetchDataFromApi { result in
            switch result {
            case .success(let data):
                print("Received data: \(data)")
                
                // Set the fetched data in the view model
                self.viewModel.datamodel = data
                
                // Reload the collection view on the main thread
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            case .failure(let error):
                print("Error: \(error)")
                // Handle error here
            }
        }
    }
}

// Extension for implementing UICollectionViewDelegateFlowLayout methods
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    // Function to return the number of sections in collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Function to return the number of items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.datamodel?.count ?? 0
    }
    
    // Function to return collection view cell for item at index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let domain = "\(viewModel.datamodel?[indexPath.item].thumbnail?.domain ?? "")/"
        let basepath = "\(viewModel.datamodel?[indexPath.item].thumbnail?.basePath ?? "")/0/"
        let key = viewModel.datamodel?[indexPath.item].thumbnail?.key ?? ""
        print(domain + basepath + key)
        // Set placeholder image
        cell.imageView.image = UIImage(named: "Placeholder")
        
        // Load image asynchronously with caching
        loadImage(with: domain + basepath + key, forCell: cell)
        return cell
    }
    
    // Function called when cell is no longer visible
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CollectionViewCell else { return }
        cancelImageLoadingForCell(cell)
    }
    
    // Function to determine if item can be selected
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        // Optionally, you can handle selection logic here
        return true
    }
}
extension ViewController{
    
    // Function to load image asynchronously with caching
    func loadImage(with urlString: String, forCell cell: CollectionViewCell) {
        guard let url = URL(string: urlString) else { return }
        
        // Check memory cache
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            cell.imageView.image = cachedImage
            return
        }
        
        // Check disk cache
        if let cachedImage = loadFromDiskCache(with: urlString) {
            // Update memory cache
            imageCache.setObject(cachedImage, forKey: urlString as NSString)
            cell.imageView.image = cachedImage
            return
        }
        
        // If image is not cached, download asynchronously
        imageLoadingQueue.async {
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    // Update UI on main thread
                    DispatchQueue.main.async {
                        // Update cell image
                        cell.imageView.image = image
                    }
                    
                    // Cache image in memory
                    self.imageCache.setObject(image, forKey: urlString as NSString)
                    
                    // Cache image on disk
                    print("URL String: \(urlString)")
                    self.saveToDiskCache(data, with: urlString)
                }
            } catch {
                print("Error loading imagess: \(error.localizedDescription)")
            }
        }
    }
    
    // Function to save image to disk cache
    func saveToDiskCache(_ imageData: Data, with urlString: String) {
        let fileManager = FileManager.default
        guard let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
        guard let fileName = URL(string: urlString)?.lastPathComponent else {
            print("Error: Invalid URL")
            return
        }
        let fileUrl = cachesDirectory.appendingPathComponent(fileName)
        
        // Check if directory exists, if not, create it
        if !fileManager.fileExists(atPath: cachesDirectory.path) {
            do {
                try fileManager.createDirectory(at: cachesDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating directory: \(error.localizedDescription)")
                return
            }
        }
        
        do {
            try imageData.write(to: fileUrl)
            print("Image saved to disk cache successfully: \(fileUrl)")
        } catch {
            print("Error saving image to disk: \(error.localizedDescription)")
        }
    }
    
    // Function to load image from disk cache
    func loadFromDiskCache(with key: String) -> UIImage? {
        let fileManager = FileManager.default
        guard let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        let fileUrl = cachesDirectory.appendingPathComponent(key)
        guard let imageData = try? Data(contentsOf: fileUrl) else { return nil }
        return UIImage(data: imageData)
    }
    
    // Function to cancel image loading for a cell
    func cancelImageLoadingForCell(_ cell: CollectionViewCell) {
        // Cancel any ongoing image loading task for the cell
        cell.imageView.image = nil
    }

}
