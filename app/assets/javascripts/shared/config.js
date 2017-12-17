`<%
depend_on Rails.root.join('config', 'secrets.yml')
secrets = Rails.application.secrets
%>`

window.ENV = `<%= Rails.env.to_json %>`
window.DEBUG = `<%= Rails.env.development? %>`
