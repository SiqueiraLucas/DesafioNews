//
//  SigninViewModelSpec.swift
//  DesafioNewsTests
//
//  Created by Lucas Siqueira on 15/04/21.
//

import Quick
import Nimble
@testable import DesafioNews

class SigninViewModelSpec: QuickSpec{
    
    override func spec() {
        
        describe("SigninViewModel") {
            
            let sut = SigninViewModel(networkRequest: NetworkRequestPostMock())
            let networkRequest = sut.networkRequest as? NetworkRequestPostMock
            
            //MARK: - Request Sucess
            
            context("NetworkRequestSucess") {
                sut.sendValue(emailTextField: "lucas@teste.com", passwordTextField: "123")
                
                it("should request Sucess") {
                    expect(networkRequest?.status).to(equal("Sucess"))
                }
            }
            
            context("NetworkRequestError") {
                it("should invalid Email") {
                    sut.sendValue(emailTextField: "lucas.com", passwordTextField: "123")
                    expect(networkRequest?.status).to(equal("Invalid Email"))
                }

                it("should invalid Password") {
                    sut.sendValue(emailTextField: "lucas@teste.com", passwordTextField: "")
                    expect(networkRequest?.status).to(equal("Invalid Password"))
                }
            }
        }
    }
}
