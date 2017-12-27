//
//  ChallengeListViewController.swift
//  ThrumpIt
//
//  Created by Satish Kancherla on 12/18/17.
//  Copyright © 2017 Thrumpit. All rights reserved.
//

import UIKit

class ChallengeListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var challengeBtn: UIButton!
    @IBOutlet weak var addUserBtn: UIBarButtonItem!
    @IBOutlet weak var signInBoxHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var challengeList: [ChallengeModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 200
        self.tableView.register(UINib(nibName: "ItemCell", bundle: nil ), forCellReuseIdentifier: "cellIdentifier")
        self.title = "Home"
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 98, height: 34))
        imgView.image = #imageLiteral(resourceName: "titleimg.png")
        imgView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imgView
        if UserPreference.instance.isLoggedIn(){
            signInBoxHeightConstraint.constant = 0
            challengeBtn.layer.cornerRadius = 3.0
            let barButton = UIBarButtonItem(customView: challengeBtn)
            self.navigationItem.rightBarButtonItem = barButton
        }else{
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.leftBarButtonItem = nil
        }
        self.tableView.tableHeaderView = self.searchBar
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchChallengeList()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.challengeList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as? ItemTableViewCell else{
            return UITableViewCell()
        }
        cell.challenge = self.challengeList?[indexPath.row]
        cell.loadChallenge()
        return cell
    }
    
    
    func fetchChallengeList(){
        self.showLoadingNotification(title: "Loading Challenges")
        ChallengeListService.instance.getChallengeList(success: { (list) in
            self.challengeList = list.challenges?.sorted(by: { (lhs, rhs) -> Bool in
                return lhs.viewersCount > rhs.viewersCount
                }) ?? []
            self.tableView.reloadData()
            self.hideLoadingNotification()
        }) { (error) in
            self.showError(error: error)
            self.hideLoadingNotification()
        }
    }
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        openSignIn()
    }
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        openSignUp()
    }
    
    func openSignIn(){
        if let signinvc = UIStoryboard(name: "Tabbar", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController{
            let navc = UINavigationController(rootViewController: signinvc)
            self.navigationController?.present(navc, animated: true, completion: nil)
        }
    }
    
    func openSignUp(){
        if let signupvc = UIStoryboard(name: "Tabbar", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController{
            let navc = UINavigationController(rootViewController: signupvc)
            self.navigationController?.present(navc, animated: true, completion: nil)
        }
    }
    @IBAction func addUser(_ sender: UIBarButtonItem) {
    }
    @IBAction func startNewChallenge(_ sender: UIButton) {
    }
    
}
