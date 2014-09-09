angular.module('instagram').directive 'instaFeedItemDetailed', (instagram) ->

  restrict: 'E'

  templateUrl: 'instagram/feed_item_detailed'

  scope:
    item_id: '=itemId'

  controller: ($scope) ->
    backup_item = null

    $scope.is_edit_mode = false

    $scope.edit_caption = (item) ->
      backup_item = $scope.item.caption.text
      @is_edit_mode = true


    $scope.reset_caption = ->
      $scope.item.caption.text = backup_item
      backup_item = null
      @is_edit_mode = false


    $scope.save_caption = ->
      backup_item = null
      @is_edit_mode = false


  link: ($scope) ->
    instagram.media($scope.item_id).success (item) ->
      $scope.item = item.data
