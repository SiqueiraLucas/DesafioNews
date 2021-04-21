//
//  NewsCollectionViewSpec.swift
//  DesafioNewsTests
//
//  Created by Lucas Siqueira on 18/04/21.
//

import Quick
import Nimble
@testable import DesafioNews

class NewsCollectionViewSpec: QuickSpec {
    
    override func spec() {
        
        let sut = NewsViewController(apiRequestKey: "")
        let newsData = NewsData(title: "Title", description: "Description", content: "Content", author: "Author", published_at: "2020-01-30T13:45:00.000Z", highlight: false, url: "www.modelUrl", image_url: "https://image.cnbcfm.com/api/v1/image/106422372-1583253995153rtx7ashh.jpg?v=1583254080")
        sut.spotlightViewModel = NewsViewModel(model: NewsModel(data: [newsData]), networkRequest: NetworkRequestMock(), apiRequestKey: "")
        sut.feedViewModel = FeedViewModel(model: NewsModel(data: [newsData, newsData]), networkRequest: NetworkRequestMock(), apiRequestKey: "")
        
        describe("NewsCollectionView") {
            
            //MARK: Number Of Sections
            
            context("numberOfSections") {
                let numberOfSections = sut.numberOfSections(in: sut.newsView.collectionView)
                
                it("should have 2 section") {
                    expect(numberOfSections).to(equal(2))
                }
            }
            
            context("numberOfItemsInSection") {
                let numberOfSpotlightCells = sut.collectionView(sut.newsView.collectionView, numberOfItemsInSection: 0)
                let numberOfFeedCells = sut.collectionView(sut.newsView.collectionView, numberOfItemsInSection: 1)
                
                it("should have 1 cell") {
                    expect(numberOfSpotlightCells).to(equal(1))
                }
                
                it("should have 2 cells") {
                    expect(numberOfFeedCells).to(equal(2))
                }
            }
            
            //MARK: Cell For Item
            
            context("cellForItem") {
                guard let spotlightCell = sut.collectionView(sut.newsView.collectionView, cellForItemAt: IndexPath(item: 0, section: 0)) as? SpotlightCell else {return}
                guard let feedCell = sut.collectionView(sut.newsView.collectionView, cellForItemAt: IndexPath(item: 0, section: 1)) as? FeedCell else {return}
                
                it("should configure spotlight cell") {
                    expect(spotlightCell.title.text).to(equal("Title"))
                    expect(spotlightCell.subtitle.text).to(equal("Description"))
                    expect(spotlightCell.date.text).to(equal("30/01/2020"))
                    expect(spotlightCell.imageView.image != nil).toEventually(beTrue())
                }
                
                it("should configure feed cell") {
                    expect(feedCell.title.text).to(equal("Title"))
                    expect(feedCell.subtitle.text).to(equal("Description"))
                    expect(feedCell.date.text).to(equal("30/01/2020"))
                    expect(feedCell.imageView.image != nil).toEventually(beTrue())
                }
            }
            
            //MARK: Did Select Item
            
            context("didSelectItemAt") {
                let controllerPresenter = ViewControllerPresenterMock()
                sut.viewControllerPresenter = controllerPresenter
                
                it("should present WebViewController of Spotlight") {
                    sut.collectionView(sut.newsView.collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
                    
                    guard let webController = controllerPresenter.toViewController as? WebViewController else {
                        expect(false).to(beTrue())
                        return
                    }
                    
                    expect(controllerPresenter.presentCalled).toEventually(beTrue())
                    expect(controllerPresenter.fromViewController).toEventually(equal(sut))
                    expect(controllerPresenter.toViewController).toEventually(beAKindOf(WebViewController.self))
                    expect(webController.newsTitle).to(equal("Title"))
                    expect(webController.urlString).to(equal("www.modelUrl"))
                }
                
                it("should present WebViewController of Feed") {
                    let controllerPresenter = ViewControllerPresenterMock()
                    sut.viewControllerPresenter = controllerPresenter
                    sut.collectionView(sut.newsView.collectionView, didSelectItemAt: IndexPath(item: 0, section: 1))
                    
                    guard let webController = controllerPresenter.toViewController as? WebViewController else {
                        expect(false).to(beTrue())
                        return
                    }
                    
                    expect(controllerPresenter.presentCalled).toEventually(beTrue())
                    expect(controllerPresenter.fromViewController).toEventually(equal(sut))
                    expect(controllerPresenter.toViewController).toEventually(beAKindOf(WebViewController.self))
                    expect(webController.newsTitle).to(equal("Title"))
                    expect(webController.urlString).to(equal("www.modelUrl"))
                }
            }
            
            //MARK: Will Display Cell
            
            context("willDisplayCell") {
                guard let cell = sut.newsView.collectionView.dequeueReusableCell(withReuseIdentifier: "SpotlightCell", for: IndexPath(row: 0, section: 1)) as? SpotlightCell else {
                    expect(false).to(beTrue())
                    return
                }
                let networkRequest = NetworkRequestMock()
                sut.feedViewModel.networkRequest = networkRequest
                sut.collectionView(sut.newsView.collectionView, willDisplay: cell, forItemAt: IndexPath(row: -8, section: 1))
                let isAnimating = sut.newsView.activityIndicator.isAnimating
                
                it("should stop animation activityIndicator") {
                    expect(isAnimating).to(beFalse())
                }
                
                it("should request new data") {
                    expect(networkRequest.requestCalled).to(beTrue())
                }
            }
        }
    }

}
