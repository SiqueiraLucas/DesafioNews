//
//  NewsViewSpec.swift
//  DesafioNewsTests
//
//  Created by Lucas Siqueira on 11/04/21.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import DesafioNews

class NewsViewSpec: QuickSpec{
    
    override func spec() {
        describe("NewsView") {
            context("Elementos da SpotlightCell"){
                it("Estão posicionados corretamente") {
                    let frame = CGRect(x: 0, y: 0, width: 375, height: 300)
                    let view = SpotlightCell(frame: frame)
                    
                    expect(view) == snapshot("SpotlightCell")
                }
            }
            
            context("Elementos da FeedCell"){
                it("Estão posicionados corretamente") {
                    let frame = CGRect(x: 0, y: 0, width: 375, height: 100)
                    let view = FeedCell(frame: frame)
                    
                    expect(view) == snapshot("FeedCell")
                }
            }
        }
    }
}
