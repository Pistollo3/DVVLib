//
//  GHSuperWifiManager.swift
//  DVVLib
//
//  Created by Daniele Viscuso on 22/11/21.
//

import Foundation
import RxSwift
import RxCocoa
import GigaHubC

enum OnboardingStatus {
    case onboarding, dashboard
}

public class GHSuperWifiManager {
    public static var shared = GHSuperWifiManager()
    var onboardingSubject = BehaviorRelay<OnboardingStatus>(value: .onboarding)
    
    init() {}
    
    func startOnboarding(){
        let n = mySampleFunc()
        onboardingSubject.accept(.dashboard)
    }
    
    func subscribeToOnboarding() -> Observable<OnboardingStatus> {
        return onboardingSubject.asObservable()
    }
    
    
    
}
