module ForcedIssue
  # -------------------------------------------- check_for_forced_query_limits
  def check_for_forced_query_limits
    Setting.plugin_forced['queries'].values.each do |data|
      query = IssueQuery.find( :first, :conditions => ["id=?",data['query_id']] )
      next if query.project_id && query.project_id != project_id
      if query.issue_count >= data['max_issues'].to_i
        errors.add( :base, "You have too many issues in #{query.name}.  Please get that number below #{data['max_issues']} before adding more issues." )
        return false
      end
    end
    return true
  end

  def self.included( klass )
    klass.send :before_save, :check_for_forced_query_limits
  end
end
module ForceIssueControllerChanges
  def check_if_at_issue_limit
    Setting.plugin_forced['queries'].values.each do |data|
      query = IssueQuery.find( :first, :conditions => ["id=?",data['query_id']] )
      next if query.project_id && query.project_id != project_id
      if query.issue_count >= data['max_issues'].to_i
        flash[:error] = "You have too many issues in #{query.name}.  Please get that number below #{data['max_issues']} before adding more issues."
        redirect_to project_issues_url( params[:project_id], :query_id => query.id )
        return false
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
