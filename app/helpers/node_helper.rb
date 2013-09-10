module NodeHelper

  def metadata(node)
    { title: node.title, content: node.content, author: node.user.name }
  end

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
    return [{ id: node.id, title: node.title, content: node.content, author: node.user.name }] if node.parent_node == 0
    parent_node = Node.find(node.parent_node)
    return [{ id: node.id, title: node.title, content: node.content, author: node.user.name }].concat(build_chain(parent_node))
  end
end
