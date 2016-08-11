var base = '/ARPHD';
var CACHE_NAME = 'arphd';
var urlsToCache = [
  base + '/scores/score_afp.html',
  base + '/scores/score_child.html',
  base + '/scores/score_clif-sofa.html',
  base + '/scores/score_hepatite_fulminante.html',
  base + '/scores/score_hers.html',
  base + '/scores/score_lille.html',
  base + '/scores/score_meld.html',
  base + '/css/accordion.css',
  base + '/css/hc.css',
  base + '/css/trombi.css',
  base + '/images/arrow_down.png',
  base + '/images/arrow_up.png',
  base + '/js/arphd.js',
  '//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css',
  'https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js',
  'https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js'
];

self.addEventListener('install', function(event){
  event.waitUntil(
    caches.open(CACHE_NAME)
    .then(function(cache){
      return cache.addAll(urlsToCache);
    })
    .then(function(){
      return self.skipWaiting();
    })
  );
});

self.addEventListener('fetch', function(event){
  var fetchRequest = event.request.clone();
  var cacheRequest = event.request.clone();
  event.respondWith(
    fetch(fetchRequest)
    .then(function(response){
      var responseToCache = response.clone();
      caches.open(CACHE_NAME)
      .then(function(cache){
        var cacheKey = event.request.clone();
        cache.put(cacheKey, responseToCache);
      });
      return response;
    })
    .catch(function(err){
      return caches.match(cacheRequest);
    })
  );
});

self.addEventListener('activate', function(event){
  event.waitUntil(self.clients.claim());
});
