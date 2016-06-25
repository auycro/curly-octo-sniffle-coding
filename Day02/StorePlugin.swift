//
//  StorePlugin.swift
//  UnityPlugins
//
//  Copyright © 2016 Auycro. All rights reserved.
//
//  dependency: 
//    1. JSON("https://github.com/dankogai/swift-json")

import Foundation
import StoreKit

public class StorePlugin: NSObject, SKPaymentTransactionObserver, SKProductsRequestDelegate {
    private var request : SKProductsRequest!
    private var products : [SKProduct] = [] // List of available purchases
    private var productsArray = Array<SKProduct>()

    //CallByUnity
    public func initialize(input_json_string: String) {
        var json_string = input_json_string
        if json_string.isEmpty {
            json_string = loadProductIDString()
        }
        let json_data = JSON(string: json_string)
        
        var data_array = Set<String>()
        for item in json_data.asArray! {
            data_array.insert(item["pid"].asString!)
        }
        
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        // Get the list of possible purchases
        if self.request == nil {
            self.request = SKProductsRequest(productIdentifiers: data_array)
            self.request.delegate = self
            self.request.start()
        }
    }
    
    //CallByUnity
    public func getProductJson(){
        var json_string = ""
        json_string += "["
        for item in self.products{
            json_string += "{"
            json_string += "\"blah-blah-blah\":\""+item.productIdentifier+"\","
            json_string += "\"blah-blah-blah\":\""+String(item.price)+"\","
            json_string += "\"blah-blah-blah\":\""+item.description+"\","
            
            json_string += "}"
        }
    }
    
    //CallByUnity
    public func purchaseProductByName(pid: String){
        for item in self.products {
            if item.productIdentifier == pid {
                let payment = SKPayment(product: item)
                SKPaymentQueue.defaultQueue().addPayment(payment)
                break
            }
        }
        
    }
    
    func loadProductIDString() -> String{
        //init product
        var json_string = ""
        
        json_string = "[{\"pid\":\"jp.co.auycro.beginner_pack\"}," +
            "{\"pid\":\"jp.co.auycro.item1\"}," +
        "{\"pid\":\"jp.co.auycro.item2\"}]"
        
        //json_string = http_request()
        
        return json_string
    }
    
    public func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        self.products = response.products
        self.request = nil
        
        listProduct()
    }
    
    func listProduct(){
        // Add an alert action for each available product
        for product in products {
            print(product.localizedDescription)
        }
    }
    
    public func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch (transaction.transactionState) {
            case .Purchased:
                completeTransaction(transaction)
                break
            case .Failed:
                failedTransaction(transaction)
                break
            case .Restored:
                restoreTransaction(transaction)
                break
            case .Deferred:
                deferredTransaction(transaction)
                break
            case .Purchasing:
                break
            }
        }
    }
    
    private func completeTransaction(transaction: SKPaymentTransaction){
        print("Complete Transaction")
        SKPaymentQueue.defaultQueue().finishTransaction(transaction)
        //SendToUnity
    }
    
    private func restoreTransaction(transaction: SKPaymentTransaction){
        print("Restore Transaction")
        //SendToUnity
        SKPaymentQueue.defaultQueue().finishTransaction(transaction)
    }
    
    private func failedTransaction(transaction: SKPaymentTransaction){
        print("Failed Transaction")
        SKPaymentQueue.defaultQueue().finishTransaction(transaction)
    }
    
    private func deferredTransaction(transaction: SKPaymentTransaction){
        print("Deferred Transaction")
        //SendToUnity
    }
    
    public func canMakePayment() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
}
