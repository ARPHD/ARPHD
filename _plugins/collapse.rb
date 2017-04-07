module Jekyll
  module Collapse
    def collapse(input, index=1)
      questions = input.split("<h3")
      # Remove first, it's a residue of h1
      leftover = questions.shift();
      output = '<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">'
      #output += '<!-- '+leftover+'-->' 
      if leftover.start_with?("<p>")
        output += '<div class="panel-body">' + leftover + '</div>'
      end
      id = 1
      for q in questions
        suffix = index.to_s + '_' + id.to_s;
        if q != ""
          output += '<div class="panel panel-default">
          <div class="panel-heading" role="tab" id="question_' + suffix + '">
          <h4 class="panel-title">
          <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse_' + suffix + '" aria-expanded="false" aria-controls="collapse_' + suffix + '">'

          tokens = q.split(">")
          j = 0
          for title in tokens
            if j == 1
              output += title.split("<")[0]
            end
            j += 1
          end

          output += '</a></h4></div>
          <div id="collapse_' + suffix + '" class="panel-collapse collapse" role="tabpanel" aria-labelledby="question_' + suffix + '">
          <div class="panel-body">'

          answer = q.split("<p>")
          k = 0;
          for a in answer
            if k != 0 and a.length != 0
              output += '<p>' + a
            end
            k += 1
          end

          output += '</div></div></div>'
        end
        id += 1
      end

      # No questions      
      if id == 1
        tmp = leftover.split('<')
        tmp.shift(2);
        output += '<div class="panel-body"><' + tmp.join('<') + '</div>'
      end

      output += '</div>'

      return output
    end
  end
end

Liquid::Template.register_filter(Jekyll::Collapse)
