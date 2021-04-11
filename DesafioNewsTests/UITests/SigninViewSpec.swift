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
        describe("SgninView") {
            context("Elementos da SigninView"){
                it("Estão posicionados corretamente") {
                    // X
                    let frame = CGRect(x: 0, y: 0, width: 375, height: 812)
                    // SE
    //                let frame = CGRect(x: 0, y: 0, width: 320, height: 568)
                    let view = SigninView(frame: frame)
                    
                    // verifica se imagem está igual à imagem salva
                    expect(view) == snapshot("SigninView")
                    
                    // salva uma nova imagem
//                    expect(view) == recordSnapshot("SigninView")
                }
            }
        }
    }
}
