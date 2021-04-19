//
//  WebViewControllerSpec.swift
//  DesafioNewsTests
//
//  Created by Lucas Siqueira on 19/04/21.
//

import Quick
import Nimble
@testable import DesafioNews

class WebViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        let sut = WebViewController(urlString: "www.url", newsTitle: "NewsWeb")
        
        // MARK: Functions
        
        describe("Functions") {
            _ = sut.view
            
            context("favoriteButtonAction") {
                sut.isFavorite = true
                sut.favoriteButtonAction(sender: nil)
                
                it("should modify isFavorite") {
                    expect(sut.isFavorite).to(beFalse())
                }
            }
            
            context("shareButtonAction") {
                let sharer = SharerMock()
                sut.sharer = sharer
                sut.shareButtonAction(sender: nil)
                
                it("should share link") {
                    guard let url = sharer.content as? String else{expect(false).to(beTrue()); return}
                    expect(sharer.presentCalled).to(beTrue())
                    expect(sut.urlString).to(equal(url))
                    expect(sharer.viewController == sut).to(beTrue())
                }
            }
        }
        
        // MARK: View Controller Protocol
        
        describe("ViewControllerProtocol") {
            context("getContentSetup") {
                sut.getContentSetup()
                let image = UIImage(systemName: "heart")
                
                it("should set correct favorite button image") {
                    expect(sut.favoriteButton.image).to(equal(image))
                }
                
                it("should load webView") {
                    sut.getContentSetup()
                    expect(sut.webView.isLoading).to(beTrue())
                }
            }
            
            context("targetSetup") {
                sut.targetsSetup()
                
                it("should add targets") {
                    expect(sut.favoriteButton.target).to(beAKindOf(WebViewController.self))
                    expect(sut.shareButton.target).to(beAKindOf(WebViewController.self))
                }
            }
            
            context("additionalSetup") {
                sut.additionalSetup()
                let navigationItems = [sut.shareButton, sut.fixedSpace, sut.favoriteButton]
                
                it("should setup sharer") {
                    expect(sut.sharer).to(beAKindOf(SharerLink.self))
                }
                
                it("should configure navigation space") {
                    expect(sut.fixedSpace.width).to(equal(UIScreen.main.bounds.width/3.3))
                }
                
                it("should add navigation buttons") {
                    expect(sut.navigationItem.rightBarButtonItems).to(equal(navigationItems))
                }
            }
        }
    }

}
