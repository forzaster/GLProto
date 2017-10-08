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
    private let mPublishSubject = PublishSubject<PHAsset>()

    init() {
    }

    func prepare() {
        PHPhotoLibrary.requestAuthorization({[weak self] status in
            guard let s = self else {
                return
            }
            switch status {
            case .authorized:
                s.fetchAll()
            case .denied:
                s.denied()
            case .notDetermined:
                print("NotDetermined")
            case .restricted:
                print("Restricted")
            }
        })
    }

    func observable() -> Observable<PHAsset> {
        return mPublishSubject
    }

    private func fetchAll() {
        let assets = PHAsset.fetchAssets(with: .image, options: nil)
        assets.enumerateObjects({[weak self] (asset, index, stop) -> Void in
            guard let s = self else {
                return
            }
            s.mPhotoAssets.append(asset)
            s.mPublishSubject.onNext(asset)
            if (index == assets.count - 1) {
                s.mPublishSubject.onCompleted()
            }
        })
    }

    private func denied() {
    }
}
