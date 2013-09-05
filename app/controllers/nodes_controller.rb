class NodesController
  def index
    @all_nodes = Node.all 
  end

  def new
    @node = Node.new #for form_for
  end

  def create
    nodes = Nodes.create(nodes_params)
  end

  private

  def nodes_params
    params.require(:nodes).permit(:title, :content)
  end
end