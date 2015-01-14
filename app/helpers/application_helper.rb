module ApplicationHelper

  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : ''

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

  def vote_for(object)
    name = object.class.name.underscore
    content_tag :div, class: 'votes' do
      html =  link_to fa_icon('thumbs-up'),
                      vote_up_path(name, object.id),
                      remote: true,
                      method: :post,
                      title: "Vote Up",
                      class: vote_class(object, true)
      html += content_tag :span, object.vote_count, class: 'votes_count'
      html += link_to fa_icon('thumbs-down'),
                      vote_down_path(name, object.id),
                      remote: true,
                      method: :post,
                      title: "Vote Down",
                      class: vote_class(object, false)
    end
  end

  def vote_class(object, flag)
    current_user && current_user.voted_for?(object, flag) ? 'disabled' : ''
  end
end
