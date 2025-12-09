#!/bin/bash

# TAOU Claude 快速配置脚本
# 这是一个预配置好的示例，可以直接运行

echo "======================================"
echo "  TAOU Claude 快速配置工具"
echo "======================================"
echo

# TAOU Claude 配置
export PROVIDER_ID="taou-claude"
export PROVIDER_NAME="TAOU Claude"
export BASE_URL="https://maigpt.in.taou.com/rpc/platforms/go_pbs/maigpt/proxy/zhipu/api/anthropic"
export API_KEY="claude_code"
export TIMEOUT="600000"
export MODEL="claude-3-5-sonnet-20241022"

echo "即将添加以下配置："
echo "  提供商: TAOU Claude"
echo "  Base URL: $BASE_URL"
echo "  API Key: ${API_KEY:0:10}****"
echo

# 确认是否继续
read -p "确认添加此配置？(y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "已取消配置"
    exit 1
fi

# 检查 m2cc.sh 是否存在
if [ ! -f "./m2cc.sh" ]; then
    echo "错误：找不到 m2cc.sh 文件"
    echo "请确保在 m2cc 项目目录下运行此脚本"
    exit 1
fi

# 执行配置
./m2cc.sh --add-custom-env

# 检查配置结果
if [ $? -eq 0 ]; then
    echo
    echo "======================================"
    echo "  ✅ 配置成功！"
    echo "======================================"
    echo
    echo "下一步："
    echo "  1. 验证配置：./m2cc.sh --list"
    echo "  2. 切换到 TAOU Claude：./m2cc.sh --switch custom-taou-claude"
    echo "  3. 开始使用：claude"
    echo
else
    echo
    echo "======================================"
    echo "  ❌ 配置失败"
    echo "======================================"
    echo
    echo "请检查："
    echo "  1. m2cc.sh 文件是否存在"
    echo "  2. 是否已安装 jq（运行 m2cc.sh 会自动安装）"
    echo "  3. ~/.claude 目录是否有写入权限"
    echo
fi

# 清理环境变量
unset PROVIDER_ID PROVIDER_NAME BASE_URL API_KEY TIMEOUT MODEL
