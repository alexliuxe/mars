//
//  PreludeCardLoader.swift
//  TestProject
//
//  Created by Alex Liu on 2018-09-23.
//  Copyright © 2018 Alex Liu. All rights reserved.
//

import Foundation

class PreludeCardLoader {
    
    init() {
        
        var cards: [Card] = []
        var card = Card()
        card.cardId = "P01"
        card.name = "Allied Bank"
        card.tags = [.earth]
        card.result = [.resources(Operation.increase, Resources.money, ResourceType.production, Target.myself, number: 4),
        .resources(Operation.increase, Resources.money, ResourceType.resource, Target.myself, number: 3)]
        card.type = .prelude
        cards.append(card)
        
        //(Place an ocean tile. Increase your energy production 2 steps. Remove 3 M$.)
        card.cardId = "P02"
        card.name = "Aquifer Turbines"
        card.tags = [.power]
        card.result = [.resources(Operation.increase, Resources.ocean, .resource, .myself, number: 1),
        .resources(Operation.increase, .energy, .production, .myself, number: 2),
        .resources(Operation.decrease, .money, .resource, .myself, number: 3)]
        card.type = .prelude
        cards.append(card)
        
//        <br />(Increase your <span style="background-color: #51FF00;"><span style="color: #000000;">plant</span></span> production and energy production 1 step each. Gain 2 <span style="background-color: #51FF00;"><span style="color: #000000;">plant</span></span>s.)
        card.cardId = "P03"
        card.name = "Biofuels"
        card.tags = [.microbe]
        card.result = [.resources(.increase, .plant, ResourceType.production, .myself, number: 1),
                       .resources(.increase, .energy, .production, .myself, number: 1),
                       .resources(.increase, .plant, .resource, .myself, number: 1)]
        card.type = .prelude
        cards.append(card)
//        <br />(Increase your <span style="background-color: #51FF00;"><span style="color: #000000;">plant</span></span> production 1 step. Draw 3 cards.)
        card.cardId = "P04"
        card.name = "Biolab"
        card.tags = [.science]
        card.result = [.resources(.increase, .plant, .production, .myself, number: 1),
                       .resources(.increase, .card, .resource, .myself, number: 3)]
        card.type = .prelude
        cards.append(card)
//        <br />(Decrease your M$ production 1 step. Increase your <span style="background-color: #51FF00;"><span style="color: #000000;">plant</span></span> production 2 steps.)
        card.cardId = "P05"
        card.name = "Biosphere Support"
        card.tags = [.plant]
        card.result = [.resources(.increase, .money, .production, .myself, number: 1),
                       .resources(.increase, .plant, .production, .myself, number: 2)]
        card.type = .prelude
        cards.append(card)
        

//        <br />(Increase your M$ production 6 steps. Remove 6 M$.)
        card.cardId = "P06"
        card.name = "Business Empire"
        card.tags = [.earth]
        card.result = [.resources(.increase, .money, .production, .myself, number: 6),
                       .resources(.decrease, .money, .resource, .myself, number: 6)]
        card.type = .prelude
        cards.append(card)
//       <br />(Increase your <span style="background-color: #51FF00;"><span style="color: #000000;">plant</span></span> production 1 step. Increase your M$ production 2 steps.)
        card.cardId = "P07"
        card.name = "Dome Farming"
        card.tags = [.plant,.building]
        card.result = [.resources(.increase, .plant, .production, .myself, number: 1),
                       .resources(.increase, .money, .production, .myself, number: 2)]
        card.type = .prelude
        cards.append(card)
//        <br />(Gain 21 M$.)
        card.cardId = "P08"
        card.name = "Donation"
        card.tags = []
        card.result = [.resources(.increase, .money, .resource, .myself, number: 21)]
        card.type = .prelude
        cards.append(card)
        
        //<br />(Place a <span style="background-color: #7C7C7C;"><span style="color: #FFFFFF;">city</span></span> tile. Increase your <span style="background-color: #51FF00;"><span style="color: #000000;">plant</span></span> production 1 step.)
        card.cardId = "P09"
        card.name = "Early Settlement"
        card.tags = [.city, .building]
        card.result = [.resources(.increase, .city, .resource, .myself, number: 1),
                       .resources(.increase, .plant, .production, .myself, number: 1)]
        card.type = .prelude
        cards.append(card)
//        <br />(Increase your <span style="background-color: #51FF00;"><span style="color: #000000;">plant</span></span> production 1 step.)
//***PLAY A CARD FROM HAND, IGNORING GLOBAL REQUIREMENTS
        card.cardId = "P10"
        card.name = "Ecology Experts"
        card.tags = [.plant, .microbe]
        card.result = [.resources(.increase, .plant, .production, .myself, number: 1)]
        card.type = .prelude
        card.resultDes = "PLAY A CARD FROM HAND, IGNORING GLOBAL REQUIREMENTS"
        cards.append(card)
        //<br />PLAY A CARD FROM HAND, REDUCING ITS COST BY 25 M$
        card.cardId = "P11"
        card.name = "Excentric Sponsor"
        card.tags = []
        card.result = []
        card.type = .prelude
        card.resultDes = "PLAY A CARD FROM HAND, REDUCING ITS COST BY 25 M$"
        cards.append(card)
//        <br />(Place a greenery tile and increase oxygen 1 step. Reveal cards from the deck until you have revealed 2 <span style="background-color: #51FF00;"><span style="color: #000000;">plant</span></span>-tag cards. Take these into your hand, and discard the rest.)

        card.cardId = "P12"
        card.name = "Experimental Forest"
        card.tags = [.plant]
        card.result = [.resources(.increase, .greeneryTile, .resource, .myself, number: 1),
                       .resources(.increase, .oxygen, .resource, .myself, number: 1),
                       .resources(.increase, .card, .resource, .myself, number: 2)]
        card.type = .prelude
        cards.append(card)
        
        //<br />(Increase your titanium production 2 steps. Remove 5 M$.)

        card.cardId = "P13"
        card.name = "Galilean Mining"
        card.tags = [.jovian]
        card.result = [.resources(.increase, .titanium, .resource, .myself, number: 2),
                       .resources(.decrease, .money, .resource, .myself, number: 5)]
        card.type = .prelude
        cards.append(card)
        
        //<br />Ocean Tile Ocean Tile
        card.cardId = "P14"
        card.name = "Great Aquifer"
        card.tags = []
        card.result = [.resources(.increase, .ocean, .resource, .myself, number: 2)]
        card.type = .prelude
        cards.append(card)
        //<br />(Raise temperature 3 steps. Remove 5 M$.)
        card.cardId = "P15"
        card.name = "Huge Asteroid"
        card.tags = []
        card.result = [.resources(.increase, .temprature, .resource, .myself, number: 3),
                       .resources(.decrease, .money, .resource, .myself, number: 5)]
        card.type = .prelude
        cards.append(card)
        
        //<br />(Increase your titanium production 1 step. Draw 1 card.)
        card.cardId = "P16"
        card.name = "Io Research Outpost"
        card.tags = [.science, .jovian]
        card.result = [.resources(.increase, .titanium, .production, .myself, number: 1),
                       .resources(.increase, .card, .resource, .myself, number: 1)]
        card.type = .prelude
        cards.append(card)
        
        //<br />(Decrease your M$ production 2 steps. Gain 30 M$.)

        card.cardId = "P17"
        card.name = "Loan"
        card.tags = []
        card.result = [.resources(.decrease, .money, .production, .myself, number: 2),
                       .resources(.increase, .money, .resource, .myself, number: 30)]
        card.type = .prelude
        cards.append(card)
        //<br />(Increase your energy production and steel production 1 step each. Gain 6 M$.)

        card.cardId = "P18"
        card.name = "Martian Industries"
        card.tags = [.building]
        card.result = [.resources(.increase, .building, .production, .myself, number: 1),
                       .resources(.increase, .energy, .production, .myself, number: 1),
                       .resources(.increase, .money, .resource, .myself, number: 6)]
        card.type = .prelude
        cards.append(card)
        //<br />(Raise temperature 1 step. Gain 4 titanium, and 4 steel.)

        card.cardId = "P19"
        card.name = "Metal-Rich Asteroid"
        card.tags = []
        card.result = [.resources(.increase, .temprature, .resource, .myself, number: 1),
                       .resources(.increase, .titanium, .resource, .myself, number: 4),
                       .resources(.increase, .building, .resource, .myself, number: 4)]
        card.type = .prelude
        cards.append(card)
        //<br />(Increase your M$ production, steel production, and titanium production 1 step each.)

        card.cardId = "P20"
        card.name = "Metals Company"
        card.tags = []
        card.result = [.resources(.increase, .money, .production, .myself, number: 1),
                       .resources(.increase, .building, .production, .myself, number: 1),
                       .resources(.increase, .titanium, .production, .myself, number: 1)]
        card.type = .prelude
        cards.append(card)
        //<br />(Increase your steel production 2 steps. Gain 4 steel.)

        card.cardId = "P21"
        card.name = "Mining Operations"
        card.tags = [.building]
        card.result = [.resources(.increase, .building, .production, .myself, number: 2),
                       .resources(.increase, .building, .resource, .myself, number: 4)]
        card.type = .prelude
        cards.append(card)
        //<br />(Increase your heat production 3 steps. Gain 3 heat.)

        card.cardId = "P22"
        card.name = "Mohole"
        card.tags = [.building]
        card.result = [.resources(.increase, .heat, .production, .myself, number: 3),
                       .resources(.increase, .heat, .production, .myself, number: 3)]
        card.type = .prelude
        cards.append(card)
        //<br />(Increase your steel production 1 step, and your heat production 2 steps. Gain 2 heat.)

        card.cardId = "P23"
        card.name = "Mohole Excavation"
        card.tags = [.building]
        card.result = [.resources(.increase, .building, .production, .myself, number: 1),
                       .resources(.increase, .heat, .production, .myself, number: 2),
                       .resources(.increase, .heat, .resource, .myself, number: 2)]
        card.type = .prelude
        cards.append(card)
        
//        <br />(Raise your terraform rating 1 step. Increase your <span style="background-color: #51FF00;"><span style="color: #000000;">plant</span></span> production 1 step. Gain 5 M$.)

        card.cardId = "P24"
        card.name = "Nitrogen Shipment"
        card.tags = []
        card.result = [.resources(.increase, .tr, .resource, .myself, number: 1),
                       .resources(.increase, .plant, .production, .myself, number: 1),
                       .resources(.increase, .money, .resource, .myself, number: 5)]
        card.type = .prelude
        cards.append(card)
        
        //<br />(Increase your titanium production 1 step. Gain 4 titanium.)

        card.cardId = "P25"
        card.name = "Orbital Construction Yard"
        card.tags = [.space]
        card.result = [.resources(.increase, .titanium, .production, .myself, number: 1),
                       .resources(.increase, .titanium, .resource, .myself, number: 4)]
        card.type = .prelude
        cards.append(card)
        //<br />(Place 1 ocean tile. Increase your heat production 2 steps.)

        card.cardId = "P26"
        card.name = "Polar Industries"
        card.tags = [.building]
        card.result = [.resources(.increase, .ocean, .resource, .myself, number: 1),
                       .resources(.increase, .heat, .production, .myself, number: 2)]
        card.type = .prelude
        cards.append(card)
        //<br />(Increase your energy production 3 steps.)

        card.cardId = "P27"
        card.name = "Power Generation"
        card.tags = [.power]
        card.result = [.resources(.increase, .energy, .production, .myself, number: 3)]
        card.type = .prelude
        cards.append(card)
        
        //<br />(Draw 3 cards, and increase your M$ production 1 step. After being played, when you perform an action, the <span style="background-color: #660066;"><span style="color: #FFFFFF;">wild</span></span>-tag is any tag of your choice.)

        card.cardId = "P28"
        card.name = "Research Network"
        card.tags = [.wild]
        card.result = [.resources(.increase, .card, .resource, .myself, number: 3),
                       .resources(.increase, .money, .production, .myself, number: 1)]
        card.type = .prelude
        card.resultDes = "After being played, when you perform an action, the wild-tag is any tag of your choice."
        cards.append(card)
//        <br />(Place a <span style="background-color: #7C7C7C;"><span style="color: #FFFFFF;">city</span></span> tile. Increase your M$ production 2 steps.)

        card.cardId = "P29"
        card.name = "Self-Sufficient Settlement"
        card.tags = [.city, .building]
        card.result = [.resources(.increase, .city, .resource, .myself, number: 1),
                       .resources(.increase, .money, .production, .myself, number: 2)]
        card.type = .prelude
        cards.append(card)
//        <br />(Raise oxygen 2 steps. Gain 5 steel.)

        card.cardId = "P30"
        card.name = "Smelting Plant"
        card.tags = [.building]
        card.result = [.resources(.increase, .oxygen, .resource, .myself, number: 2),
                       .resources(.increase, .building, .resource, .myself, number: 5)]
        card.type = .prelude
        cards.append(card)
//        <br />(Decrease your M$ production 1 step. Increase your <span style="background-color: #51FF00;"><span style="color: #000000;">plant</span></span> production, energy production, and heat production 1 step each)

        card.cardId = "P31"
        card.name = "Society Support"
        card.tags = [.plant]
        card.result = [.resources(.decrease, .money, .production, .myself, number: 1),
                       .resources(.increase, .plant, .production, .myself, number: 1),
                       .resources(.increase, .energy, .production, .myself, number: 1),
        .resources(.increase, .heat, .production, .myself, number: 1)]
        card.type = .prelude
        cards.append(card)
//        <br />(Increase your energy production 2 steps. Gain 4 steel.)

        card.cardId = "P32"
        card.name = "Supplier"
        card.tags = [.power]
        card.result = [.resources(.increase, .energy, .production, .myself, number: 2),
                       .resources(.increase, .building, .resource, .myself, number: 4)]
        card.type = .prelude
        cards.append(card)
//        <br />(Gain 3 titanium, 8 steel, and 3 <span style="background-color: #51FF00;"><span style="color: #000000;">plant</span></span>s.)

        card.cardId = "P33"
        card.name = "Supply Drop"
        card.tags = []
        card.result = [.resources(.increase, .titanium, .resource, .myself, number: 3),
                       .resources(.increase, .building, .resource, .myself, number: 8),
                       .resources(.increase, .plant, .resource, .myself, number: 3)]
        card.type = .prelude
        cards.append(card)
//        <br />(Raise your terraform rating 3 steps. Draw 1 card.)

        card.cardId = "P34"
        card.name = "UNMI Contractor"
        card.tags = [.earth]
        card.result = [.resources(.increase, .tr, .resource, .myself, number: 3),
                       .resources(.increase, .card, .resource, .myself, number: 1)]
        card.type = .prelude
        cards.append(card)
//        <br />(Gain 6 titanium. Reveal cards from the deck until you have revealed 2 <span style="background-color: #000000;"><span style="color: #FFFFFF;">space</span></span> cards. Take those into hand, and discard the rest.)

        card.cardId = "P35"
        card.name = "Acquired Space Agency"
        card.tags = []
        card.result = [.resources(.increase, .titanium, .resource , .myself, number: 6),
                       .resources(.increase, .card, .resource, .myself, number: 2)]
        card.type = .prelude
        card.resultDes = "Reveal cards from the deck until you have revealed 2"
        cards.append(card)
        //store to db
        
        Storage.store(cards, to: .documents, as: "prelude.json")

    }
}
