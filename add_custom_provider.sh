#!/bin/bash

# 快速添加自定义模型提供商示例脚本
# 使用方法：根据你的实际配置修改下面的环境变量，然后运行此脚本

echo "正在配置自定义模型提供商..."
echo

# ============ 配置示例 1: TAOU Claude ============
# 取消下面的注释并修改为你的实际配置

# export PROVIDER_ID="taou-claude"
# export PROVIDER_NAME="TAOU Claude"
# export BASE_URL="https://maigpt.in.taou.com/rpc/platforms/go_pbs/maigpt/proxy/zhipu/api/anthropic"
# export API_KEY="claude_code"
# export TIMEOUT="600000"  # 可选，默认 600000ms
# export MODEL="claude-3-5-sonnet-20241022"  # 可选，默认模型名称

# ============ 配置示例 2: 其他自定义提供商 ============
# 根据你的实际情况修改

# export PROVIDER_ID="my-custom-provider"
# export PROVIDER_NAME="我的自定义提供商"
# export BASE_URL="https://api.example.com/v1"
# export API_KEY="your-api-key-here"

# ============ 执行配置 ============

# 检查是否设置了必需的环境变量
if [ -z "$PROVIDER_ID" ] || [ -z "$BASE_URL" ] || [ -z "$API_KEY" ]; then
    echo "错误：请先在脚本中配置环境变量！"
    echo
    echo "必需的环境变量："
    echo "  PROVIDER_ID  - 提供商标识（如 taou-claude）"
    echo "  PROVIDER_NAME - 显示名称（如 TAOU Claude）"
    echo "  BASE_URL     - API 基础 URL"
    echo "  API_KEY      - API 密钥"
    echo
    echo "可选的环境变量："
    echo "  TIMEOUT      - 超时时间（毫秒，默认 600000）"
    echo "  MODEL        - 默认模型名称"
    echo
    echo "请编辑此脚本并取消相应行的注释。"
    exit 1
fi

# 显示配置信息
echo "即将添加以下配置："
echo "  提供商标识: $PROVIDER_ID"
echo "  显示名称: ${PROVIDER_NAME:-$PROVIDER_ID}"
echo "  Base URL: $BASE_URL"
echo "  API Key: ${API_KEY:0:10}****"
echo "  超时时间: ${TIMEOUT:-600000} ms"
echo "  默认模型: ${MODEL:-claude-3-5-sonnet-20241022}"
echo

# 调用主脚本
./m2cc.sh --add-custom-env

# 清理环境变量（可选）
unset PROVIDER_ID PROVIDER_NAME BASE_URL API_KEY TIMEOUT MODEL

echo
echo "完成！"
