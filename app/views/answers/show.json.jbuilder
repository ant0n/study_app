json.(@answer, :id, :body)

json.attachments @answer.attachments do |a|
  json.url a.file.url
  json.name a.file.identifier
end

json.edit_url edit_question_answer_path(@answer.question, @answer) if @answer.author == current_user