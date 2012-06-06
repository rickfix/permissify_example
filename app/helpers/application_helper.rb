module ApplicationHelper
  def format_notification note, type="success",optionclass = ''
    return "" if note.blank?
    html=<<-END
       <div id="#{type}Explanation" class="feedback">
        <h2 style="#{optionclass}">#{note}</h2>
      </div>
    END
  end
  
  def current_user_can_manage?(user)
    (current_user.roles.collect{|r| r.manages}.flatten & user.roles).collect(&:id).sort == user.roles.collect(&:id).sort
  end
  
  def current_user_edit_path
    send("edit_#{current_user.primary_domain_type.downcase}_user_path", current_user)
  end
end
