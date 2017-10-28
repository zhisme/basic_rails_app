#= require jquery3
#= require jquery.remotipart
#= require ./jquery-turbolinks
#= require rails-ujs
#= require turbolinks
#= require ./turbolinks-patch
#= require ./turbolinks-ui

#= require rails_stuff/plugin_manager
#= require ./jquery-helpers
#= require ./form_helpers
#= require ./config
#= require ./app
#= require ./local_storage

#= require ./message

# Don't suppress errors for remote forms/links.
$(document).on 'ajax:error', (e, xhr, status, error) ->
  throw error
