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
        
        let sut = SigninViewModel()
        sut.networkRequest = NetworkRequestMock()
        
        describe("NetworkRequest") {
            guard let networkRequest = sut.networkRequest as? NetworkRequestMock else {
                expect(false).to(beTrue())
                return
            }
            
            //MARK: - Request Call
            
            context("NetworkRequestCall") {
                sut.sendValue(emailTextField: "lucas@teste.com", passwordTextField: "123")
                
                it("should arguments correct"){
                    expect(networkRequest.responseType).to(beAKindOf(Bearer.Type.self))
                    expect(networkRequest.method).to(equal(RequestMethod.post))
                    expect(networkRequest.endpoint).to(equal("https://mesa-news-api.herokuapp.com/v1/client/auth/signin"))
                    expect(networkRequest.components).toNot(beNil())
                    expect(networkRequest.key).to(beNil())
                }
            }
            
            //MARK: - Request Sucess
            
            context("NetworkRequestSucess") {
                sut.sendValue(emailTextField: "lucas@teste.com", passwordTextField: "123")
                
                it("should request Sucess") {
                    expect(networkRequest.status).to(equal("Sucess"))
                }
            }
            
            //MARK: - Request Error
            
            context("NetworkRequestError") {
                it("should invalid Email") {
                    sut.sendValue(emailTextField: "lucas.com", passwordTextField: "123")
                    expect(networkRequest.status).to(equal("Invalid Email"))
                }

                it("should invalid Password") {
                    sut.sendValue(emailTextField: "lucas@teste.com", passwordTextField: "")
                    expect(networkRequest.status).to(equal("Invalid Password"))
                }
            }
        }
    }
}
