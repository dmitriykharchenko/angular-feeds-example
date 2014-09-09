angular.module('instagram').directive 'instaFeed', (instagram) ->

  restrict: 'E'

  templateUrl: 'instagram/feed'

  scope:
    feed_items_count: '=feedItemsCount'

  controller: ($scope) ->
    instagram.popular($scope.feed_items_count).success (feed) ->
      $scope.feed_data = feed.data
