//
//  PhotosModel.swift
//  GameProto
//
//  Created by n-naka on 2017/10/08.
//  Copyright © 2017年 forzaster. All rights reserved.
//

import Foundation
import Photos

class PhotosModel {
    
    private var mPhotoAssets: [PHAsset] = []
    
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
    
    private func fetchAll() {
        let assets = PHAsset.fetchAssets(with: .image, options: nil)
        assets.enumerateObjects({[weak self] (asset, index, stop) -> Void in
            guard let s = self else {
                return
            }
            s.mPhotoAssets.append(asset)
            NSLog("fetchAll " + String(index));
        })
    }
    
    private func denied() {
        
    }
}
