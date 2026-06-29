#!/usr/bin/env bash
set -euo pipefail
VERSION_NAME="${1:-V1.0.0}"
GIT_SHA="${2:-local}"
PROJECT_KEY="p_ddm_portal_web"
rm -rf release .server_patch_tmp
mkdir -p release .server_patch_tmp/public
if [ ! -d dist ]; then
  bash scripts/build.sh "$VERSION_NAME"
fi
cp -R dist/* .server_patch_tmp/public/
cat > .server_patch_tmp/deploy_manifest.json <<JSON
{
  "project_key": "${PROJECT_KEY}",
  "project_name": "Ddm加速器门户网站",
  "version_name": "${VERSION_NAME}",
  "version_code": 100,
  "git_sha": "${GIT_SHA}",
  "artifact_type": "server_patch.zip",
  "deploy_root": "public",
  "entry": "public/index.html",
  "restart_required": false
}
JSON
cat > .server_patch_tmp/patch.json <<JSON
{
  "patch_id": "${PROJECT_KEY}_${VERSION_NAME}_server_patch",
  "project_key": "${PROJECT_KEY}",
  "version_name": "${VERSION_NAME}",
  "version_code": 100,
  "type": "static_web_release",
  "description": "Ddm加速器门户网站静态发布包",
  "restart_service": false,
  "sql": [],
  "nginx": [],
  "files_root": "public"
}
JSON
( cd .server_patch_tmp && zip -qr "../release/${PROJECT_KEY}_server_patch_${VERSION_NAME}.zip" . )
( cd dist && zip -qr "../release/${PROJECT_KEY}_dist_${VERSION_NAME}.zip" . )
rm -rf .server_patch_tmp
echo "Artifacts created in release/"
