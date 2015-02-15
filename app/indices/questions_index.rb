ThinkingSphinx::Index.define :question, with: :active_record do

  #fields
  indexes title, sortable: true
  indexes body
  #indexes author.email, as: :author, sortable: true
  #indexes answers.body, as: :answers
  #indexes answers.comments.body, as: :answers_comments
  #indexes comments.body, as: :comments

  # attributes
  has author_id, created_at, updated_at

end