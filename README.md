[README.md](https://github.com/user-attachments/files/27866830/README.md)

# Quiet Serif

又名“ **静衬线** ”，一个为专注阅读、长文写作和 Markdown 编辑设计的 Typora 衬线主题。该主题注重温暖的纸张质感、安静的衬线排版、柔和的边框和低干扰的界面细节。作者通过两周的时间打磨细节、修复瑕疵，以追求最佳的写作体验，该主题已然臻入化境。

## 介绍

这是一款对 **Claude** 进行极致还原的 Typora 主题，其中Markdown内容的所有细节皆完美还原。基于设计风格，我们对软件的侧边栏、一体化和设置界面进行了深度适配，细致入微。

## 预览图

<img width="1389" height="888" alt="Snipaste_2026-05-17_13-59-35" src="https://github.com/user-attachments/assets/54c89ece-2ac5-4ab1-b8a4-ab01ba6ec5f1" /><img width="1389" height="888" alt="Snipaste_2026-05-17_14-00-23" src="https://github.com/user-attachments/assets/96836b53-e286-4509-945a-5281eb20efb2" />

## 预览视频

**文件树：**

https://github.com/user-attachments/assets/687dfe46-18fd-42f4-a03a-a9f85209f7e2



## 使用

1. 下载releases的第一个`zip` 文件，解压。
2. 全选并安装三个字体文件夹里所有的字体。
3. 将根目录中的两个`CSS` 文件拖入 Typora 主题文件夹中。
   *如何打开主题文件夹？*
   1. 打开软件中的偏好设置
   2. 找到外观
   3. `打开主题文件夹`

## 须知

### 内容

- **为了做到尽可能的简洁和美观，我们不得不去除了很多不必要的元素** 

  - 去除了收展侧边栏按钮

  - 去除了切换源码模式按钮

  - 隐藏了粗体、斜体、行内代码、高亮和下划线的特殊符

  - 隐藏了大部分水平滚动条

- **为了补全 Claude 中缺失的 Markdown 元素，我们做了如下变化**

  - 将暗色主题下的加粗由字重变化改为颜色变化[^1]
  - 将高亮改为下滑波浪线[^2]
  - 对 YAML 和 Callout 进行了主题适配

### 其他

- **关于MAC 系统**

  因为我没有这个东西，一些适配问题都是根据群友的反馈而做的，所以有关这方面的任何问题都可随时与我反馈。

- **关于软件版本**
  Windows平台：1.13.4及以上。

- **关于页宽**：*为什么我全屏之后两边会大片留白？*

  1. ==为了全量还原 Claude 网页==（理论页宽768px，最大页宽720px，最终页宽<720px）。

  2. 以下是AI整理的人类最舒适的页宽范围：

    |     用途      | 页宽       |
    | :-----------: | ---------- |
    |   长文阅读    | 680～740px |
    |   日常写作    | 640～700px |
    |   资料整理    | 700～780px |
    | 代码/表格较多 | 800～960px |

    **本主题采用的页宽刚好在黄金区间内，尽量覆盖到全场景，也就是 ` 678px` 。**

> [!NOTE]
>
> 水平滚动的快捷键是 `Shift+滚轮` ；粗体、斜体、行内代码、高亮和下划线的最佳实践：先选中再按快捷键。

### 设置快捷键

<!--以下流程可能只适用于Windows平台-->

1. 打开设置里的高级设置。

2. 找到 `conf.user.json` 并打开。

3. 可以参考我的快捷键：
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

### 关于字体

Claude 前端的字体是没有考虑到中文用户，因为（更新后）正文的中文字体的回退居然变为了非衬线体，而英文字体则使用它们自制的因为衬线体，所以该主题的中文字体选用了思源的衬线体以统一视觉。<!--Claude官方是没有自研的中文字体-->

仓库里的英文字体就是从它们的网页扒下来的，随便用。

## 建议

> [!TIP]
>
> 我的一些建议，或许能够优化你的体验：
>
> 1. 将缩放改为**120%** 
> 2. 外观模式改为**一体化**
> 3. 关闭代码快行号
> 4. 建议加qq群给我即时反馈和建议（github也可以）：**747699182**

## PDF打印

以预设的A4纸尺寸打印会比编辑区的行宽少一个字符，但这==完全不会出现任何排版错误==，仅仅与编辑区视图的行宽不一致而已。如果自定义页面大小为220mmX297mm将与编辑区的行宽完全一致，在不进行打印时导出PDF会很好。

220mm可能是完整显示与编辑区一致行宽的最小宽度，再向上加宽已经不影响内容排版，只是增加PDF两侧的空白区域。

----

[^1]: 暗色主题下的粗体十分不明显，如果把字体加粗则还有点伤眼，故由主题色代替字重变化。
[^2]: 荧光笔高亮会影响整体的纸质感，故改为下滑波浪线。

