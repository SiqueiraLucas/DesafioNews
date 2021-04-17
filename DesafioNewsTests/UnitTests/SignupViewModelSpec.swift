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
        
        let sut = SignupViewModel(networkRequest: NetworkRequestPostMock())
        
        describe("NetworkRequest") {
            let networkRequest = sut.networkRequest as? NetworkRequestPostMock
            
            context("NetworkRequestSucess") {
                sut.sendValue(nameTextField: "L", emailTextField: "lucas@teste.com", passwordTextField: "123")
                
                it("should request Sucess") {
                    expect(networkRequest?.status).to(equal("Sucess"))
                }
            }
            
            context("NetworkRequestError") {
                it("should invalid Email") {
                    sut.sendValue(nameTextField: "Lucas", emailTextField: "lucas.com", passwordTextField: "123")
                    expect(networkRequest?.status).to(equal("Invalid Email"))
                }

                it("should invalid Password") {
                    sut.sendValue(nameTextField: "L", emailTextField: "lucas@teste.com", passwordTextField: "")
                    expect(networkRequest?.status).to(equal("Invalid Password"))
                }

                it("should invalid Name") {
                    sut.sendValue(nameTextField: "", emailTextField: "lucas@teste.com", passwordTextField: "123")
                    expect(networkRequest?.status).to(equal("Invalid Name"))
                }
            }
        }
    }
}
