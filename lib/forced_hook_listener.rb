module ForcedIssue
  # -------------------------------------------- check_for_forced_query_limits
  def check_for_forced_query_limits
    unless Setting.plugin_forced['query_ids'].nil?
      Setting.plugin_forced['query_ids'].each_with_index do |query_id, i|
        query = IssueQuery.find( :first, :conditions => ["id=?",query_id] )
        next if query.project_id && query.project_id != project_id
        max_issues = Setting.plugin_forced['max_issues'][i].to_i
        if query.issue_count >= max_issues
          errors.add( :base, "You have too many issues in #{query.name}.  Please get that number below #{max_issues} before adding more issues." )
          return false
        end
      end
    end
    return true
  end

  def self.included( klass )
    klass.send :before_create, :check_for_forced_query_limits
  end
end
module ForceIssueControllerChanges
  def check_if_at_issue_limit
    unless Setting.plugin_forced['query_ids'].nil?
      Setting.plugin_forced['query_ids'].each_with_index do |query_id, i|
        query = IssueQuery.find( :first, :conditions => ["id=?",query_id] )
        next if query.project_id && query.project_id != project_id
        max_issues = Setting.plugin_forced['max_issues'][i].to_i
        if query.issue_count >= max_issues
          flash[:error] = "You have too many issues in #{query.name}.  Please get that number below #{max_issues} before adding more issues."
          redirect_to project_issues_url( params[:project_id], :query_id => query.id )
          return false
        end
      end
    end
    return true
  end
  def self.included( klass )
    klass.send :before_filter, :check_if_at_issue_limit, :only => [:create, :new]
  end
end
Issue.send( :include, ForcedIssue )
IssuesController.send( :include, ForceIssueControllerChanges )
