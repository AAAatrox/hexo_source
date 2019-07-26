---
title: live2d SDK WebGL 笔记
updated: 1555422461
date: 2019-04-06 17:50:02
tags:
 - live2d
 - html
 - javascript
---

## 工具

- Bracket
- vscode+live server(位置`~/.vscode/extensions`)

> `Live2D SDK WebGL 2.1.00`只支持2.0版本的模型

## 文件组织

```strace
webGL/-+-framework/---Live2DFramework.js
       |
       +-lib/---live2d.min.js
       |
       +-ReadMe.txt
       |
       `-sample/-+-simple/
                 |
                 +-SimpleMultiCanvas/
                 |
                 `-sampleApp1/
```

- `live2d.min.js`:一个几千行的匿名函数,创建`window`的全局变量

- `Live2DFramework.js`
 - (296)`L2DBaseModel.prototype.hitTestSimple`
 - (1274)`L2DTargetPoint.prototype.setPoint`
 - (1354)`L2DViewMatrix()`:计算位置
 - (1390)`L2DViewMatrix.prototype.setMaxScale`
 - (1398)`L2DViewMatrix.prototype.setMinScale`
 - (1406)`L2DViewMatrix.prototype.isMaxScale`
 - (1414)`L2DViewMatrix.prototype.isMinScale`

### sampleApp1

#### 文件组织

```
sampleApp1/-+-sampleApp1.html
            |
            +-assets/-+-image/
            |         |
            |         `-live2d/---${name}/-+-${name}.moc
            |                              |
            |                              +-${name}.model.json
            |                              |
            |                              +-textures/---${你的材质图}.png
            |                              |
            |                              +-modtions/---${动作}.mtn
            |                              | # 以下可选
            |                              +-expressions/---${没研究过}.json
            |                              |
            |                              +-sounds/--${你懂的}.mp3
            |                              |
            |                              +-${name}.physics # 不知道干嘛的
            |                              |
            |                              `-${name}.pose.json # 不知道干嘛的
            |
            `-src/-+-SampleApp1.js
                   |
                   +-LAppDefine.js
                   |
                   +-LAppLive2DManager.js
                   |
                   +-LAppModel.js
                   |
                   +-PlatformManager.js
                   |
                   `-utils/-+-MatrixStack.js
                            |
                            `-ModelSettingJson.js
