angular.module('flickr').factory 'flickr', ($http, $window, $q, $filter,  $cacheFactory) ->

  insta_settings = {}
  root = 'https://api.flickr.com/services/feeds'

  api = {}

  api.media = (id) ->
    angular.fromJson localStorage.getItem('flickr-' + id) || '{}'


  api.public = (count) ->
    defer = $q.defer()

    $window.jsonFlickrFeed = (data) ->
      for item in data.items
        id = item.link.replace('https://www.flickr.com/photos/', '').replace(/\//g, '');
        item.id = id
        localStorage.setItem 'flickr-' + id, angular.toJson  item

      data.items = $filter('limitTo')(data.items, count)
      defer.resolve data

    $http.jsonp "#{root}/photos_public.gne",
      params:
        format: 'json'
        callback: "JSON_CALLBACK"

    defer.promise


  api
