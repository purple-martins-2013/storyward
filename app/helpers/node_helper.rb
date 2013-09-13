module NodeHelper

  def create_json(node)
    return { id: node.id, author: node.user.name }, 1 if node.children_nodes.length == 0
    child_nodes = []
    node.children_nodes.each do |child|
      child_nodes << Node.find(child)
    end
    total_length = 0
    return {id: node.id, author: node.user.name, children: child_nodes.map { |child_node| child_json, child_length = create_json(child_node); total_length += child_length; child_json }, size: total_length**0.3 * 4 }, total_length
  end

  def build_chain(node)
    return [node.as_hash] if node.parent_node == 0
    parent_node = Node.find(node.parent_node)
    return [node.as_hash].concat(build_chain(parent_node))
  end

  def process_upload
    if params[:story] && params[:story][:upload]
      uploaded_io = params[:story][:upload]
      filetype = uploaded_io.original_filename.split(".").last.downcase

      content = []
      case filetype
      when "pdf"
        File.open(uploaded_io.tempfile, "rb") do |io|
          reader = PDF::Reader.new(io)
          reader.pages.each do |page|
            content << page.text.gsub(/\n\n\n*/, "</p><p>")
          end
        end
        params[:node][:content] = "<p>" + content.join("</p><p>") + "</p>" + params[:node][:content]

      when "txt"  
        uploaded_io.read.force_encoding("ISO-8859-1").encode("utf-8", replace: nil).each_line do |line|
          content << line
        end
        params[:node][:content] = (content.join(" ") + "\n" + params[:node][:content])
      end
    end
  end  

  def create_nodes
    @story.node = Node.create(node_params)
    @story.node.user = current_user
    unless @story.node.parent_node == 0
      @parent_node = Node.find(@story.node.parent_node)
      @parent_node.children_nodes << @story.node.id
      @parent_node.children_nodes_will_change!
    end
  end

  def upload_into_content
    @saved_title = params[:node][:title]
    @uploaded_content = params[:node][:content]
    @saved_tags = params[:story][:tag_list]
    @parent_node = params[:node][:parent_node] if params[:node][:parent_node] != "0"
    @story = Story.new
    @story.build_node
  end

  def create_story
    @story_params[:title] = node_params[:title]
    @story = Story.new(@story_params)
    @story.user = current_user
    @story.tag_list = params[:story][:tag_list]
  end

  def update_story
    @story_params[:title] = node_params[:title]
    @story_params[:tag_list] = params[:story][:tag_list]
  end

  def update_node
    @story.node.update_attributes(node_params)
  end

  def populate_edit_fields
    @existing_title = @story.title
    @existing_content = @story.node.content
    @existing_tags = @story.tag_list
    @parent_node = @story.node.parent_node.to_s if @story.node.parent_node != 0
  end

  def edit_page_upload
    @existing_title = params[:node][:title]
    @existing_content = params[:node][:content]
    @existing_tags = params[:story][:tag_list]
    @parent_node = params[:node][:parent_node] if params[:node][:parent_node] != "0"
  end

end
