angular.module('feeds').directive 'fdFeed', ($templateCache, $compile) ->

  restrict: 'E'

  scope:
    feed_type: '@feedType'
    feed_items_count: '=feedItemsCount'


  link: ($scope, $element, $attr) ->
    feeds =
      instagram: '<insta-feed feed-items-count="feed_items_count"></insta-feed>'
      flickr: '<flickr-feed feed-items-count="feed_items_count"></flickr-feed>'

    layout = angular.element feeds[$scope.feed_type]
    $element.replaceWith layout
    $compile(layout) $scope
