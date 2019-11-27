# AJAppEvent

## 安装

```ruby
pod 'AJAppEvent'
```

## 类说明

`NSObject+AJAppEvent`

生命周期监听类

`AJAppEventModel`

生命周期方法回调对象

## 示例

```
[self ajAddObserverName:name block:^(AJAppEventModel * _Nonnull eventModel) {
        NSLog(@"%@", eventModel.name);
    }];
```



## 作者

xujiebing, xujiebing1992@gmail.com
