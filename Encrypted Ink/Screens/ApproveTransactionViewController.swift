// Copyright © 2021 Encrypted Ink. All rights reserved.

import Cocoa

class ApproveTransactionViewController: NSViewController {
    
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet var metaTextView: NSTextView!
    @IBOutlet weak var okButton: NSButton!
    @IBOutlet weak var speedSlider: NSSlider!
    @IBOutlet weak var slowSpeedLabel: NSTextField!
    @IBOutlet weak var fastSpeedLabel: NSTextField!
    
    private let gasService = GasService.shared
    private var currentGasInfo: GasService.Info?
    private var transaction: Transaction!
    private var completion: ((Transaction?) -> Void)!
    private var didEnableSpeedConfiguration = false
    
    static func with(transaction: Transaction, completion: @escaping (Transaction?) -> Void) -> ApproveTransactionViewController {
        let new = instantiate(ApproveTransactionViewController.self)
        new.transaction = transaction
        new.completion = completion
        return new
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.stringValue = Strings.sendTransaction
        setSpeedConfigurationViews(enabled: false)
        updateInterface()
        prepareTransaction()
    }
    
    private func prepareTransaction() {
        Ethereum.prepareTransaction(transaction) { [weak self] updated in
            self?.transaction = updated
            self?.updateInterface()
        }
    }
    
    private func updateInterface() {
        enableSpeedConfigurationIfNeeded()
        let meta = transaction.meta
        if metaTextView.string != meta {
            metaTextView.string = meta
        }
    }
    
    private func enableSpeedConfigurationIfNeeded() {
        guard !didEnableSpeedConfiguration else { return }
        let newGasInfo = gasService.currentInfo
        guard transaction.hasFee, let gasInfo = newGasInfo else { return }
        didEnableSpeedConfiguration = true
        currentGasInfo = gasInfo
        speedSlider.doubleValue = transaction.currentGasInRelationTo(info: gasInfo)
        setSpeedConfigurationViews(enabled: true)
    }

    private func setSpeedConfigurationViews(enabled: Bool) {
        slowSpeedLabel.alphaValue = enabled ? 1 : 0.5
        fastSpeedLabel.alphaValue = enabled ? 1 : 0.5
        speedSlider.isEnabled = enabled
    }
    
    @IBAction func sliderValueChanged(_ sender: NSSlider) {
        guard let gasInfo = currentGasInfo else { return }
        transaction.setGasPrice(value: sender.doubleValue, inRelationTo: gasInfo)
        updateInterface()
    }
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        completion(transaction)
    }
    
    @IBAction func cancelButtonTapped(_ sender: NSButton) {
        completion(nil)
    }
    
}