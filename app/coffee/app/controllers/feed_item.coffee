angular.module('app').controller 'feed_item_controller', ($stateParams) ->
  @id = $stateParams.item_id
