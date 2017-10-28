#= require ./app

# window.localStorage & sessionStorage can be not available in privacy mode
# or on mobile devices sometimes, thowing `QuotaExceededError: DOM Exception 22`:
#
#   - Chrome, FF privacy mode: no exceptions, sessionStorage is cleared after page
#     reload, sessionStorage is preserved.
#   - Safari@MacOs privacy mode: setItem on sessionStorage & localStorage
#     throw exceptions
#
# This object proxies calls to global localStorage, sessionStorage
# and uses plain object to cache them per turbolinks session.
# In this way we get working storage in Chrome & FF privacy mode,
# and in Safari until page reload.
App.localStorage =
  _store: {}

  setItem: (key, val) ->
    @_store[key] = val
    try
      window.localStorage.setItem(key, val)
      window.sessionStorage.setItem(key, val)
    catch

  removeItem: (key) ->
    delete @_store[key]
    window.localStorage.removeItem(key)
    window.sessionStorage.removeItem(key)

  getItem: (key) ->
    @_store[key] ||
      window.sessionStorage.getItem(key) ||
      window.localStorage.getItem(key)

  clear: ->
    window.localStorage?.clear()
    window.sessionStorage?.clear()
