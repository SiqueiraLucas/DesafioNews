//
//  SignupViewSpec.swift
//  DesafioNewsTests
//
//  Created by Lucas Siqueira on 10/04/21.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import DesafioNews

class SignupViewSpec: QuickSpec{
    
    override func spec() {
        describe("SignupView") {
            context("Elementos da SignupView"){
                it("Estão posicionados corretamente") {
                    let frame = CGRect(x: 0, y: 0, width: 375, height: 812)
                    let view = SignupView(frame: frame)
                    
                    expect(view) == snapshot("SignupView")
                }
            }
        }
    }
}
