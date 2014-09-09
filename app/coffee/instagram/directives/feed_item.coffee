angular.module('instagram').directive 'instaFeedItem', ->

  restrict: 'E'

  templateUrl: 'instagram/feed_item'

  scope:
    item: '=item'
