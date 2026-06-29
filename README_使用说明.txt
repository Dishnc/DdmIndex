Ddm加速器门户网站 V1.0.0
================================

项目代号：p_ddm_portal_web
项目名称：Ddm加速器门户网站
品牌名称：Ddm加速器
项目生态：Web 网站 / 前端项目
GitHub 仓库：Dishnc/DdmIndex
默认分支：main
Workflow：.github/workflows/build-python-server.yml

一、项目说明
----------------
这是 Ddm加速器产品官网门户的 V1.0.0 初始源码包。网站采用纯静态结构，包含首页、产品优势、设备教程入口、开通入口、配置信息入口、常见问题和在线客服脚本。

页面文案已避免使用敏感营销字样，主要表达为“全球网络访问加速”“国际平台访问体验优化”“多端可用”等。

二、本地运行
----------------
方式 1：直接打开 index.html。

方式 2：使用 Python 本地静态服务：

    python3 -m http.server 8080

然后访问：

    http://127.0.0.1:8080

三、本地构建
----------------

    chmod +x scripts/*.sh
    bash scripts/build.sh V1.0.0

构建结果在：

    dist/

四、本地生成发布包
----------------

    bash scripts/package_server_patch.sh V1.0.0 local

生成结果在：

    release/p_ddm_portal_web_server_patch_V1.0.0.zip
    release/p_ddm_portal_web_dist_V1.0.0.zip

五、GitHub Actions
----------------
Workflow 文件：

    .github/workflows/build-python-server.yml

触发方式：

1. push 到 main 分支自动触发。
2. 在 GitHub Actions 页面手动 workflow_dispatch 触发。
3. x-ui 项目初始化执行中心创建仓库、提交源码后自动触发。

预期产物：

    p_ddm_portal_web_server_patch_V1.0.0.zip
    p_ddm_portal_web_dist_V1.0.0.zip
    SHA256SUMS.txt

六、x-ui CI 回传配置
----------------
Workflow 支持通过 GitHub Secrets 配置 x-ui 回传：

    XUI_CI_UPLOAD_URL
    XUI_CI_UPLOAD_TOKEN
    PUBLISH_GITHUB_RELEASES

建议后续在 x-ui 项目中心生成或保存通用 CI 回传地址后，把地址保存到 GitHub Secrets：

    XUI_CI_UPLOAD_URL=https://buy.aisuper.top/api/project-center/ci-upload

如果当前 x-ui 尚未安装通用项目 CI 回传接口，可以先不配置 XUI_CI_UPLOAD_URL。这样 GitHub Actions 仍会正常生成产物，只是跳过 x-ui 回传。

七、在线客服
----------------
页面已接入：

    https://buy.aisuper.top/static/support/support-widget.css
    https://buy.aisuper.top/static/support/support-widget.js

八、后续迭代规则
----------------
后续 V1.0.1、V1.0.2 等版本建议继续使用“源码补丁包 + GitHub Actions 自动打包 + CI 回传 x-ui + x-ui 发布记录”的方式迭代。
