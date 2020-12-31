//
//  AccountViewController.swift
//  Cookin
//
//  Created by Owen Medina on 12/28/20.
//

import UIKit

class AccountViewController: UIViewController {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var recipesCreatedCardView: CardView!
    @IBOutlet weak var recipesAuthoredCardView: CardView!
    @IBOutlet weak var activitiesTableView: UITableView!
    private var currentUser: User?
    fileprivate var firebaseStorageManager = FirebaseStorageManager()
    fileprivate var firestoreManager = FirestoreManager()
    fileprivate var networkManager = NetworkManager()
    fileprivate var activities = [Activity]()
    fileprivate var initialActivities = true
    fileprivate var refreshingActivities = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup current user
        currentUser = (tabBarController as! CookinTabBarController).currentUser
        
        // Setup delegates
        firebaseStorageManager.delegate = self
        firestoreManager.updaterDelegate = self
        firestoreManager.activityDelegate = self
        networkManager.imageDelegate = self
        activitiesTableView.delegate = self
        activitiesTableView.dataSource = self
        
        // Load up data
        firestoreManager.getActivities(forUser: currentUser?.id ?? "")

        // Setup UI
            // User Image View
        userImageView.addCircularBorder(borderWidth: 5.0, borderColor: K.Assets.Colors.orange.cgColor)
        if let userImageURLString = currentUser?.imageURL {
            print("There is a URL")
            networkManager.getImageFromURLString(userImageURLString)
        }
            // User Name Label
        userNameLabel.text = currentUser?.name
            // Recipes Created Card View
        recipesCreatedCardView.cornerRadius = K.ShadowRoundedView.standardCornerRadius
            // Recipes Authored Card View
        recipesAuthoredCardView.cornerRadius = K.ShadowRoundedView.standardCornerRadius
            // Activities Table View
        activitiesTableView.backgroundColor = K.Assets.Colors.fadedOrange
        activitiesTableView.layer.cornerRadius = K.ImageView.standardCornerRadius
        activitiesTableView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !initialActivities {
            refreshActivities()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Ensure the User Image View remainds circular
        userImageView.addCircularBorder(borderWidth: 5.0, borderColor: K.Assets.Colors.orange.cgColor)
    }
    
