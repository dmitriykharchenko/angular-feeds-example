angular.module('instagram').provider 'instagram', () ->

  insta_settings = {}
  root = 'https://api.instagram.com/v1'


  config: (settings) ->
    angular.extend insta_settings, settings

  $get: ($http, $q) ->

    api = {}

    api.media = (id) ->
      $http.jsonp "#{root}/media/#{id}",
        params:
          client_id: insta_settings.client_id
          callback: 'JSON_CALLBACK'


    api.search = (lat, lng, distance) ->
      $http.jsonp "#{root}/media/search",
        params:
          client_id: insta_settings.client_id
          lat: lat
          lng: lng
          distance: distance
          callback: 'JSON_CALLBACK'


    api.popular = (count) ->
      $http.jsonp "#{root}/media/popular",
        params:
          client_id: insta_settings.client_id
          count: count
          callback: 'JSON_CALLBACK'


    api.near = (distance, count) ->
      defer = $q.defer()
      navigator.geolocation.getCurrentPosition (position) ->
        api.search(position.latitude, position.longitude, distance)
        .success (responce) ->
          defer.resolve(responce)

        .error (responce) ->
          defer.reject(responce)


      defer.promise


    api
