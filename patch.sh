#!/bin/bash

echo 'Copying "patch/hexo-asset-image.js" to "node_modules/hexo-asset-image/index.js"...'
cp patch/hexo-asset-image.js node_modules/hexo-asset-image/index.js
echo 'Copying "patch/hexo-tag-collapse-spoiler.js" to "node_modules/hexo-tag-collapse-spoiler/index.js"...'
cp patch/hexo-tag-collapse-spoiler.js node_modules/hexo-tag-collapse-spoiler/index.js
echo 'Copying "patch/hexo-tag-collapse-spoiler.css" to "node_modules/hexo-tag-collapse-spoiler/lib/collapse.css"...'
cp patch/hexo-tag-collapse-spoiler.css node_modules/hexo-tag-collapse-spoiler/lib/collapse.css
