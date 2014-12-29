logger.info @answer.errors
if  @answer.errors.present?
  json.errors @answer.errors
else
  json.partial! 'answers/answer'
end
