//
//  ViewControllerProtocol.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 10/04/21.
//

import Foundation

protocol ViewControllerProtocol {
    func setup()
    func closureSetup()
    func delegateSetup()
    func getContentSetup()
    func targetsSetup()
    func additionalSetup()
}

extension ViewControllerProtocol{
    func setup(){
        closureSetup()
        delegateSetup()
        getContentSetup()
        targetsSetup()
        additionalSetup()
    }
}
