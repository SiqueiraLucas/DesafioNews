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
            
            let sut = SigninViewModel()
            
            //MARK: - Request Sucess
            
            context("NetworkRequestSucess") {
                let networkRequest = NetworkRequestPostMock()
                sut.networkRequest = networkRequest
                sut.sendValue(emailTextField: "lucas@teste.com", passwordTextField: "123")
                
                it("Request Sucess") {
                    expect(networkRequest.status).to(equal("Sucess"))
                }
            }
            
            context("NetworkRequestError") {
                let networkRequest = NetworkRequestPostMock()
                sut.networkRequest = networkRequest
                
                it("Invalid Email") {
                    sut.sendValue(emailTextField: "lucas.com", passwordTextField: "123")
                    expect(networkRequest.status).to(equal("Invalid Email"))
                }

                it("Invalid Password") {
                    sut.sendValue(emailTextField: "lucas@teste.com", passwordTextField: "")
                    expect(networkRequest.status).to(equal("Invalid Password"))
                }
            }
        }
    }
}
