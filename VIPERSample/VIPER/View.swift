//
//  View.swift
//  VIPERSample
//
//  Created by Ayemere  Odia  on 28/04/2021.
//

import UIKit
// Made up of ViewControllers and UIViews
//Protocol to outline the methods that this ViewController should implement
// reference to Presenter

protocol AnyView {
    var presenter:AnyPresenter? { get set }
    func update(with users:[User])
    func update(with error: String)
}

class UserViewController: UIViewController, AnyView, UITableViewDataSource, UITableViewDelegate {
    
    
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        return tableView
    }()
    
    private let label:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.isHidden = true        
        return label
    }()
    
    
    var presenter: AnyPresenter?
    var user:[User] = []
    
    func update(with users: [User]) {
        DispatchQueue.main.async {
            self.user = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.label.text = error
            self.label.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(tableView)
        view.addSubview(label)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = user[indexPath.row].name
        return cell
    }
    
    
}
