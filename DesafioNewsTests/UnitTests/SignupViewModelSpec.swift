//
//  SignupViewModelSpec.swift
//  DesafioNewsTests
//
//  Created by Lucas Siqueira on 15/04/21.
//

import Quick
import Nimble
@testable import DesafioNews

class SignupViewModelSpec: QuickSpec{
    
    override func spec() {
        
        describe("SignupViewModel") {
            
            let sut = SignupViewModel()
            
            //MARK: - Request Sucess
            
            context("NetworkRequestSucess") {
                let networkRequest = NetworkRequestPostMock()
                sut.networkRequest = networkRequest
                sut.sendValue(nameTextField: "L", emailTextField: "lucas@teste.com", passwordTextField: "123")
                
                it("Request Sucess") {
                    expect(networkRequest.status).to(equal("Sucess"))
                }
            }
            
            context("NetworkRequestError") {
                let networkRequest = NetworkRequestPostMock()
                sut.networkRequest = networkRequest
                
                it("Invalid Email") {
                    sut.sendValue(nameTextField: "Lucas", emailTextField: "lucas.com", passwordTextField: "123")
                    expect(networkRequest.status).to(equal("Invalid Email"))
                }

                it("Invalid Password") {
                    sut.sendValue(nameTextField: "L", emailTextField: "lucas@teste.com", passwordTextField: "")
                    expect(networkRequest.status).to(equal("Invalid Password"))
                }

                it("Invalid Name") {
                    sut.sendValue(nameTextField: "", emailTextField: "lucas@teste.com", passwordTextField: "123")
                    expect(networkRequest.status).to(equal("Invalid Name"))
                }
            }
        }
    }
}
