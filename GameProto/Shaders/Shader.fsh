//
//  Shader.fsh
//  GameProto
//
//  Created by n-naka on 2016/12/26.
//  Copyright © 2016年 n-naka. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
