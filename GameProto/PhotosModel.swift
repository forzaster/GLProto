//
//  PhotosModel.swift
//  GameProto
//
//  Created by n-naka on 2017/10/08.
//  Copyright © 2017年 forzaster. All rights reserved.
//

import Foundation
import Photos
import RxSwift

class PhotosModel {

    private var mPhotoAssets: [PHAsset] = []
    private var mObservable: Observable<PHAsset>?

    init() {
    }

    func start(callback: @escaping (PHAuthorizationStatus) -> Void) {
        if (mObservable == nil) {
            mObservable = Observable<PHAsset>.create({observer in
                NSLog("Observable start " + String(describing:Thread.current))
                let assets = PHAsset.fetchAssets(with: .image, options: nil)
                assets.enumerateObjects({[weak self] (asset, index, stop) -> Void in
                    guard let s = self else {
                        return
                    }
                    NSLog(String(index) + " get : " + String(describing:Thread.current))
                    s.mPhotoAssets.append(asset)
                    observer.onNext(asset)
                    if (index == assets.count - 1) {
                        observer.onCompleted()
                    }
                })
                NSLog("Observable done " + String(describing:Thread.current))
                return Disposables.create()
            })
            .subscribeOn(SerialDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
        }

        PHPhotoLibrary.requestAuthorization({[weak self] status in
            guard let _ = self else {
                return
            }
            callback(status)
        })
    }

    func observable() -> Observable<PHAsset> {
        return mObservable!
    }
}