```

#### 引用关系

 - html中`id`的引用关系

| `id` | 引用位置 |
| :--: | :--: |
| `drag_{num}`(可拖动元素) | `SampleApp1.js`,必须 |
| `glcanvas_{num}` | `PlatformManager.js`,`SampleApp.js`,必须 |
| `btnChange_{num}` | `SampleApp1.js`,必须 |

- `live2d.min.js`中声明的变量名引用情况

| 变量名 | 引用位置 |
| :--: | :--: |
| `UtSystem` | `Live2DFramework.js`,`LAppModel.js` |
| `UtDebug` | `Live2DFramework.js` |
| `LDTransform` |  |
| `LDGL` |  |
| `Live2D` | `Live2DFramework.js`,`LAppLive2DManager.js`,`SampleApp1.js`,必须 |
| `Live2DModelWebGL` | `PlatformManager.js`,必须 |
| `Live2DModelJS` |  |
| `Live2DMotion` | `live2d.min.js`,`Live2DFramework.js` |
| `MotionQueueManager` | `live2d.min.js`,`Live2DFramework.js`  |
| `PhysicsHair` | `Live2DFramework.js` |
| `AMotion` | `Live2DFramework.js` |
| `PartsDataID` | `Live2DFramework.js` |
| `DrawDataID` |  |
| `BaseDataID` |  |
| `ParamID` |  |

- `Live2DFramework.js`中声明的变量名引用情况

| 变量名 | 引用位置 |
| :--: | :--: |
| `L2DBaseModel` | `Live2DFramework.js`,`LAppModel.js` |
| `L2DExpressionMotion` | `Live2DFramework.js`,必须,如果不修改变量名,那么多重canvas的先加载者的第一个模型不能够响应鼠标点击事件 |
| `L2DExpressionParam` | `Live2DFramework.js` |
| `L2DEyeBlink` | `Live2DFramework.js`,`LAppModel.js` |
| `L2DMatrix44` | `Live2DFramework.js`,`SampleApp1.js` |
| `L2DModelMatrix` | `Live2DFramework.js` |
| `L2DMotionManager` | `Live2DFramework.js` |
| `L2DPhysics` | `Live2DFramework.js` |
| `L2DPose` | `Live2DFramework.js`,必须,否则canvas的第一个模型`Pose`会加载错误 |
| `L2DPartsParam` | `Live2DFramework.js` |
| `L2DTargetPoint` | `Live2DFramework.js`,`SampleApp1.js` |
| `L2DViewMatrix` | `Live2DFramework.js`,`SampleApp1.js` |
| `Live2DFramework.setPlatformManager` | `LAppLive2DManager.js`,必须 |
| `Live2DFramework.getPlatformManager` | `ModelSettingJson.js`,`LAppModel.js`,`Live2DFramework.js`,不详 |

- 其余js声明的变量名引用情况

| 变量名 | 引用位置 | 声明位置 |
| :--: | :--: | :--: |
| `LAppDefine` | `SampleApp1.js`,`LAppLive2DManager.js`,`LAppModel.js`,必须 | `LAppDefine.js` |
| `LAppLive2DManager` | `LAppLive2DManager.js`,`SampleApp1.js`,必须 | `LAppLive2DManager.js` |
| `LAppModel` | `LAppModel.js`,`LAppLive2DManager.js`,必须 | `LAppModel.js` |
| `PlatformManager` | `LAppLive2DManager.js`,`PlatformManager.js`,必须 | `PlatformManager.js` |
| `ModelSettingJson` | `ModelSettingJson.js`,`LAppModel.js`,必须 | `ModelSettingJson.js` |
| `MatrixStack` | `MatrixStack.js`,`LAppModel.js`,`SampleApp1.js` | `MatrixStack.js` |

- `SampleApp1.js`中的变量

| 对象名 | 引用 |
| :--: | :--: |
| `this.live2DMgr = new LAppLive2DManager();` | 必须 |
| `this.gl` |  |
| `this.dragMgr = new L2DTargetPoint();` | 必须,否则无法判定相对鼠标位置 |
| `this.viewMatrix = new L2DViewMatrix();` | 必须,单个放缩要用 |
| `this.projMatrix = new L2DMatrix44();` | 必须,计算画布大小要用 |
| `this.deviceToScreen = new L2DMatrix44();` |  |
| `this.drag` | 必须,否则无法判定相对鼠标位置 |
| `this.oldLen` |  |
| `this.lastMouseX`,`this.lastMouseY` |  |
| `this.isModelShown` | 必须,和按键刷新有关 |
| `this.canvas` | 必须,否则无法加载材质 |

- `SampleApp1.js`中的函数

| 函数名 | 引用位置 |
| :--: | :--: |
| `startDraw` | `SampleApp1.js`,必须 |
| ... | `SampleApp1.js`,必须(未验证) |
| `transform...` | 非必须,在刚加载的时候会有一堆报错,但不影响使用 |
| `getWebGLContext` | `PlatformManager.js`,必须,否则加载不出模型 |
| `l2dError` |  |

#### 文件说明

##### `LAppDefine.js`

- `var LAppDefine`:全局变量
 - `VIEW_MAX_SCALE`:最大倍数
 - `VIEW_MIN_SCALE`:最小倍数
 - ...
 - `BACK_IMAGE_NAME`:背景图
 - `MODEL_{NAME}`:模型名
 - `MOTION_GROUP_{EVENT}`:对应`motions`
 - `HIT_AREA_{AREA}`:对应`hit_areas`的`name`

##### `LAppLive2DManager.js`

- `LAppLive2DManager()`:初始化
- `LAppLive2DManager.prototype.createModel`:应该就是`this.createModel()`
- `LAppLive2DManager.prototype.changeModel`:切换模型的主体部分
- `LAppLive2DManager.prototype.getModel`
- `LAppLive2DManager.prototype.releaseModel`:应该是`this.releaseModel()`
- ...
- `LAppLive2DManager.prototype.tapEvent`:处理点击事件

##### `SampleApp1.js`

- ...
- `sampleApp1()`:每次加载1个模型之后初始化
- (42)`initL2dCanvas(canvasId)`:增加监听事件
- (73)`init()`
 - `this.deviceToScreen`:用于跟踪鼠标
 - `this.projMatrix.multScale`:比例放缩
 - `this.gl`:设置画图的画布
- ...
- `changeModel()`:`this.live2DMgr.count ++`(在`LAppLive2DManager.js`中`var no = parseInt(this.count % ${model_num})`)并调用`this.live2DMgr.changeModel(this.gl)`
- `modelScaling(scale)`
- (261)`followPointer(event)`:在得到`darg`之后调用`setPoint(x, y)`
- (284)`lookFront()`:刷新`drag`(默认是关闭鼠标点击事件),并重置头部方向(`Live2DFramework.js`的`setPoint(x, y)`)
- (294)`mouseEvent(e)`:判断鼠标的事件
- `touchEvent(e)`
- (384)`transformViewX(deviceX)`
- `transformViewY(deviceY)`
- `transformScreenX(deviceX)`
- (404)`transformScreenY(deviceY)`
- (411)`getWebGLContext`:选择绘制的canvas(但是不计算比例放缩)
- ...

##### `LAppModel.js`:主要是动作,表情的加载

- ...
- `LAppModel.prototype.setRandomExpression`
- `LAppModel.prototype.startRandomMotion`
- `LAppModel.prototype.startMotions`
- ...
- `LAppModel.prototype.setExpression`
- ...
- `LAppModel.prototype.hitTest(id, testX, testY)`:逐一判断点击部位的`name`,然后获取`id`,并返回`hitTestSimple(drawID, testX, testY)`

##### `PlatformManager.js`

- (56)`PlatformManager.prototype.loadModel`:如果次步出错,那么加载出来的模型是一团黑
- (71)`PlatformManager.prototype.loadTexture`

##### `MatrixStack.js`:看不懂在干嘛...

 - ...

##### `ModelSettingJson.js`

- ...
- `ModelSettingJson.prototype.getHitAreaNum`:获取`json`文件中`hit_areas`的项目个数
- `ModelSettingJson.prototype.getHitAreaID`:获取`json`文件中`hit_areas`中的`id`
- `ModelSettingJson.prototype.getHitAreaName`:获取...的`name`
- ...
- `ModelSettingJson.prototype.getMotionNum`:获取`json`文件中`mostions`的个数(待确定)
- `ModelSettingJson.prototype.getMotionFile`
- ...

## 文件合并顺序

- 可行方案1: `LAppDefine`->`live2d`->`LAppLive2DManager`->`Live2DFramework`->其他->`SampleApp1`
