把PEMaterial目录复制到磁盘分区根目录即可，不需要修改WIM内核，启动系统后自动加载。

外置加载时:
将 Program Files 复制到 X:\Program Files               (弹出设备后**仍可**使用)
为 Installers 中的程序创建 安装的快捷方式              (弹出设备后**无法**安装)
为 PortableApps 中的程序创建快捷方式，程序注册关联等   (弹出设备后**无法**使用)

=================================================================================

Copy the PEMaterial directory to the disk partition root directory, do not need to modify the WIM file, it will be loaded automatically on booting.

When external loading:
Copy the 'Program Files' folder to X:\Program Files (they can **still be used** even the device was ejected)
Create shortcut(s) to the Installer(s) for program(s) in 'Installers' folder (they **cannot be installed** if the device was ejected)
Create shortcut(s) for programs in 'PortableApps' folder, also you can do associations for programs and any action. (they **cannot be used** if the device was ejected)
