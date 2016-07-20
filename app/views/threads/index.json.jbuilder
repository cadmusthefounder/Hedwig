json.threads      @threads do |thread|
  json.id           thread.id
  json.task_id      thread.task_id
  json.user_id      thread.user_id
  json.read         (thread.user == current_user ? thread.read_by_user : thread.read_by_owner)
  json.last_sent_at thread.last_sent_at
  json.created_at   thread.created_at
  json.updated_at   thread.updated_at
end
json.tasks        @tasks, :id, :from_address, :from_postal_code, :to_address, :to_postal_code, :user_id
json.users        @users, :id, :name
json.current_user current_user, :id, :name
