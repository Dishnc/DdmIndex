#!/usr/bin/env bash
set -euo pipefail
VERSION_NAME="${1:-V1.0.0}"
rm -rf dist
mkdir -p dist
cp -R index.html assets robots.txt sitemap.xml VERSION version.json dist/
VERSION_NAME_ENV="$VERSION_NAME" python3 - <<'PYSCRIPT'
import json, pathlib, datetime, os
version = os.environ.get('VERSION_NAME_ENV', 'V1.0.0')
p = pathlib.Path('dist/version.json')
data = json.loads(p.read_text(encoding='utf-8'))
data['version_name'] = version
data['built_at'] = datetime.datetime.utcnow().replace(microsecond=0).isoformat() + 'Z'
p.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding='utf-8')
PYSCRIPT
echo "Build complete: dist/ (${VERSION_NAME})"
