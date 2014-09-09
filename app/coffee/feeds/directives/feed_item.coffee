angular.module('feeds').directive 'fdFeedItem', ($compile) ->

  restrict: 'E'

  scope:
    feed_type: '@feedType'
    feed_item_id: '=feedItemId'


  link: ($scope, $element, $attr) ->
    feeds =
      instagram: '<insta-feed-item-detailed item-id="feed_item_id"></insta-feed-item-detailed>'
      flickr: '<flickr-feed-item-detailed item-id="feed_item_id"></flickr-feed-item-detailed>'

    layout = angular.element feeds[$scope.feed_type]
    $element.replaceWith layout
    $compile(layout) $scope
