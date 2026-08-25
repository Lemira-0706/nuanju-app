/* 暖居收纳 · Service Worker（离线缓存） */
const CACHE = "nuanju-v1";
const CORE = [
  "./",
  "./index.html",
  "./manifest.json",
  "./icon-512.png"
];
const CDN = [
  "https://cdn.jsdelivr.net/npm/@zxing/library@0.21.3/umd/index.min.js",
  "https://cdn.jsdelivr.net/npm/xlsx@0.18.5/dist/xlsx.full.min.js"
];

self.addEventListener("install", e => {
  e.waitUntil((async () => {
    const c = await caches.open(CACHE);
    await c.addAll(CORE).catch(() => {});
    // 预缓存 CDN（失败不影响安装）
    await Promise.all(CDN.map(u => fetch(u).then(r => { if (r.ok) c.put(u, r); }).catch(() => {})));
    self.skipWaiting();
  })());
});

self.addEventListener("activate", e => {
  e.waitUntil((async () => {
    const keys = await caches.keys();
    await Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)));
    self.clients.claim();
  })());
});

self.addEventListener("fetch", e => {
  const req = e.request;
  if (req.method !== "GET") return;
  const url = new URL(req.url);
  // 同源核心资源：缓存优先
  if (url.origin === self.location.origin) {
    e.respondWith((async () => {
      const c = await caches.open(CACHE);
      const cached = await c.match(req);
      if (cached) return cached;
      try {
        const res = await fetch(req);
        if (res.ok) c.put(req, res.clone());
        return res;
      } catch (err) {
        // 离线回退到 index.html（SPA 导航）
        if (req.mode === "navigate") {
          const fb = await c.match("./index.html");
          if (fb) return fb;
        }
        throw err;
      }
    })());
    return;
  }
  // 跨域 CDN：网络优先，失败回退缓存
  e.respondWith((async () => {
    try {
      const res = await fetch(req);
      if (res.ok) { (await caches.open(CACHE)).put(req, res.clone()); }
      return res;
    } catch (err) {
      const c = await caches.open(CACHE);
      const cached = await c.match(req);
      if (cached) return cached;
      throw err;
    }
  })());
});
