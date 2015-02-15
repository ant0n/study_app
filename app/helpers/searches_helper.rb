module SearchesHelper

  def show_result(group, values)
    html  = content_tag :h2, group.pluralize(values.count)
    html += content_tag :ul do
      render_list(group, values)
    end
  end

  def render_list(group, values)
    values.map do |o|
      if group == 'answer'
        content_tag :li, link_to(truncate(o.body, length: 50 ), question_path(o.question_id)+"#answer_#{o.id}")
      elsif group == "question"
        content_tag :li, link_to(truncate(o.title, length: 50 ), question_path(o.id))
      elsif group == "comment"
        content_tag :li, link_to(truncate(o.body, length: 50 ), question_path(o.id))
      end
    end.reduce(:<<)
  end

end
