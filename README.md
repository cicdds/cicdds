# cicd.sh

## 操作指南

### 安装 cicd.sh

### 配置 cicd.sh

| 参数 | 模块 | 默认值 | 说明 |
| -- | -- | -- | -- |
| env | global | dev | 环境变量，通常通过命令行 -e'env=test' 动态指定 |
| keep_version_num | global | 10 | 线上服务器保留的版本数 |
| ci_project_path | global | | 该项目在仓库中的路径，比如 http://github.com/gengxiankun/cicd.git 的项目，它的 ci_project_path 应该是 gengxiankun/cicd |
| build_path_prefix | global | /data/build_release/ | 部署代码的目录前缀 |
| website_path_prefix | global | /data/website/ | 发布代码的目录前缀 |
| runtime_path_prefix | global | /data/runtime/ | 服务运行时的目录前缀 |
| docker_registry_url | docker | | docker 私有仓库地址 |
| docker_registry_user | docker | | docker 私有仓库用户名 |
| docker_registry_password | docker | | docker 私有仓库密码 |
| servers | server | | 待部署或待发布的服务器，多台服务以 # 分隔 |
| server_{n}_user | server | | 服务器用户名 |
| server_{n}_ip | server | | 服务器 IP |
| server_{n}_port | server | | 服务器 ssh 端口号 |
| server_{n}_key | server | | 服务器 ssh 授权私钥 |
| server_{n}_instanceId | server | | 云服务器实例 ID |

要使用 `cicd.sh` 命令行工具，您需要进行一些初始化配置，使其完成使用持续集成的必要前提条件。

1. 交互模式，您可以通过 cicd.sh configure 命令进入交互模式快速配置。

```bash
$ cicd.sh configure
cicd global env [dev]: 
cicd global keep_version_num [10]: 
cicd global ci_project_path []: 
cicd global build_path_prefix [/data/build_release/]: 
cicd global website_path_prefix [/data/website/]: 
cicd global runtime_path_prefix [/data/runtime/]: 
cicd docker docker_registry_url []: 
cicd docker docker_registry_user []: 
cicd docker docker_registry_password []: 
```

2. 修改配置文件

### 使用 cicd.sh

#### 操作场景
命令行工具集成了 CI/CD 通用的操作流程，可以在命令行下完成对项目集成和发布。包括使用 `cicd.sh` 编译项目、部署到服务器、发送叮叮通知、版本备份以及集成各种发布模式的上线。例如：

- 通过 `cicd.sh java build -tdocker-maven` 命令对 maven 项目进行编译并打包成 Docker 镜像。
- 通过 `cicd.sh java build -tdocker-maven -e'ci_commit_sha=1.0.0,servers=server_01,server_02'` 命令将构建好的 maven 项目的 1.0.0 版本部署到指定服务器上。

#### 操作示例

#### 更多操作

- `cicd.sh help` 查看 `cicd.sh` 支持的平台。
- `cicd.sh java help` 查看具体平台下支持的 CI/CD 的操作。