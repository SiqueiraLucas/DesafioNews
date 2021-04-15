//
//  SpotlightViewModelSpec.swift
//  DesafioNewsTests
//
//  Created by Lucas Siqueira on 14/04/21.
//

import Quick
import Nimble
@testable import DesafioNews

class NewsViewModelSpec: QuickSpec{
    
    override func spec() {
        
        describe("SpotlightViewModel") {
            
            let sut = NewsViewModel(model: NewsModel())
            
            //MARK: - Request Sucess
            
            context("NetworkRequestSucess") {
                let networkRequest = NetworkRequestGetMock()
                sut.networkRequest = networkRequest
                sut.request(endpoint: "NewsJson.json", components: nil)
                
                it("Request Sucess") {
                    expect(networkRequest.status).to(equal("Sucess"))
                }
                
                it("Return Correct Title") {
                    let title = sut.returnTitle(index: 0)
                    expect(title).to(equal("News 1 title"))
                }
                
                it("Return Correct Description") {
                    let description = sut.returnDescription(index: 0)
                    expect(description).to(equal("News 1 description"))
                }
                
                it("Return Correct Date") {
                    let date = sut.returnDate(index: 0)
                    expect(date).to(equal("30/01/2020"))
                }
                
                it("Return Favorite Is Hidden") {
                    let isHidden = sut.returnFavoriteIsHidden(index: 0)
                    expect(isHidden).to(equal(true))
                }
                
                it("Return Url") {
                    let url = sut.returnUrl(index: 0)
                    expect(url).to(equal("https://fake.news"))
                }
                
                it("Return Image Url") {
                    let imageUrl = sut.returnImageUrl(index: 0)
                    expect(imageUrl).to(equal("https://via.placeholder.com/600x300"))
                }
            }
            
            //MARK: - Request Error
            
            context("NetworkRequestError") {
                let networkRequest = NetworkRequestGetMock()
                sut.networkRequest = networkRequest
                sut.request(endpoint: "None", components: nil)
                
                it("Request Error") {
                    expect(networkRequest.status).to(equal("Invalid Url"))
                }
            }
        }
    }
}