    @IBAction func userImageViewTapped(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    fileprivate func updateUserImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.userImageView.image = image
        }
    }
    
    private func refreshActivities() {
        refreshingActivities = true
        firestoreManager.getActivities(forUser: currentUser?.id ?? "", fromBeginning: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - UIImagePickerControllerDelegate Methods
extension AccountViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            infoAlert(message: K.Error.failedToGetImageMessage, title: K.Error.failedToGetImageTitle)
            return
        }
        
        updateUserImage(image)
        
        guard let imageData = image.pngData() else {
            infoAlert(message: K.Error.failedToGetImageMessage, title: K.Error.failedToGetImageTitle)
            return
        }
        
        // store in firebase storage
        let path = "\(K.Firebase.Storage.imagesBasePath)/\(currentUser?.id ?? K.Firebase.Storage.nilUserPath)/\(K.Firebase.Storage.userImageFileName)"
        firebaseStorageManager.storeUserImage(imageData, in: path)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UINavigationControllerDelegate Methods
extension AccountViewController: UINavigationControllerDelegate {
    
}

//MARK: - FirebaseStorageManagerDelegate Methods
extension AccountViewController: FirebaseStorageManagerDelegate {
    func didStoreUserImage(_ manager: FirebaseStorageManager, imageURL: URL) {
        guard let id = currentUser?.id else {
            print("Failed to store user image because user ID is unavailable")
            infoAlert(message: K.Firebase.Storage.Error.failedToUploadImageMessage, title: K.Firebase.Storage.Error.failedToUploadImageTitle)
            return
        }
        firestoreManager.updateUserImageURL(imageURL, forID: id)
        networkManager.getImageFromURL(imageURL)
    }
    
    func didFailToStoreUserImage(withError error: Error) {
        print("Failed to store user image: \(error)")
        infoAlert(message: K.Firebase.Storage.Error.failedToUploadImageMessage, title: K.Firebase.Storage.Error.failedToUploadImageTitle)
    }
    
}

//MARK: - FirestoreManagerUpdaterDelegate Methods
extension AccountViewController: FirestoreManagerUpdaterDelegate {
    func didFailToUpdateUserImage(withError error: Error) {
        print("Failed to store user image URL: \(error)")
        infoAlert(message: K.Firebase.Firestore.Error.failedToUploadImageMessage, title: K.Firebase.Firestore.Error.failedToUploadImageTitle)
    }
}

//MARK: - NetworkManagerImageDelegate Methods
extension AccountViewController: NetworkManagerImageDelegate {
    func didGetImage(_ manager: NetworkManager, image: UIImage?) {
        print("Successfully got image")
        DispatchQueue.main.async {
            self.userImageView.image = image
        }
    }
    
    func didFailToGetImage(withError error: Error) {
        infoAlert(message: K.Error.failedToDisplayUserImageMessage, title: K.Error.failedToDisplayUserImageTitle)
    }
}

//MARK: - FirestoreManagerActivityDelegate
extension AccountViewController: FirestoreManagerActivityDelegate {
    func didAddNewActivity(_ manager: FirestoreManager, activity: Activity) {
        // Refresh table view
        self.activities.insert(activity, at: 0)
        DispatchQueue.main.async {
            self.activitiesTableView.reloadData()
        }
    }
    
    func didGetActivities(_ manager: FirestoreManager, activities: [Activity]) {
        // Refresh table view
        initialActivities = false
        if refreshingActivities {
            self.activities = activities
            refreshingActivities = false
            print("Starting from 0")
        } else {
            print("Appending to an array of size \(self.activities.count)")
            self.activities.append(contentsOf: activities)
        }
        DispatchQueue.main.async {
            self.activitiesTableView.reloadData()
        }
    }
    
    func didFailToAddActivity(withError error: Error) {
        print("Failed to add new activity: \(error)")
    }
    
    func didFailToGetActivities(withError error: Error) {
        print("Failed to get activities: \(error)")
        infoAlert(message: K.Firebase.Firestore.Error.failedToGetActivitiesMessage, title: K.Firebase.Firestore.Error.failedToGetActivitiesTitle)
    }

}

//MARK: - UITableViewDelegate Methods
extension AccountViewController: UITableViewDelegate {
    
}

//MARK: - UITableViewDataSource Methods
extension AccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ActivitiesTableView.ActivitiesTableViewCell.identifier, for: indexPath) as! ActivitiesTableViewCell
        cell.activityLabel.text = "\(currentUser!.name) \(activities[indexPath.item].action.rawValue) \(activities[indexPath.item].object)"
        switch activities[indexPath.item].action {
        case .viewed:
            cell.activityImageView.image = #imageLiteral(resourceName: "viewed")
        case .wrote:
            cell.activityImageView.image = #imageLiteral(resourceName: "wrote")
        case .liked:
            cell.activityImageView.image = #imageLiteral(resourceName: "liked")
        case .made:
            fallthrough
        default:
            cell.activityImageView.image = #imageLiteral(resourceName: "made")
        }
        
        cell.backgroundColor = K.Assets.Colors.fadedOrange
        return cell
    }
}

//MARK: - ScrollView Methods
extension AccountViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !firestoreManager.isFetchingActivities else {
            return
        }
        let currentPosition = scrollView.contentOffset.y
        let thresholdForSeenData = activitiesTableView.contentSize.height - K.ActivitiesTableView.thresholdForRemainingUnseenData
        if currentPosition > (thresholdForSeenData-scrollView.frame.size.height) { // Subtract Scroll View Height since Content Offset Y is measured at the top of the Scroll View - i.e. the first position seen but not the last)
            firestoreManager.getActivities(forUser: currentUser?.id ?? "", numberOfActivities: K.Firebase.Firestore.Collections.Users.Activities.subsequentNumberOfActivitiesToFetch)
        }
    }
}
