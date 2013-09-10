module NodeHelper

  def create_json(node)
    return { id: node.id }, 1 if node.children_nodes.length == 0
    child_nodes = []
    node.children_nodes.each do |child|
      child_nodes << Node.find(child)
    end
    total_length = 0
    return {id: node.id, children: child_nodes.map { |child_node| child_json, child_length = create_json(child_node); total_length += child_length; child_json }, size: total_length**0.3 * 4 }, total_length
  end

  def build_chain(node)
    return [{ id: node.id, title: node.title, content: node.content }] if node.parent_node == 0
    parent_node = Node.find(node.parent_node)
    return [{ id: node.id, title: node.title, content: node.content }].concat(build_chain(parent_node))
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

end