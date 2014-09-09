angular.module('flickr').directive 'flickrFeed', (flickr) ->

  restrict: 'E'

  templateUrl: 'flickr/feed'

  scope:
    feed_items_count: '=feedItemsCount'

  controller: ($scope) ->
    flickr.public($scope.feed_items_count).then (feed) ->
      $scope.feed_data = feed.items
