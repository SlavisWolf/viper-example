//
//  MainView.swift
//  viper
//
//  Created by Zapp Antonio on 11/7/21.
//

import UIKit

protocol View {
    var presenter: Presenter? {get set}
    func update(with users: [User])
    func update(with error: String)
}


class MainViewController: UIViewController, View {
    //MARK: Variables
    var presenter: Presenter?
    var users = [User]()
    
    //MARK: Components
    private let table: UITableView =  {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.backgroundColor = .clear
        table.separatorColor = .white
        table.allowsSelection = false
        table.isHidden = true
        return table
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.isHidden = true
        return  label
    }()
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
        view.backgroundColor = .systemRed
        table.delegate = self
        table.dataSource = self

        view.addSubview(table)
        view.addSubview(label)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        table.frame = view.frame
        label.frame = view.frame
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    //MARK: View protocol
    func update(with users: [User]) {
        if !users.isEmpty {
            self.users = users
            DispatchQueue.main.async { [unowned self] in
                table.isHidden = false
                table.reloadData()
                label.isHidden = true
            }
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async { [unowned self] in
            users = []
            table.isHidden = true
            table.reloadData()
            label.isHidden = false
            label.text = error
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    
}
