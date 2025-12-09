# 变更日志 (CHANGELOG)

## [0.0.6] - 2025-12-08

### ✨ 新增功能

#### 自定义模型提供商支持
- 🎨 **自定义模型配置** - 支持配置任意兼容 Anthropic API 的服务
- 🔧 **三种配置方式**：
  - 交互式配置（`--add-custom`）
  - 环境变量配置（`--add-custom-env`）
  - 一键配置脚本
- 🔄 **灵活切换** - 在预配置和自定义提供商之间自由切换
- 📁 **持久化配置** - 配置自动保存到 `~/.claude/providers.json`

#### 新增命令行参数
- `--add-custom` - 启动交互式自定义模型配置向导
- `--add-custom-env` - 从环境变量读取配置并添加自定义模型

#### 环境变量支持
支持以下环境变量用于自定义模型配置：
- `PROVIDER_ID` - 提供商唯一标识（必需）
- `PROVIDER_NAME` - 显示名称（可选）
- `BASE_URL` - API 端点 URL（必需）
- `API_KEY` - 认证密钥（必需）
- `TIMEOUT` - 超时时间，默认 600000ms（可选）
- `MODEL` - 默认模型名称（可选）

### 📝 新增文档

1. **CUSTOM_PROVIDER_GUIDE.md** - 完整的自定义模型配置指南
   - 详细的配置步骤
   - 多种配置方法说明
   - 常见问题解答
   - 高级使用技巧

2. **QUICK_START.md** - 快速开始指南
   - 三种配置方式的快速说明
   - 完整的使用流程示例
   - 常用命令列表

3. **CUSTOM_PROVIDER_UPDATE.md** - 更新说明文档
   - 详细的功能更新说明
   - 配置文件结构说明
   - 技术实现细节

### 🔨 新增脚本

1. **add_custom_provider.sh** - 通用自定义提供商配置脚本模板
   - 可复制修改用于不同的提供商
   - 包含完整的配置示例
   - 支持批量配置

2. **setup_xxx_claude.sh** - xxx Claude 一键配置脚本
   - 预配置好的 xxx Claude 设置
   - 一键运行即可完成配置
   - 包含配置验证和确认

### 🔄 功能增强

#### m2cc.sh 主脚本更新

**新增函数：**
- `get_custom_provider_config()` - 交互式获取自定义配置
- `configure_custom_provider()` - 配置自定义提供商
- `configure_custom_provider_from_env()` - 从环境变量配置

**增强的函数：**
- `configure_provider()` - 现在支持自定义提供商（custom-* 前缀）
  - 新增可选参数：显示名称、Base URL、超时时间、模型名
  - 自动识别并处理自定义提供商配置

- `configure_claude_code()` - 集成自定义模型配置选项
  - 在配置流程中增加"是否配置自定义模型提供商"选项

**更新的帮助信息：**
- 包含自定义模型的完整使用说明
- 提供环境变量配置示例
- 列出所有支持的命令和参数

### 📖 文档更新

#### README.md
- 在 AI 模型选择部分新增"自定义模型提供商"说明
- 更新切换模型部分，包含自定义模型切换示例
- 添加指向详细配置指南的链接

### 🎯 使用示例

#### 交互式配置
```bash
./m2cc.sh --add-custom
```

#### 环境变量配置
```bash
export PROVIDER_ID="xxx-claude"
export PROVIDER_NAME="xxx Claude"
export BASE_URL="https://maigpt.in.xxx.com/rpc/platforms/go_pbs/maigpt/proxy/zhipu/api/anthropic"
export API_KEY="claude_code"
./m2cc.sh --add-custom-env
```

#### 一键脚本配置
```bash
./setup_xxx_claude.sh
```

### 🔧 技术细节

#### 配置文件结构
自定义提供商配置存储在 `~/.claude/providers.json` 中：
```json
{
  "providers": {
    "custom-xxx": {
      "name": "custom-xxx",
      "displayName": "自定义名称",
      "baseUrl": "https://api.example.com",
      "apiKey": "your-key",
      "timeout": "600000",
      "models": {
        "default": "model-name",
        ...
      }
    }
  },
  "activeProvider": "custom-xxx"
}
```

#### 命名规范
- 自定义提供商标识必须以 `custom-` 前缀开头
- 提供商 ID 仅支持小写字母、数字和横杠
- 显示名称可以使用任意字符

### ✅ 兼容性

- ✅ 完全向后兼容，不影响现有功能
- ✅ 可与预配置提供商（MiniMax、DeepSeek、GLM）共存
- ✅ 支持配置多个自定义提供商
- ✅ 支持灵活切换不同提供商

### 🐛 Bug 修复

- 修复 `show_help()` 函数中 EOF 位置错误导致的语法问题
- 优化帮助信息格式，使用单引号 EOF 避免变量替换

### 📌 注意事项

1. 自定义模型需要兼容 Anthropic Claude API 协议
2. 配置的 Base URL 必须是完整的 API 端点地址
3. API Key 会明文存储在配置文件中，请注意保护配置文件权限
4. 环境变量 `ANTHROPIC_BASE_URL` 和 `ANTHROPIC_AUTH_TOKEN` 可选配置到 shell 配置文件

### 🎓 相关资源

- [自定义模型配置完整指南](CUSTOM_PROVIDER_GUIDE.md)
- [快速开始指南](QUICK_START.md)
- [更新说明](CUSTOM_PROVIDER_UPDATE.md)

---

## [0.0.5] - Previous Version

之前版本的更新内容...

