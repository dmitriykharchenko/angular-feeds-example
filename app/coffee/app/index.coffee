app = angular.module('app', [
  'instagram'
  'flickr'
  'feeds'
  'ui.router'
])

.config (instagramProvider, $stateProvider, $urlRouterProvider, $locationProvider) ->

  instagramProvider.config
    client_id: '007ba24feef548aeab821240d975332d'

  states =
    'feeds':
      abstract: true
      url: ''

    'feeds.index':
      url: '/feeds'

    'feeds.feed':
      url: '/feeds/:feed_name'

    'feeds.feed.item':
      url: '/:item_id'


  redirection =
    '': '/'
    '/': '/feeds'


  for origin, target of redirection
    $urlRouterProvider.when origin, target


  for state, data of states
    params = angular.extend {}, data
    params.templateUrl = 'app/' + state.replace(/\./g, "/")

    $stateProvider.state state, params



  $locationProvider
  .html5Mode true
