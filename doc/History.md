# 更新历史记录

## WimBuilder2 v2019.11.11
这是一个主要更新。添加和改善了以下内容:

* 新增 Ghost15支持补丁。(_CustomFiles_\MyCustom_Samples\Requirements_Ghost15.bat)
* 修复 使用zh-TW系统源构建时，安全精简选项有效后无法登陆Administrator用户的问题。
* 修复 构建老版本(<17763)系统源时，部分系统文件没有提取问题。
* 修复 构建老版本系统源时，文件属性无法弹出问题。
* 新增 _CustomFiles_\MyCustom\Last目录，简易补丁可以放置在此目录，各补丁main.bat结束后调用。
* 新增 _NavPaneShowAllFolders.bat 文件夹选项设置。
* 新增 _NavPaneHideLibraries.bat 文件夹选项设置。
* 修复  无法从系统中复制文件到手机的问题(MTP)。
* 新增 精简选项(使用精简的imageres.dll)。
* 新增 _FileExplorerInSeparateProcess.bat，外壳与文件资源管理器作为独自进程运行。
* 改进 网络组件对老版本系统的支持。
* 新增 _HighPerformancePowerScheme.bat，电源管理中使用高性能模式。
* 新增 _CustomVisualEffects.reg，使用自定义视觉效果。
* 修复 StartIsBack在最新预览版中导致外壳程序崩溃的问题。
* 更新 设备与打印机组件，打印机功能支持到最新版。
* 新增 命令行接口，可通过自动构建，详细参数请输入--help进行查看。
* 改进 自定义补丁可制作复杂选项。
* 新增 7-zip界面，可以设置扩展名关联。
* 修复 不勾选网络支持时，防火墙没有禁用问题。
* 新增 _Assets_\style.css 文件，支持各补丁界面共同的式样定义。
* 新增 ImDisk虚拟磁盘驱动。
* 改进 多会话模式下对外壳进程进行守护。
* 新增 删除 wbem\Repository 精简选项。
* 新增 ISO设置界面，可以设置是否提示 "Press any key to boot from CD or DVD."。
* 改进 刪除 无效的BitLocker菜单。
* 改进 RNDIS功能在某些设备下无法正常工作的问题。
* 更新 【补丁】菜单改名为【定制】。
* 修复 在Administrator用户下访问资源管理器时，目录展开卡顿的问题。
* 其他细节更新。


## WimBuilder2 v2019.10.10
这是一个主要更新。添加和改善了以下内容:

* 新增 LinkToDesktop, LinkToStartMenu, PinToStartMenu, PinToTaskbar 宏命令。
* 新增 Startup\BeforeShell 目录接口，此目录下的脚本将在外壳程序启动前运行。
* 新增 【安全精简】 选项，刪除字体，其他国家地区键盘布局，迁移工具等不影响其他组件的系统文件。
* 新增 【移除ieframe.dll】选项。
* 新增 【移除WinRE系统故障修复程序(X:\sources)】选项。
* 修复 微软内置输入法 无法显示候选文字问题。
* 新增 对DRIVERS注册表处理选项，可自动识别加载系统自带驱动(如MTP，网卡驱动等)。
* 新增 RNDIS功能，USB连接手机可使用手机共享网络。
* 更新 同步WIN10XPE-2019-09-20更新内容。
* 修复 启用MSI功能时，无法进行管理员帐户登录问题。
* 改进 补丁选项默认值可在补丁目录中定义，不需要再各个预设清单中更新(补丁独立性增强)。
* 添加 我的主题(_CustomFiles_\MyTheme)补丁例子，可自定义不同主题式样，壁纸，音效，开机音乐等。
* 改进 管理员用户登录，及启动初始化脚本分解，使得不同启动管理器共用。
* 新增 自定义管理员名选项。
* 新增 资源精简处理例子(za-Slim\SlimResources)，移除Display.dll, themecpl.dll且不影响功能。
* 更新 使用系统自身机制解决20H1之后无法管理员用户无法加载用户设定问题。
* 修复 20H1之后BitLocker解锁菜单无法自动识别问题。
* 修复 打印机组件无法正常使用问题。(<=17763的版本, 可以使用内置和第三方打印机)
* 修复 20H1之后文本文档无法直接打开，以及没有新建文本文档问题。
* 更新 vendor\WinXShell为4.2版本。
* 新增 随WinXShell 4.2新增的Session管理功能，实现多用户自由切换功能(SYSTEM<=>管理员帐户)。
* 新增 随WinXShell 4.2更新，新增【文件及文件夹选项】设定(显示/不显示隐藏文件，显示/不显示已知扩展名)。
* 新增 WinXShell设置页面。(启用UI_Volume，启用UI_WIFI选项)
* 新增 系统托盘网络，声音图标显示选项。
* 改进 老版本Win10(v1607 长期服务分支 (LTSB) 14393)构建支持。(感谢 liuzhaoyzz 测试与反馈)
* 更新 vendor\StartIsBack为2.8.9版本。
* 新增 doc\History.txt本说明文件。

## WimBuilder2 v2019.09.01.1c7003cc
