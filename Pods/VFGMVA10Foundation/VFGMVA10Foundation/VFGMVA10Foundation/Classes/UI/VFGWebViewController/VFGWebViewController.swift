//
//  VFGWebViewController.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Abd ElNasser on 9/3/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit
import WebKit

public struct VFGWebViewModel {
    var urlString: String
    var scriptModel: VFGWebViewScriptModel?
    var webConfiguration: WKWebViewConfiguration?
    var shouldShowHeaderView: Bool?
    var title: String?

    public init(
        urlString: String,
        scriptModel: VFGWebViewScriptModel? = nil,
        webConfig: WKWebViewConfiguration? = nil,
        shouldShowHeaderView: Bool = true,
        title: String? = nil
    ) {
        self.urlString = urlString
        self.scriptModel = scriptModel
        self.webConfiguration = webConfig
        self.shouldShowHeaderView = shouldShowHeaderView
        self.title = title
    }
}

public struct VFGWebViewScriptModel {
    weak var handler: WKScriptMessageHandler?
    var scriptHandlerNames: [String]

    public init(handler: WKScriptMessageHandler?, scriptHandlerNames: [String]) {
        self.handler = handler
        self.scriptHandlerNames = scriptHandlerNames
    }
}

public protocol VFGWebViewDelegate: AnyObject {
    func close(sender viewController: VFGWebViewController)
    func didFinish(sender viewController: VFGWebViewController)
    func didStartProvisionalNavigation(sender viewController: VFGWebViewController)
    func didFailProvisionalNavigation(sender viewController: VFGWebViewController, withError error: Error)
    func didReceive(sender viewController: VFGWebViewController, challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
    func decidePolicyFor(sender viewController: VFGWebViewController, response: WKNavigationResponse, handler: @escaping (WKNavigationResponsePolicy) -> Void)
    func decidePolicyFor(sender viewController: VFGWebViewController, action: WKNavigationAction, handler: @escaping (WKNavigationActionPolicy) -> Void)
}

// MARK: redirections default
public extension VFGWebViewDelegate {
    func didFinish(sender viewController: VFGWebViewController) {
    }

    func didStartProvisionalNavigation(sender viewController: VFGWebViewController) {
    }

    func didFailProvisionalNavigation(sender viewController: VFGWebViewController, withError error: Error) {
    }

    func didReceive(sender viewController: VFGWebViewController, challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.performDefaultHandling, nil)
    }

    func decidePolicyFor(sender viewController: VFGWebViewController, response: WKNavigationResponse, handler: @escaping (WKNavigationResponsePolicy) -> Void) {
        handler(.allow)
    }

    func decidePolicyFor(sender viewController: VFGWebViewController, action: WKNavigationAction, handler: @escaping (WKNavigationActionPolicy) -> Void) {
        handler(.allow)
    }
}

public class VFGWebViewController: UIViewController {
    @IBOutlet weak var webViewContainer: UIView!
    @IBOutlet weak var pageHeaderLabel: VFGLabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var leadingConstraintRefreshButton: NSLayoutConstraint!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var topBarViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backButton: VFGButton!

    public lazy var webView = WKWebView()
    public weak var delegate: VFGWebViewDelegate?
    var viewModel: VFGWebViewModel?

    private var progressObservation: NSKeyValueObservation?
    private var titleObservation: NSKeyValueObservation?
    private let topViewHeight: CGFloat = 90

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        VFGWebViewManager.trackView()
    }

    private func observeTitleChanges() {
        if viewModel?.title != nil { return }
        titleObservation = webView.observe(\WKWebView.title, options: .new) { [weak self] webView, _ in
            if let title = webView.title {
                self?.pageHeaderLabel.text = title
                self?.pageHeaderLabel.accessibilityIdentifier = "WVpageTitle"
            }
        }
    }

    private func observeProgress() {
        progressObservation = webView.observe(\WKWebView.estimatedProgress, options: .new) { [weak self] webView, _ in
            self?.updateProgressBar(value: Float(webView.estimatedProgress))
        }
    }

    func updateProgressBar(value: Float) {
        progressView.progress = value
        if value >= 1 {
            progressView.isHidden = true
        } else {
            progressView.isHidden = false
        }
    }

    func setupView() {
        progressView.progress = 0
        progressView.isHidden = false

        let webViewFrame = CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.maxY - webViewContainer.frame.minY)

        guard let urlString = viewModel?.urlString,
            let url = URL(string: urlString) else {
            return
        }

        var configuration: WKWebViewConfiguration?
        if let viewModelConfiguration = viewModel?.webConfiguration {
            configuration = viewModelConfiguration
        }

        if let scriptModel = viewModel?.scriptModel, let handler = scriptModel.handler {
            if configuration == nil {
                configuration = WKWebViewConfiguration()
            }
            for name in scriptModel.scriptHandlerNames {
                configuration?.userContentController.add(handler, name: name)
            }
        }

        showHeaderView( viewModel?.shouldShowHeaderView ?? true)
        pageHeaderLabel.text = viewModel?.title

        if let webViewConfiguration = configuration {
            webView = WKWebView(frame: webViewFrame, configuration: webViewConfiguration)
        } else {
            webView = WKWebView(frame: webViewFrame)
        }

        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
        webViewContainer.addSubview(webView)

        pageHeaderLabel.font = .vodafoneRegular(19)
        pageHeaderLabel.textColor = .VFGPrimaryText

        observeProgress()
        observeTitleChanges()
        backButtonSetup()
    }

    deinit {
        self.titleObservation = nil
        self.progressObservation = nil
    }

    // MARK: private methods
    private func backButtonSetup() {
        let isHidden = !webView.canGoBack
        let backHiddenConstant = CGFloat(17)
        let backAvailableConstant = CGFloat(57)
        backButton.isHidden = isHidden
        leadingConstraintRefreshButton.constant = isHidden ?  backHiddenConstant : backAvailableConstant
        view.layoutSubviews()
    }

    private func showHeaderView(_ show: Bool) {
        topBarView.isHidden = !show
        topBarViewHeightConstraint.constant = show ? topViewHeight : 0
    }

    // MARK: Actions
    @IBAction func closeButton(_ sender: Any) {
        guard let delegate = delegate else {
            dismiss(animated: true)
            return
        }
        delegate.close(sender: self)
    }

    @IBAction func refreshButton(_ sender: Any) {
        webView.reload()
    }

    @IBAction func backButton(_ sender: Any) {
        webView.goBack()
    }
}


// swiftlint:disable implicitly_unwrapped_optional
extension VFGWebViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButtonSetup()
        delegate?.didFinish(sender: self)
    }

    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        delegate?.didStartProvisionalNavigation(sender: self)
    }

    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        delegate?.didFailProvisionalNavigation(sender: self, withError: error)
    }

    public func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let delegate = delegate else {
            completionHandler(.performDefaultHandling, nil)
            return
        }
        delegate.didReceive(sender: self, challenge: challenge, completionHandler: completionHandler)
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let delegate = delegate else {
            decisionHandler(.allow)
            return
        }
        delegate.decidePolicyFor(sender: self, response: navigationResponse, handler: decisionHandler)
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let delegate = delegate else {
            decisionHandler(.allow)
            return
        }
        delegate.decidePolicyFor(sender: self, action: navigationAction, handler: decisionHandler)
    }
}
