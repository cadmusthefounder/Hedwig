module StarsHelper
  def static_stars(stars)
    stars_str = (1..5).map do |i|
      if i <= stars
        %q(<i class="glyphicon glyphicon-star"></i>)
      else
        %q(<i class="glyphicon glyphicon-star-empty"></i>)
      end
    end.join('')

    %Q(<span class="stars">#{stars_str}</span>).html_safe
  end

  def stars_input(name: "rating", value: 0)
    id_prefix = SecureRandom.hex(5)


    stars_str = (1..5).to_a.reverse.map do |i|
      <<-HEREDOC
<input type="radio" name="#{name}" id="#{id_prefix}-#{i}" value="#{i}" #{i == value ? 'checked="true"' : ""}>
<label for="#{id_prefix}-#{i}" class="star-#{i}"><i class="glyphicon"></i></label>
      HEREDOC
    end.join('').gsub(/\n/, '')

    output = <<-HEREDOC
    <div class="stars-input">
      <span class="stars-container">
        #{stars_str}
      </span>
    </div>
    HEREDOC

    output.html_safe
  end
end
