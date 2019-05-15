//
//  ViewController.swift
//  DynamicTypeTableViewCellTextColor
//
//  Created by Tom Kraina on 15/05/2019.
//  Copyright © 2019 Tom Kraina. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)

        // When using one of the predefined UITableViewCell.CellStyle, some (all?) of the UILabel properties
        // like text, font, and textColor are reset to default when Dynamic Type settings changes.
        // Therefore be must set the textLabel and detailTextLabel properties every time we dequeue the cell.
        // It's not enough to set the properties only when the table view cell is created, e.g.: MyCell.setup()
        cell.textLabel?.text = "Title"
        cell.detailTextLabel?.text = "Subtitle"

        // Uncomment the following line to re-style the cell after Dynamic Type settings changes
//        (cell as? MyCell)?.setup()

        return cell
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Try to change the Font Size in Accessibility Inspector"
    }

    // MARK: - IBAction

    @IBAction func reloadTableView() {
        // Reloading the table view does not reset any of the UILabel properties in UITableViewCell
        self.tableView.reloadData()
    }
}

class MyCell: UITableViewCell {

    static let reuseIdentifier: String = String(describing: MyCell.self)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        setup()
    }
}

private extension MyCell {
    func setup() {
        let metrics = UIFont.TextStyle.body.metrics

        self.textLabel?.text = "Title"
        self.textLabel?.font = metrics.scaledFont(for: .italicSystemFont(ofSize: 15))
        self.textLabel?.adjustsFontForContentSizeCategory = true
        self.textLabel?.numberOfLines = 0
        self.textLabel?.textColor = UIColor.blue

        self.detailTextLabel?.text = "Subtitle"
        self.detailTextLabel?.font = metrics.scaledFont(for: .italicSystemFont(ofSize: 13))
        self.detailTextLabel?.adjustsFontForContentSizeCategory = true
        self.detailTextLabel?.numberOfLines = 0
        self.detailTextLabel?.textColor = UIColor.brown

        self.selectionStyle = .none
    }
}
