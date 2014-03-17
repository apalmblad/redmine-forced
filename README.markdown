= forced

Do you follow [Joel Spolsky's bug workflow](http://www.joelonsoftware.com/articles/fog0000000029.html)
Are bug reporters not fulfilling their side of the bargain?
Are bugs being marked fixed and not being closed?

This is a redmine plugin that checks whether the number of issues matching an
existing redmine issue query exceeds a limit.

Forced users to update or close issues by preventing
creation of issues or changes to issues if there are too many issues in a query.
Admins have the option to choose queries that should be analyzed before saving
an issue (ie. Issues created by current user that are marked fixed but not
closed that are of high priority).  Only queries involving a user will be shown.
If the number of issues exceeds that limit, issue creation is prevented.

If you have any comments or suggestions, feel free to contact me at
apalmblad@gmail.com.
