angular.module('flickr').directive 'flickrFeedItemDetailed', (flickr) ->

  restrict: 'E'

  templateUrl: 'flickr/feed_item_detailed'

  scope:
    item_id: '=itemId'

  controller: ($scope) ->
    backup_item = null

    $scope.is_edit_mode = false

    $scope.edit_caption = (item) ->
      backup_item = $scope.item.title
      @is_edit_mode = true


    $scope.reset_caption = ->
      $scope.item.title = backup_item
      backup_item = null
      @is_edit_mode = false


    $scope.save_caption = ->
      backup_item = null
      @is_edit_mode = false


  link: ($scope) ->
    $scope.item = flickr.media($scope.item_id)
