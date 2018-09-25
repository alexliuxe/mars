//
//  FilterView.swift
//  TestProject
//
//  Created by Alex Liu on 2018-09-23.
//  Copyright © 2018 Alex Liu. All rights reserved.
//

import UIKit

class FilterView: UIView {
    
    @IBAction func filterItemSelected(sender: UIButton){
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func dismiss(){
        self.isHidden = true
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
        if self.venus.isSelected { tags.append(.venus) }
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
    
    //order by cost
    @IBOutlet weak var accendingButton: UIButton!
    @IBOutlet weak var descendingButton: UIButton!
    
    func accending() -> Bool {
        return accendingButton.isSelected
    }
}
