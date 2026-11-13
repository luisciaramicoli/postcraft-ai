const { chromium } = require('/tmp/postcraft-browser/node_modules/playwright');
(async()=>{const b=await chromium.launch();for(const n of ['d1','d2','d3']){const p=await b.newPage({viewport:{width:830,height:300},deviceScaleFactor:2.2});await p.goto('file://'+__dirname+'/'+n+'.html');await p.screenshot({path:__dirname+'/'+n+'.png',fullPage:true});await p.close();}await b.close();})();
