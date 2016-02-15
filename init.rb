Redmine::Plugin.register :forced do
  name 'Forced plugin'
  author 'Adam Palmblad'
  description 'This is a plugin to force users to update or close issues by preventing creation of issues or changes to issues if there are too many issues in a query.  Admins have the option to choose queries that should be analyzed before saving an issue (ie. Issues created by current user that are marked fixed but not closed that are of high priority).  Only queries involving a user will be shown.  If the number of issues exceeds that limit, issue creation is prevented.'
  version '0.0.2'
  url 'http://github.com/apalmblad/redmine-forced'
  author_url 'http://github.com/apalmblad'
  settings :default => {'empty' => true}, :partial => 'settings/settings'


end
require 'forced_hook_listener'
