//
//  SigninViewSpec.swift
//  DesafioNewsTests
//
//  Created by Lucas Siqueira on 09/04/21.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import DesafioNews

class SigninViewSpec: QuickSpec{
    
    override func spec() {
        describe("SigninView") {
            context("Elementos da SigninView"){
                it("Estão posicionados corretamente") {
                    let frame = CGRect(x: 0, y: 0, width: 375, height: 812)
//                    let frame = CGRect(x: 0, y: 0, width: 320, height: 568)
                    let view = SigninView(frame: frame)
                    
                    expect(view) == snapshot("SigninView")
                }
            }
        }
    }
}
