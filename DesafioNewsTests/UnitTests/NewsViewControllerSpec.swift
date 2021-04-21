//
//  NewsViewControllerSpec.swift
//  DesafioNewsTests
//
//  Created by Lucas Siqueira on 18/04/21.
//

import Quick
import Nimble
@testable import DesafioNews

class NewsViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        let sut = NewsViewController(apiRequestKey: "")
        
        // MARK: View Controller Protocol
        
        describe("ViewControllerProtocol") {
            let sut = NewsViewController(apiRequestKey: "")
            _ = sut.view
            
            context("additionalSetup") {
                sut.additionalSetup()
                
                it("should have the title") {
                    expect(sut.title).to(equal("News"))
                }
                
                it("should correct presenters") {
                    expect(sut.messagePresenter).to(beAKindOf(MessagePresenter.self))
                    expect(sut.viewControllerPresenter).to(beAKindOf(ViewControllerPresenter.self))
                }
            }
            
            context("delegateSetup") {
                sut.delegateSetup()
                let collectionViewDelegate = sut.newsView.collectionView.delegate
                let collectionViewDataSource = sut.newsView.collectionView.dataSource
                let spotlightViewModelDelegate = sut.spotlightViewModel.delegate
                let feedViewModelDelegate = sut.feedViewModel.delegate
                
                it("should correct delegates") {
                    expect(collectionViewDelegate).to(beAKindOf(NewsViewController.self))
                    expect(collectionViewDataSource).to(beAKindOf(NewsViewController.self))
                    expect(spotlightViewModelDelegate).to(beAKindOf(NewsViewController.self))
                    expect(feedViewModelDelegate).to(beAKindOf(NewsViewController.self))
                }
            }
        }
        
        // MARK: View Model Delegate
        
        describe("ViewModelDelegate") {
            context("requestError") {
                let messagePresenter = MessagePresenterMock()
                sut.messagePresenter = messagePresenter
                sut.requestError(errorMessage: "Error message")
                
                it("should displayed message error") {
                    expect(messagePresenter.presentCalled).toEventually(beTrue())
                    expect(messagePresenter.message).toEventually(equal("Error message"))
                    expect(messagePresenter.viewController == sut).toEventually(beTrue())
                }
            }
        }
    }

}
