#  TODO
- [ ] 隐藏起来Dock栏图标—— 不太需要，显示`AboutView`的话应该需要有程序坞图标；或者让用户自己调节
- [ ] 从Control Center获取输入法的图标并显示在App中
- [ ] 设置应用图标
- [ ] 在GitHub发布
- [ ] AboutView
- [ ] 在About中添加Support按钮并跳转至网页 Support 链接到自己的主页，可以加个pay pal的二维码？
- [ ] 中文翻译
- [ ] README 写上用到的开源项目和LISENCE
- [ ] 其他语言环境（如中文）下的测试

**Older**

- [x] `26cd7e6 - add applescript to switch input sources` 自动读取当前的输入键盘，显示在App上
- [x] `5d2cc1c - rewitre ViewModel` 每次启动App的时候自己reset一下（应该在ViewModel里面就可以搞）
- [x] `5d2cc1c - rewitre ViewModel` 添加退出按钮
- [x] `5d2cc1c - rewitre ViewModel` cmd R 快捷键 Reset
- [x] `d0812db - add KeyboardShortcuts` 将用户配置存储到user defaults里面（输入法和用户设置的快捷键），只有reset的时候才更新user defaults （使用的插件KeyboardShortcuts可以记录快捷键；自己写的获取思路是每次App打开都获取，比存储起来还好一点）
- [x] `d0812db - add KeyboardShortcuts` 添加全局快捷键设置
- [x] `71aea07 - refactor applescript` Add LICENSE
- [x] `562d782 - add AboutView`提醒请在更换输入法之后reset——Click to `Reset` (⌘R) or `Quit` (⌘Q) to Restart app[change to App new name] after you change `Input Sources` in `System Preferences -> Keyboard`.
- [x] `de3423f - add About menu bar` 在菜单栏关联About按钮
- [x] `3195f1b - change to menu bar app and refactor data structure and modle` 让应用常驻后台
- [x] `3195f1b - change to menu bar app and refactor data structure and modle` 给应用添加menu bar（右上角） 点击打开主窗口
**Newer**
