/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * DS207: Consider shorter variations of null checks
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
//= require ./app

// window.localStorage & sessionStorage can be not available in privacy mode
// or on mobile devices sometimes, thowing `QuotaExceededError: DOM Exception 22`:
//
//   - Chrome, FF privacy mode: no exceptions, sessionStorage is cleared after page
//     reload, sessionStorage is preserved.
//   - Safari@MacOs privacy mode: setItem on sessionStorage & localStorage
//     throw exceptions
//
// This object proxies calls to global localStorage, sessionStorage
// and uses plain object to cache them per turbolinks session.
// In this way we get working storage in Chrome & FF privacy mode,
// and in Safari until page reload.
App.localStorage = {
  _store: {},

  setItem(key, val) {
    this._store[key] = val;
    try {
      window.localStorage.setItem(key, val);
      return window.sessionStorage.setItem(key, val);
    } catch (error) {}
  },

  removeItem(key) {
    delete this._store[key];
    window.localStorage.removeItem(key);
    return window.sessionStorage.removeItem(key);
  },

  getItem(key) {
    return this._store[key] ||
      window.sessionStorage.getItem(key) ||
      window.localStorage.getItem(key);
  },

  clear() {
    if (window.localStorage != null) {
      window.localStorage.clear();
    }
    return (window.sessionStorage != null ? window.sessionStorage.clear() : undefined);
  }
};
