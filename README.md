# Patpat 教程博客

> 这是 Patpat 平台教程博客的模板

## 快速开始

教程博客使用 [Hexo](https://hexo.io/) 搭建，采用 [Book](https://github.com/kaiiiz/hexo-theme-book) 主题。如有不清楚的地方，参考该仓库中的写法即可。

### 初始化项目

可以从该仓库开始，搭建新学期的教程博客。

`source/_posts` 中为已发布的教程，`source/_drafts` 中为草稿。搭建新学期教程博客时，可以先删除 `source/_posts` 中旧的教程，Lab 和迭代需要更新，部分教程可以保留，根据需要修改。

教程主页是 `source/home.md`，根据每年教学情况修改。每次更新教程后，记得同时更新教程目录 `source/menu.md`。

编辑 `config.yml` 更新基本信息，注意 `url` 中 IP 的更新。编辑 `_config.book.yml`，可根据需要更改 `author_img` 和 `favicon_url`，对应的图片位于 `themes/book/source` 目录。

安装依赖，使用 `npm install`。安装完成后，还需更新部分依赖，运行项目根目录的脚本。

```bash
.\patch.bat    # Windows
bash patch.sh  # Linux
```

### 文章概览

所有的 Lab 和迭代都移动至了平台，因此教程博客的内容就少一些，但根据以往课程经验，主要有以下几个内容：

- 教程主页：说明课程安排、成绩以及一些注意事项。
- 大作业要求：大作业**开始后**再发布，可以同时在平台发布公告提醒大家来看。
- 帮助文档：包括 Java 配置、语法特性的介绍，以及 Lab 报告模板等。现在可以将模板打包放在平台课程资源，然后贴链接在这里。
- 课程资料下载：将老师的 PPT，以及一些资料上传至平台，然后贴在这里供同学们下载。

由于有了平台，可以方便地将同学们可以下载的资源通过“资源管理”上传至平台，然后将链接复制，贴在博客页面供大家下载。

### 新建文章

新建文章首先新建草稿，完成编写后再发布，具体命令如下。

```bash
hexo new draft "title"
# edit article...
hexo publish draft "title"
```

本地编写时，可以使用 `hexo server --draft` 预览草稿。

草稿状态的文章在 `source/_drafts` 目录下，部署后不会被学生看到。未发布的教程**务必**保持草稿状态，避免学生提前看到。

Hexo 会自动为文章新建同名目录，存放图片资源等，如果不需要，可以删除该目录。

### 添加图片

在 Typora 中可以将图片保存位置更改为 `./${filename}` 从而自动使用 Hexo 创建的同名目录。支持 Markdown 和 HTML 语法。

### 插件

#### Admonition

通过 [hexo-admonition](https://www.lixl.cn/2020/041837756.html) 插件，可以支持漂亮的提示框，具体语法如下。

```md
!!! type
    content

```

> 注意必须严格使用 4 个英文空格缩进，结尾必须有空行。

支持的 type 如下。

- `note`：绿色
- `info, todo`：蓝色
- `warning, attention, caution`：橙色
- `error, failure, missing, fail`：红色

#### Collaspe Spoiler

通过 [hexo-tag-collapse-spoiler](https://github.com/ggehuliang/hexo-tag-collapse-spoiler) 可以支持文本框的展开与收起，语法如下。

```md
{% collapsecard %}
{% endcollapsecard %}
```

此处对该插件做了更改，修改了 JS 和 CSS，为其添加了图标，具体可参考 `patch` 下的 JS 和 CSS。方便起见，图标放置于 `themes/book/source`，随主题文件复制。

---

## 开发说明

### 主题扩展

为了实现深/浅色主题切换，对主题文件做了修改，下文涉及主题的文件均位于 `themes/book/source` 目录。

首先，借助 [Dark Reader](https://darkreader.org/) 生成了深色主题，位于 `css/dark.css`，同时，也对原始主题 `css/book.css` 有一定修改。

为了实现自动切换，修改了 `js/book.js`，通过监听 Local Storage 中的 `color-mode` 属性，为 `dark` 时添加 `dark.css`，否则删除。

### 部署

> 更多部署相关信息请参考 [Patpat Deploy](https://github.com/JavaEE-PatPatOnline/PatpatDeploy)。

#### 部署配置

在 `_config.yml` 中，注意修改 `url`，其中的路径应为 Nginx 代理的路径，结尾不带 `/`。

#### Workflow 配置

在 `deploy` 的最后一步，执行部署脚本时，目标参数使用 `tutorial` 指定在服务器的部署路径，均已配置好，如有需要，可自行修改。

建议新建其他分支（如 `draft`）进行教程的修改，更新好后再推送至 `main` 分支，GitHub Action 会自动部署。

#### 半自动部署

根据 Patpat Deploy 中的半自动部署说明配置好后，直接运行 `./deploy.ps1` 即可部署至服务器。

