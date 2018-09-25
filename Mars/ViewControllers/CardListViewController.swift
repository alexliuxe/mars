//
//  CardListViewController.swift
//  TestProject
//
//  Created by Alex Liu on 2018-09-22.
//  Copyright © 2018 Alex Liu. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var requirement: UILabel!
    @IBOutlet weak var requirementImage: UIImageView!
    @IBOutlet weak var tag1: UIImageView!
    @IBOutlet weak var tag2: UIImageView!
    @IBOutlet weak var tag3: UIImageView!
    @IBOutlet weak var tag4: UIImageView!
    
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //styleSetup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //reset values
        self.tag1.isHidden = true
        self.tag1.image = nil
        
        self.tag2.isHidden = true
        self.tag2.image = nil
        
        self.tag3.isHidden = true
        self.tag3.image = nil
        
        self.tag4.isHidden = true
        self.tag4.image = nil
    }
}


extension CardCell {
    
    static func identifier() -> String
    {
        return NSStringFromClass(CardCell.self)
    }
    
    static func estimatedRowHeight() -> CGFloat
    {
        return 120
    }
    
    static func register(in tableView: UITableView)
    {
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.identifier())
    }
}

class PreludeCardCell: UITableViewCell {
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var tag1: UIImageView!
    @IBOutlet weak var tag2: UIImageView!
    @IBOutlet weak var tag3: UIImageView!
    @IBOutlet weak var tag4: UIImageView!
    @IBOutlet weak var des: UILabel!
    
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //styleSetup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //reset values
        
        self.tag1.isHidden = true
        self.tag1.image = nil
        
        self.tag2.isHidden = true
        self.tag2.image = nil
        
        self.tag3.isHidden = true
        self.tag3.image = nil
        
        self.tag4.isHidden = true
        self.tag4.image = nil
    }
}
extension PreludeCardCell {
    
    static func identifier() -> String
    {
        return NSStringFromClass(PreludeCardCell.self)
    }
    
    static func estimatedRowHeight() -> CGFloat
    {
        return 120
    }
    
    static func register(in tableView: UITableView)
    {
        tableView.register(PreludeCardCell.self, forCellReuseIdentifier: PreludeCardCell.identifier())
    }
}

class CardListViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    private var cards: [Card] = []
    
    //need to reuse with identifier
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Loader()
        //PreludeCardLoader()
        self.cards = Loader.loadCardsFromDb()
    }
    
    func getImageFromType(tag: Tag) -> UIImage{
        return tag.rawValue.image()
    }
}

extension CardListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let card = self.cards[indexPath.row]
        
        if card.type == CardType.prelude {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PreludeCardCell.identifier(), for: indexPath) as? PreludeCardCell else
            {
                return tableView.dequeueReusableCell(withIdentifier: PreludeCardCell.identifier(), for: indexPath)
            }
            
            //set id and name
            cell.cardName.text = "\(card.cardId) \(card.name)"
            //set tags with images
            
            cell.cardName.backgroundColor = UIColor.purple
            
            for i in 0 ..< card.tags.count{
                if i == 0 { //set tag1
                    cell.tag1.isHidden = false
                    cell.tag1.image = self.getImageFromType(tag: card.tags[i])
                    
                }else if i == 1{ // set tag2
                    cell.tag2.isHidden = false
                    cell.tag2.image = self.getImageFromType(tag: card.tags[i])
                }else if i == 2{ // set tag3
                    cell.tag3.isHidden = false
                    cell.tag3.image = self.getImageFromType(tag: card.tags[i])
                }else { //set tag4
                    cell.tag4.isHidden = false
                    cell.tag4.image = self.getImageFromType(tag: card.tags[i])
                }
            }
            
            cell.des.text = card.result.des
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier(), for: indexPath) as? CardCell else
        {
            return tableView.dequeueReusableCell(withIdentifier: CardCell.identifier(), for: indexPath)
        }
        
        //set backgroud color
        
        switch card.type {
        case .project(let p):
            switch p{
            case .active:
                cell.cardName.backgroundColor = UIColor.blue
            case .automated:
                cell.cardName.backgroundColor = UIColor.green
            case .event:
                cell.cardName.backgroundColor = UIColor.orange
            }
        case .prelude:
            cell.cardName.backgroundColor = UIColor.purple
        default:
            cell.cardName.backgroundColor = UIColor.blue
        }
        
        //set id and name
        cell.cardName.text = "\(card.cardId) \(card.name)"
        //set tags with images
        
        for i in 0 ..< card.tags.count{
            if i == 0 { //set tag1
                cell.tag1.isHidden = false
                cell.tag1.image = self.getImageFromType(tag: card.tags[i])
                
            }else if i == 1{ // set tag2
                cell.tag2.isHidden = false
                cell.tag2.image = self.getImageFromType(tag: card.tags[i])
            }else if i == 2{ // set tag3
                cell.tag3.isHidden = false
                cell.tag3.image = self.getImageFromType(tag: card.tags[i])
            }else { //set tag4
                cell.tag4.isHidden = false
                cell.tag4.image = self.getImageFromType(tag: card.tags[i])
            }
        }
        //set cost value
        cell.cost.text = "\(card.cost)"
        //set requirment 
        cell.requirement.text = "\(card.requirements.des)"
        return cell
        
        //http://www.fryxgames.se/TerraformingMars/TMRULESFINAL.pdf
    }
}

public extension String
{
    /**
     Return the UIImage based on its name(String), bundle and traitCollection.
     */
    public func image(in bundle: Bundle? = Bundle.main, compatibleWith traitCollection: UITraitCollection? = nil) -> UIImage
    {
        guard let img = UIImage(named: self, in: bundle, compatibleWith: traitCollection) else {
            // return an empty image as default.
            return UIImage()
        }
        
        return img
    }
    
}


