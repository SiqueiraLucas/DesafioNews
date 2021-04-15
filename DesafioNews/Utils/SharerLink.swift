//
//  SharerLink.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 14/04/21.
//

import UIKit

class SharerLink: SharerProtocol{
    
    func share(_ content: Any, on viewController: UIViewController) {
        guard let link = content as? String else {return}
        guard let url = URL(string: link) else {return}
        let messageToShare = "News App"
        let activityViewController = UIActivityViewController(activityItems: [messageToShare, url], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = viewController.view
        viewController.present(activityViewController, animated: true, completion: nil)
    }
    
    
}
