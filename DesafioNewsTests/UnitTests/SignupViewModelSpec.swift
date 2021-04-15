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
                
                it("should request Sucess") {
                    expect(networkRequest.status).to(equal("Sucess"))
                }
            }
            
            context("NetworkRequestError") {
                let networkRequest = NetworkRequestPostMock()
                sut.networkRequest = networkRequest
                
                it("should invalid Email") {
                    sut.sendValue(nameTextField: "Lucas", emailTextField: "lucas.com", passwordTextField: "123")
                    expect(networkRequest.status).to(equal("Invalid Email"))
                }

                it("should invalid Password") {
                    sut.sendValue(nameTextField: "L", emailTextField: "lucas@teste.com", passwordTextField: "")
                    expect(networkRequest.status).to(equal("Invalid Password"))
                }

                it("should invalid Name") {
                    sut.sendValue(nameTextField: "", emailTextField: "lucas@teste.com", passwordTextField: "123")
                    expect(networkRequest.status).to(equal("Invalid Name"))
                }
            }
        }
    }
}
