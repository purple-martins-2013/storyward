class NodesController
  def index
    @all_nodes = Node.all 
  end

  def new
    @node = Node.new #for form_for
  end

  def create
    nodes = Node.create(nodes_params)
  end

  def delete
    node = Node.find(params[:node])
    
    if node.terminal? 
      node.destroy
    else
      redirect_to :back, notice: "Node cannot be deleted because it has children."
    end

  end

  private

  def nodes_params
    params.require(:nodes).permit(:title, :content)
  end
end