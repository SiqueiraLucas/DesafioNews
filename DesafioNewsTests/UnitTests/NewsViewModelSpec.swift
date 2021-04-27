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
        
        let sut = SpotlightViewModel(model: NewsModel(), apiRequestKey: "")
        sut.networkRequest = NetworkRequestMock()
        
        describe("NetworkRequest") {
            guard let networkRequest = sut.networkRequest as? NetworkRequestMock else {
                expect(false).to(beTrue())
                return
            }
            
            //MARK: - Request Call
            
            context("NetworkRequestCall") {
                sut.request(components: nil)
                
                it("should arguments correct"){
                    expect(networkRequest.responseType).to(beAKindOf(NewsModel.Type.self))
                    expect(networkRequest.method).to(equal(RequestMethod.get))
                    expect(networkRequest.endpoint).to(equal("https://mesa-news-api.herokuapp.com/v1/client/news/highlights"))
                    expect(networkRequest.components).to(beNil())
                    expect(networkRequest.key).toNot(beNil())
                }
            }
            
            //MARK: - Request Sucess
            
            context("NetworkRequestSucess") {
                sut.request(components: nil)
                
                it("should request Sucess") {
                    expect(networkRequest.status).to(equal("Sucess"))
                }
                
                it("should return Correct Title") {
                    let title = sut.returnTitle(index: 0)
                    expect(title).to(equal("News 1 title"))
                }
                
                it("should return Correct Description") {
                    let description = sut.returnDescription(index: 0)
                    expect(description).to(equal("News 1 description"))
                }
                
                it("should return Correct Date") {
                    let date = sut.returnDate(index: 0)
                    expect(date).to(equal("30/01/2020"))
                }
                
                it("should return Favorite Is Hidden") {
                    let isHidden = sut.returnFavoriteIsHidden(index: 0)
                    expect(isHidden).to(equal(true))
                }
                
                it("should return Url") {
                    let url = sut.returnUrl(index: 0)
                    expect(url).to(equal("https://fake.news"))
                }
                
                it("should return Image Url") {
                    let imageUrl = sut.returnImageUrl(index: 0)
                    expect(imageUrl).to(equal("https://via.placeholder.com/600x300"))
                }
                
                it("should return countItems") {
                    let countItems = sut.countItems
                    expect(countItems).to(equal(4))
                }
            }
            
            //MARK: - Request Error
            
            context("NetworkRequestError") {
                let sut = SpotlightViewModel(model: NewsModel(), apiRequestKey: "")
                sut.networkRequest = NetworkRequestMock(endpointMock: "")
                guard let networkRequest = sut.networkRequest as? NetworkRequestMock else {return}
                sut.request(components: nil)
                
                it("should request error") {
                    expect(networkRequest.status).to(equal("Invalid Url"))
                }
            }
        }
    }
}
