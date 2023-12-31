# PacGet

一款使用 Bash/Batch 实现的 Windows 平台包管理器。

## 特性

+ [X] 基本的安装/卸载
+ [X] 添加/移除 桌面快捷方式
+ [X] 插入/移除 环境变量 (Path)
+ [X] 添加/移除 环境变量
+ [X] 添加/移除 文件关联
+ [X] 添加/移除 右键菜单 (Open with XXX)
+ [ ] 添加/移除 开机自启
+ [ ] 添加/移除 服务
+ [ ] 搜索包内文件
+ [ ] 查看 APP 信息

## 使用

此包管理器提供两种安装软件的方式。

### 双击 `repo\pkg-name_ver.bat` 安装

如果启用了 UAC，需要手动同意权限。

### 使用 `pacget` 命令安装

TODO.

## FAQ

### 为什么使用 Bash 实现

使用 Busybox 中的 Bash，仅用 600K 的大小，更是能使用 100 多个工具，不用自己实现一遍。

### 为什么使用 PowerShell 实现

唯一原因就是个人不想使用 PowerShell。当然本工具部分功能调用 PowerShell 实现，
比如 `创建桌面快捷方式` 功能。

## 历史

因为主力系统不是 Windows，为了方便一键安装配置各种环境，用 Batch 为常用软件写了一个批量安装脚本，
随着软件越来越多，脚本里很多重复的代码，于是将它独立成模块。每次也不是安装所有软件，
于是每个软件都有一个安装脚本，根据自身情况调用各模块。

虽然将其一定程度模块化了，但很多东西都写死了，不方便扩展，而且只用 Batch 相实现更多功能愈发困难，
得不断引入外部工具，索性直接引入 BusyBox 使用 Bash 实现。
