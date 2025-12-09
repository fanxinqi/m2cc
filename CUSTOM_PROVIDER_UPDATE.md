# 自定义模型配置功能 - 更新总结

## 🎉 新增功能

现在 M2CC 支持添加**自定义模型提供商**，你可以使用任何兼容 Anthropic Claude API 的服务！

## 📦 新增文件

1. **CUSTOM_PROVIDER_GUIDE.md** - 完整的自定义模型配置教程
2. **add_custom_provider.sh** - 通用的自定义提供商配置脚本模板
3. **setup_xxx_claude.sh** - xxx Claude 的快速配置脚本（预配置好的示例）

## 🚀 三种配置方式

### 方式 1: 交互式配置（最简单）

```bash
./m2cc.sh --add-custom
```

按提示输入：
- 提供商标识（如：xxx-claude）
- 显示名称（如：xxx Claude）
- Base URL
- API Key
- 超时时间（可选）
- 默认模型（可选）

### 方式 2: 环境变量配置（适合自动化）

```bash
export PROVIDER_ID="xxx-claude"
export PROVIDER_NAME="xxx Claude"
export BASE_URL="https://maigpt.in.xxx.com/rpc/platforms/go_pbs/maigpt/proxy/zhipu/api/anthropic"
export API_KEY="claude_code"
./m2cc.sh --add-custom-env
```

### 方式 3: 使用预配置脚本（最快）

针对你提到的 xxx Claude 配置，我们创建了一个一键配置脚本：

```bash
./setup_xxx_claude.sh
```

这个脚本已经预配置好了所有参数，只需要运行即可！

## 🔧 主要改动

### m2cc.sh 脚本更新：

1. **新增函数**：
   - `get_custom_provider_config()` - 交互式获取自定义配置
   - `configure_custom_provider()` - 配置自定义提供商
   - `configure_custom_provider_from_env()` - 从环境变量配置

2. **增强的 configure_provider() 函数**：
   - 现在支持自定义提供商（custom-* 前缀）
   - 可以传入自定义参数（显示名称、Base URL、超时、模型名）

3. **新增命令行参数**：
   - `--add-custom` - 交互式添加自定义提供商
   - `--add-custom-env` - 从环境变量添加自定义提供商

4. **更新的帮助信息**：
   - 包含自定义模型配置的说明
   - 提供完整的使用示例

5. **configure_claude_code() 集成**：
   - 在配置流程中增加了自定义模型选项

## 💡 使用示例

### 快速配置 xxx Claude：

```bash
# 方法 1: 使用一键脚本（推荐）
./setup_xxx_claude.sh

# 方法 2: 使用环境变量
PROVIDER_ID="xxx-claude" \
PROVIDER_NAME="xxx Claude" \
BASE_URL="https://maigpt.in.xxx.com/rpc/platforms/go_pbs/maigpt/proxy/zhipu/api/anthropic" \
API_KEY="claude_code" \
./m2cc.sh --add-custom-env

# 方法 3: 交互式配置
./m2cc.sh --add-custom
# 然后按提示输入各项配置
```

### 配置后切换使用：

```bash
# 查看所有配置的提供商
./m2cc.sh --list

# 切换到 xxx Claude
./m2cc.sh --switch custom-xxx-claude

# 查看当前状态
./m2cc.sh --status

# 开始使用
claude
```

## 📝 配置说明

### 环境变量持久化（可选）

如果你想将环境变量持久化到 shell 配置文件：

```bash
# Bash 用户
echo 'export ANTHROPIC_BASE_URL=https://maigpt.in.xxx.com/rpc/platforms/go_pbs/maigpt/proxy/zhipu/api/anthropic' >> ~/.bashrc
echo 'export ANTHROPIC_AUTH_TOKEN=claude_code' >> ~/.bashrc
source ~/.bashrc

# Zsh 用户
echo 'export ANTHROPIC_BASE_URL=https://maigpt.in.xxx.com/rpc/platforms/go_pbs/maigpt/proxy/zhipu/api/anthropic' >> ~/.zshrc
echo 'export ANTHROPIC_AUTH_TOKEN=claude_code' >> ~/.zshrc
source ~/.zshrc
```

**注意**：M2CC 已经将配置保存到 `~/.claude/providers.json` 和 `~/.claude/settings.json`，通常不需要额外的环境变量配置。上述操作仅在某些特殊场景下需要。

## 🎯 配置文件结构

配置后，你的提供商配置存储在 `~/.claude/providers.json`：

```json
{
  "providers": {
    "minimax": { ... },
    "deepseek": { ... },
    "custom-xxx-claude": {
      "name": "custom-xxx-claude",
      "displayName": "xxx Claude",
      "apiKeyName": "",
      "apiKeyUrl": "",
      "baseUrl": "https://maigpt.in.xxx.com/rpc/platforms/go_pbs/maigpt/proxy/zhipu/api/anthropic",
      "apiKey": "claude_code",
      "timeout": "600000",
      "models": {
        "default": "claude-3-5-sonnet-20241022",
        "small_fast": "claude-3-5-sonnet-20241022",
        "DEFAULT_SONNET_MODEL": "claude-3-5-sonnet-20241022",
        "DEFAULT_OPUS_MODEL": "claude-3-5-sonnet-20241022",
        "DEFAULT_HAIKU_MODEL": "claude-3-5-sonnet-20241022"
      }
    }
  },
  "activeProvider": "custom-xxx-claude"
}
```

当前激活的配置在 `~/.claude/settings.json`：

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://maigpt.in.xxx.com/rpc/platforms/go_pbs/maigpt/proxy/zhipu/api/anthropic",
    "ANTHROPIC_AUTH_TOKEN": "claude_code",
    "API_TIMEOUT_MS": "600000",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": 1,
    "ANTHROPIC_MODEL": "claude-3-5-sonnet-20241022",
    "ANTHROPIC_SMALL_FAST_MODEL": "claude-3-5-sonnet-20241022",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "claude-3-5-sonnet-20241022",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "claude-3-5-sonnet-20241022",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "claude-3-5-sonnet-20241022"
  }
}
```

## 🔄 管理自定义提供商

### 查看所有提供商
```bash
./m2cc.sh --list
```

### 切换提供商
```bash
./m2cc.sh --switch custom-xxx-claude
```

### 删除自定义提供商
编辑配置文件：
```bash
nano ~/.claude/providers.json
```
删除对应的提供商配置块。

### 更新配置
使用相同的 PROVIDER_ID 重新配置即可覆盖：
```bash
./m2cc.sh --add-custom
# 或
./setup_xxx_claude.sh
```

## 📚 详细文档

- **完整配置指南**：查看 [CUSTOM_PROVIDER_GUIDE.md](CUSTOM_PROVIDER_GUIDE.md)
- **主 README**：查看 [README.md](README.md)（已更新包含自定义模型说明）

## ✅ 兼容性

- ✅ 兼容所有现有功能
- ✅ 支持多个自定义提供商同时配置
- ✅ 可以与预配置的提供商（MiniMax、DeepSeek、GLM）共存
- ✅ 支持灵活切换

## 🚀 快速开始

对于你的 xxx Claude 配置，最简单的方式：

```bash
# 1. 运行配置脚本
./setup_xxx_claude.sh

# 2. 确认配置
./m2cc.sh --list

# 3. 开始使用
claude
```

就这么简单！🎉
