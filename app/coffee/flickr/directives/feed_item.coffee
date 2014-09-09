angular.module('flickr').directive 'flickrFeedItem', ->

  restrict: 'E'

  templateUrl: 'flickr/feed_item'

  scope:
    item: '=item'
