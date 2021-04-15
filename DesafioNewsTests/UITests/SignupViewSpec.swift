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
            context("Elements"){
                let frame = CGRect(x: 0, y: 0, width: 375, height: 812)
                let view = SignupView(frame: frame)
                
                it("InformationContainer") {
                    let informationContainer = view.signupInformationContainer
                    expect(informationContainer) == snapshot("SignupInformationContainer")
                }
                
                it("AllElements") {
                    expect(view) == snapshot("SignupView")
                }
            }
        }
    }
}
