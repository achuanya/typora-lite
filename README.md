> 该主题是一比一像素级还原Claude官网markdown渲染，该主题和Typora Theme上的山寨claude主题不一样，该主题真正的实现了一比一还原，各位可以利用审查元素对照 `cladue.ai` 上的每一个像素和元素，相似度可以达到99%，所有的配色全部予以还原！
> 诸君可粘贴任意在claude中生成的内容到typora中，不会看出任何瑕疵，分不清两者，哪怕放大到任意一个像素点都是对齐的，没有夸张的哦。<!--当然，如果你能使用到2026-04以前的claude的话-->

本主题为了美观取消了很多按钮，不过都可以通过快捷键实现。

1. 取消了左小角的侧边栏收展按钮和切换源码模式的按钮。
3. 取消了大部分水平滚动条。

如何设置快捷键：

1. 打开设置里的高级设置。

2. 找到 `conf.user.json` 并打开。

3. 可以参考我的快捷键（MAC系统`系统设置 / 系统偏好设置 → 键盘 → 键盘快捷键 → App 快捷键 → + → 选择 Typora.app`）：
   ```json
     // Custom key binding, which will override the default ones.
     // see https://support.typora.io/Shortcut-Keys/#windows--linux for detail
     "keyBinding": {
       // for example: 
       // "Always on Top": "Ctrl+Shift+P"
       // All other options are the menu items 'text label' displayed from each typora menu
       "Inline Math": "Ctrl+M"	//行内数学公式
       "Comment": "Ctrl+L"	//注释
       "Toggle SIdebar": "Alt+`"	//收展侧边栏
       "Select Styled Scope": "Ctrl+D"
       "Select Word": "Ctrl+E"
       "Highlight": "Ctrl+O"	//高亮（下波浪线）
       "Redo": "Ctrl+Alt+Z"        
     },
   ```

   <!--放在最外层花括号之间就行-->

还修改了一些Claude主题没有的东西：

1. 取消了 **粗体和斜体** 的 `*` 显示（我觉得很难看），不喜欢可以找到相应代码删掉。
2. 将 **高亮** 样式改为了下波浪线：==就像是这样==。（如果你没有在设置开启则看不到）。
3. 修改了YAML头样式，风格为泛黄的牛皮信签纸，贴合claude的设计理念。

#### 关于Claude源码泄露前后的前端改版

大概四月份前后，Claude官网的前端配色发生了微调，整体背景颜色偏亮了。而本系列主题是在2026-4之前制作，所以该主题保留了原来的前端风格，将来也不打算与官网同步了（Claude前端设计师因该是脑抽了，更新后的亮色主题简直一坨），但是新版的暗色主题有可取之处，我会之后会融入。

----

有兴趣可一起参与优化，交流群：747699182。

#### 发布新版本

仓库内提供了 `release.ps1` 自动发布脚本。发布前先把新版本文件放进本仓库，并在 `更新内容.md` 里添加对应版本说明，例如：

```md
## V5.6

1. 新增内容...
```

然后在 PowerShell 中运行：

```powershell
cd C:\Users\Blaxisomu\Desktop\codex-work\git\CLAUDE-Typora
.\release.ps1 -Version 5.6 -ZipPath "C:\Users\Blaxisomu\Desktop\codex-work\git\claude-Typora-5.6.zip"
```

脚本会自动提交当前改动、创建 `v5.6` 标签、推送到 GitHub，并创建 Release，附件默认命名为 `claude-theme-5.6.zip`。

> [!TIP]
>
> 根目录建议为英文（这样能用得上我准备的英文书写体），建议缩放为120%（有奇效，喜欢的可以试一下）。

> [!NOTE]
>
> A4纸尺寸每行会少一个字，但这不影响任何阅读，只是与编辑区视图的行宽不一致而已，如果自定义页面大小为220mmX297mm将会完美适配，在不进行打印时导出PDF很好。
>
> 220mm可能是完整显示与编辑区一致行宽的最小宽度，再向上加宽已经不影响内容排版，只是增加PDF两侧的空白区域
