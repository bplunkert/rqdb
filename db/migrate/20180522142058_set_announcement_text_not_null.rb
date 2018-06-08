class SetAnnouncementTextNotNull < ActiveRecord::Migration[5.2]
 def change
   change_column_null :announcements, :text, false
  end
end
