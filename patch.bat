@ECHO OFF

ECHO 'Copying "patch/hexo-asset-image.js" to "node_modules/hexo-asset-image/index.js"...'
COPY patch\hexo-asset-image.js node_modules\hexo-asset-image\index.js
ECHO 'Copying "patch/hexo-tag-collapse-spoiler.js" to "node_modules/hexo-tag-collapse-spoiler/index.js"...'
COPY patch\hexo-tag-collapse-spoiler.js node_modules\hexo-tag-collapse-spoiler\index.js
ECHO 'Copying "patch/hexo-tag-collapse-spoiler.css" to "node_modules/hexo-tag-collapse-spoiler/lib/collapse.css"...'
COPY patch\hexo-tag-collapse-spoiler.css node_modules\hexo-tag-collapse-spoiler\lib\collapse.css
