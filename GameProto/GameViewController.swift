//
//  GameViewController.swift
//  GameProto
//
//  Created by n-naka on 2016/12/26.
//  Copyright © 2016年 n-naka. All rights reserved.
//

import GLKit
import OpenGLES

class GameViewController: GLKViewController {
    
    private var context: EAGLContext? = nil
    private var mGLMain: OC_GLMain? = nil
    private var mPhotosModel: PhotosModel = PhotosModel()
    
    deinit {
        self.tearDownGL()
        
        if EAGLContext.current() === self.context {
            EAGLContext.setCurrent(nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.context = EAGLContext(api: .openGLES2)
        self.context = EAGLContext(api: .openGLES3)
        
        if !(self.context != nil) {
            print("Failed to create ES context")
        }
        
        let view = self.view as! GLKView
        view.context = self.context!
        view.drawableDepthFormat = .format24
        
        mPhotosModel.prepare()
        
        self.setupGL()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        if self.isViewLoaded && (self.view.window != nil) {
            self.view = nil
            
            self.tearDownGL()
            
            if EAGLContext.current() === self.context {
                EAGLContext.setCurrent(nil)
            }
            self.context = nil
        }
    }
    
    func setupGL() {
        EAGLContext.setCurrent(self.context)
        
        let size: CGSize = UIScreen.main.nativeBounds.size
        mGLMain = OC_GLMain(width: Int32(size.width), height: Int32(size.height))
    }
    
    func tearDownGL() {
        EAGLContext.setCurrent(self.context)
    }
    
    // MARK: - GLKView and GLKViewController delegate methods
    
    @objc func update() {
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        mGLMain?.draw()
    }
}
