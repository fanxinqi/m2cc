# 自定义模型配置指南

本文档介绍如何在 M2CC 中添加和使用自定义模型提供商。

## 目录
- [快速开始](#快速开始)
- [方法一：交互式配置](#方法一交互式配置)
- [方法二：命令行环境变量配置](#方法二命令行环境变量配置)
- [方法三：使用配置脚本](#方法三使用配置脚本)
- [切换模型](#切换模型)
- [管理自定义模型](#管理自定义模型)
- [常见问题](#常见问题)

## 快速开始

M2CC 支持三种方式添加自定义模型提供商：

1. **交互式配置**（推荐新手）
2. **环境变量配置**（适合自动化）
3. **配置脚本**（最便捷）

## 方法一：交互式配置

运行以下命令启动交互式配置向导：

```bash
./m2cc.sh --add-custom
```

或在主菜单中选择"重新配置模型"选项，然后选择配置自定义模型。

按照提示输入：
1. **提供商标识**：英文、数字、横杠组合，如 `xxx-claude`
2. **显示名称**：任意名称，如 `xxx Claude`
3. **API Base URL**：完整的 API 地址
4. **API Key/Token**：你的认证密钥
5. **超时时间**（可选）：默认 600000 毫秒
6. **默认模型**（可选）：默认 `claude-3-5-sonnet-20241022`

### 示例

```
请输入提供商标识（仅英文、数字、横杠，如 custom-claude）： xxx-claude
请输入显示名称（如 自定义 Claude）： xxx Claude
请输入 API Base URL： https://maigpt.in.xxx.com/rpc/platforms/go_pbs/maigpt/proxy/zhipu/api/anthropic
请输入 API Key/Token： claude_code
请输入超时时间（毫秒，默认 600000）： 600000
请输入默认模型名称（默认 claude-3-5-sonnet-20241022）： claude-3-5-sonnet-20241022
```

## 方法二：命令行环境变量配置

直接通过环境变量一次性配置（适合脚本化）：

```bash
# 设置环境变量
export PROVIDER_ID="xxx-claude"
export PROVIDER_NAME="xxx Claude"
export BASE_URL="https://maigpt.in.xxx.com/rpc/platforms/go_pbs/maigpt/proxy/zhipu/api/anthropic"
export API_KEY="claude_code"
export TIMEOUT="600000"  # 可选
export MODEL="claude-3-5-sonnet-20241022"  # 可选

# 执行配置
./m2cc.sh --add-custom-env
```

### 一行命令配置

```bash
PROVIDER_ID="xxx-claude" \
PROVIDER_NAME="xxx Claude" \
BASE_URL="https://maigpt.in.xxx.com/rpc/platforms/go_pbs/maigpt/proxy/zhipu/api/anthropic" \
API_KEY="claude_code" \
./m2cc.sh --add-custom-env
```

## 方法三：使用配置脚本

我们提供了一个便捷的配置脚本 `add_custom_provider.sh`。

### 步骤：

1. 编辑脚本文件：
```bash
nano add_custom_provider.sh
```

2. 找到配置示例部分，取消注释并修改为你的实际配置：
```bash
export PROVIDER_ID="xxx-claude"
export PROVIDER_NAME="xxx Claude"
export BASE_URL="https://maigpt.in.xxx.com/rpc/platforms/go_pbs/maigpt/proxy/zhipu/api/anthropic"
export API_KEY="claude_code"
```

3. 赋予执行权限并运行：
```bash
chmod +x add_custom_provider.sh
./add_custom_provider.sh
```

## 切换模型

配置完成后，可以通过以下方式切换到自定义模型：

### 命令行切换
```bash
./m2cc.sh --switch custom-xxx-claude
```

### 交互式切换
```bash
./m2cc.sh --configure
```
然后按提示选择模型。

### 主菜单切换
运行 `./m2cc.sh` 启动主菜单，选择"切换模型提供商"。

## 管理自定义模型

### 查看所有配置的模型
```bash
./m2cc.sh --list
```

### 查看当前状态
```bash
./m2cc.sh --status
```

### 编辑配置文件
配置文件位于 `~/.claude/providers.json`，你可以直接编辑：
```bash
nano ~/.claude/providers.json
```

### 删除自定义模型
编辑 `~/.claude/providers.json`，删除相应的提供商配置。

## 配置说明

### 必需参数

| 参数 | 环境变量 | 说明 | 示例 |
|------|----------|------|------|
| 提供商标识 | `PROVIDER_ID` | 唯一标识符（小写字母、数字、横杠） | `xxx-claude` |
| Base URL | `BASE_URL` | API 端点地址 | `https://api.example.com/v1` |
| API Key | `API_KEY` | 认证密钥 | `your-api-key` |

### 可选参数

| 参数 | 环境变量 | 默认值 | 说明 |
|------|----------|--------|------|
| 显示名称 | `PROVIDER_NAME` | 与 PROVIDER_ID 相同 | 友好显示名称 |
| 超时时间 | `TIMEOUT` | `600000` | 请求超时时间（毫秒） |
| 默认模型 | `MODEL` | `claude-3-5-sonnet-20241022` | 默认使用的模型名称 |

## 使用示例

### 示例 1: 配置 xxx Claude

```bash
export PROVIDER_ID="xxx-claude"
export PROVIDER_NAME="xxx Claude"
export BASE_URL="https://maigpt.in.xxx.com/rpc/platforms/go_pbs/maigpt/proxy/zhipu/api/anthropic"
export API_KEY="claude_code"
./m2cc.sh --add-custom-env
```

### 示例 2: 配置其他兼容 API

```bash
export PROVIDER_ID="my-proxy"
export PROVIDER_NAME="我的代理服务"
export BASE_URL="https://my-proxy.example.com/api/anthropic"
export API_KEY="sk-ant-xxxxxxxxxxxxx"
export TIMEOUT="900000"
./m2cc.sh --add-custom-env
```

### 示例 3: 配置并立即切换

```bash
# 配置
./m2cc.sh --add-custom-env

# 切换（自动提示是否切换）
# 或手动切换：
./m2cc.sh --switch custom-xxx-claude
```

## 环境变量持久化（可选）

如果你想将配置持久化到 shell 配置文件中：

### Bash 用户
```bash
echo 'export ANTHROPIC_BASE_URL=https://maigpt.in.xxx.com/rpc/platforms/go_pbs/maigpt/proxy/zhipu/api/anthropic' >> ~/.bashrc
echo 'export ANTHROPIC_AUTH_TOKEN=claude_code' >> ~/.bashrc
source ~/.bashrc
```

### Zsh 用户
```bash
echo 'export ANTHROPIC_BASE_URL=https://maigpt.in.xxx.com/rpc/platforms/go_pbs/maigpt/proxy/zhipu/api/anthropic' >> ~/.zshrc
echo 'export ANTHROPIC_AUTH_TOKEN=claude_code' >> ~/.zshrc
source ~/.zshrc
```

**注意**：M2CC 会将配置保存到 `~/.claude/providers.json` 和 `~/.claude/settings.json`，无需额外的环境变量配置。上述环境变量持久化仅在某些特殊场景下需要。

## 常见问题

### Q: 如何验证配置是否成功？
A: 运行 `./m2cc.sh --list` 查看所有配置，或 `./m2cc.sh --status` 查看当前激活的配置。

### Q: 可以配置多个自定义提供商吗？
A: 可以！每次配置使用不同的 `PROVIDER_ID` 即可。

### Q: 如何更新已有的自定义配置？
A: 使用相同的 `PROVIDER_ID` 重新配置即可覆盖。

### Q: 配置文件在哪里？
A: 
- 提供商列表：`~/.claude/providers.json`
- 当前激活配置：`~/.claude/settings.json`

### Q: 删除自定义配置后如何恢复默认？
A: 切换到其他预配置的提供商（如 minimax、deepseek）即可。

### Q: 支持哪些 API 协议？
A: 任何兼容 Anthropic Claude API 协议的服务都可以使用。

### Q: 配置后 Claude Code 没有生效？
A: 
1. 检查配置：`./m2cc.sh --status`
2. 确认已切换到正确的提供商
3. 重启终端或运行 `source ~/.bashrc` / `source ~/.zshrc`
4. 检查 API URL 和 Key 是否正确

## 高级用法

### 批量配置多个提供商

创建一个脚本文件 `batch_config.sh`：

```bash
#!/bin/bash

# 配置提供商 1
PROVIDER_ID="provider1" \
PROVIDER_NAME="Provider 1" \
BASE_URL="https://api1.example.com" \
API_KEY="key1" \
./m2cc.sh --add-custom-env

# 配置提供商 2
PROVIDER_ID="provider2" \
PROVIDER_NAME="Provider 2" \
BASE_URL="https://api2.example.com" \
API_KEY="key2" \
./m2cc.sh --add-custom-env

echo "所有提供商配置完成！"
./m2cc.sh --list
```

### 在 CI/CD 中使用

```yaml
# GitHub Actions 示例
- name: Configure Custom Claude Provider
  run: |
    export PROVIDER_ID="ci-claude"
    export BASE_URL="${{ secrets.CLAUDE_BASE_URL }}"
    export API_KEY="${{ secrets.CLAUDE_API_KEY }}"
    ./m2cc.sh --add-custom-env
    ./m2cc.sh --switch custom-ci-claude
```

## 获取帮助

- 查看完整帮助：`./m2cc.sh --help`
- 查看所有命令：`./m2cc.sh` (进入主菜单)
- 问题反馈：提交 Issue 到项目仓库

---

**提示**：配置自定义模型后，可以通过 `claude` 命令直接使用，无需每次指定提供商。M2CC 会自动应用当前激活的配置。
