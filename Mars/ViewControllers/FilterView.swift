//
//  FilterView.swift
//  TestProject
//
//  Created by Alex Liu on 2018-09-23.
//  Copyright © 2018 Alex Liu. All rights reserved.
//

import UIKit


protocol FilterViewProtocol: class {
    func filter(tags: [Tag], types: [CardType], accending: Bool)
}

class FilterView: UIView {
    
    public weak var delegate: FilterViewProtocol?
    
    override func awakeFromNib() {
        self.reset()
    }
    
    @IBAction func filterItemSelected(sender: UIButton){
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            sender.alpha = 1.0
        }else{
            sender.alpha = 0.5
        }
    }
    
    @IBAction func filter(){
       // self.isHidden = true
        
        let tags = self.getTagFilter()
        let types = self.getCardType()
        let accending = self.accending()
        
        self.delegate?.filter(tags: tags, types: types, accending: accending)
    }
    
    @IBAction func reset(){
        self.power.isSelected = false
        self.building.isSelected = false
        self.plant.isSelected = false
        self.space.isSelected = false
        self.microbe.isSelected = false
        self.earth.isSelected = false
        self.science.isSelected = false
        self.jovian.isSelected = false
        self.animal.isSelected = false
        self.city.isSelected = false
        self.event.isSelected = false
        self.wild.isSelected = false
        
        self.power.alpha = 0.5
        self.building.alpha = 0.5
        self.plant.alpha = 0.5
        self.space.alpha = 0.5
        self.microbe.alpha = 0.5
        self.earth.alpha = 0.5
        self.science.alpha = 0.5
        self.jovian.alpha = 0.5
        self.animal.alpha = 0.5
        self.city.alpha = 0.5
        self.event.alpha = 0.5
        self.wild.alpha = 0.5
        
        self.eventCardButton.alpha = 0.5
        self.greenCardButton.alpha = 0.5
        self.blueCardButton.alpha = 0.5
        self.preludeCardButton.alpha = 0.5
        
        self.blueCardButton.isSelected = false
        self.eventCardButton.isSelected = false
        self.greenCardButton.isSelected = false
        self.preludeCardButton.isSelected = false
        
        self.accendingButton.isSelected = true
        self.descendingButton.isSelected = false
    }
    
    //contain tag or all of them
    @IBOutlet weak var power: UIButton!
    @IBOutlet weak var building: UIButton!
    @IBOutlet weak var plant: UIButton!
    @IBOutlet weak var space: UIButton!
    @IBOutlet weak var microbe: UIButton!
    @IBOutlet weak var earth: UIButton!
    @IBOutlet weak var science: UIButton!
    @IBOutlet weak var jovian: UIButton!
    @IBOutlet weak var animal: UIButton!
    @IBOutlet weak var city: UIButton!
    @IBOutlet weak var venus: UIButton!
    @IBOutlet weak var event: UIButton!
    @IBOutlet weak var wild: UIButton!
    
    func getTagFilter() -> [Tag] {
        var tags: [Tag] = []
        
        if self.power.isSelected { tags.append(.power) }
        if self.building.isSelected { tags.append(.building) }
        if self.plant.isSelected { tags.append(.plant) }
        if self.space.isSelected { tags.append(.space) }
        if self.microbe.isSelected { tags.append(.microbe) }
        if self.earth.isSelected { tags.append(.earth) }
        if self.science.isSelected { tags.append(.science) }
        if self.jovian.isSelected { tags.append(.jovian) }
        if self.animal.isSelected { tags.append(.animal) }
        if self.city.isSelected { tags.append(.city) }
        //if self.venus.isSelected { tags.append(.venus) }
        if self.event.isSelected { tags.append(.event) }
        if self.wild.isSelected { tags.append(.wild) }
        
        return tags
    }
    
    //has requirement
    @IBOutlet weak var requirementButton: UIButton!
    
    func requirementSelected() -> Bool {
        return self.requirementButton.isSelected
    }
    
    //type of event, blue, prelude, green
    @IBOutlet weak var eventCardButton: UIButton!
    @IBOutlet weak var greenCardButton: UIButton!
    @IBOutlet weak var blueCardButton: UIButton!
    @IBOutlet weak var preludeCardButton: UIButton!
    
    func getCardType() -> [CardType] {
        var types: [CardType] = []
        
        if self.eventCardButton.isSelected { types.append(.project(.event))}
        if self.greenCardButton.isSelected { types.append(.project(.automated))}
        if self.blueCardButton.isSelected { types.append(.project(.active))}
        if self.preludeCardButton.isSelected { types.append(.prelude)}
        
        return types
    }
    
    @IBAction func selectCardType(button: UIButton){
        button.isSelected = !button.isSelected
        
        if button.isSelected {
            button.alpha = 1.0
        }else{
            button.alpha = 0.5
        }
    }
    
    //MARK: order by cost
    @IBOutlet weak var accendingButton: UIButton!
    @IBOutlet weak var descendingButton: UIButton!
    
    func accending() -> Bool {
        return accendingButton.isSelected
    }
    
    func decending() -> Bool {
        return descendingButton.isSelected
    }
    
    @IBAction func orderAccending(){
        if self.accendingButton.isSelected {
            //make sure the other button is selected
            self.descendingButton.isSelected = false
        }else {
            self.accendingButton.isSelected = true
            self.descendingButton.isSelected = false
        }
    }
    
    @IBAction func orderDecending(){
        if descendingButton.isSelected {
            self.accendingButton.isSelected = false
        }else {
            self.descendingButton.isSelected = true
            self.accendingButton.isSelected = false
        }
    }
}
