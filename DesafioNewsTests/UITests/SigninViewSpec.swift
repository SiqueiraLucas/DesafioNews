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
            context("Elements"){
                let frame = CGRect(x: 0, y: 0, width: 375, height: 812)
                let view = SigninView(frame: frame)
                
                it("InformationContainer") {
                    let informationContainer = view.signinInformationContainer
                    expect(informationContainer) == snapshot("SigninInformationContainer")
                }
                
                it("AllElements") {
                    expect(view) == snapshot("SigninView")
                }
            }
        }
    }
}
