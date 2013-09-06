class NodesController
  def index
    @nodes = Node.all 
  end

  def new
    @node = Node.new #for form_for
  end

  def create
    @node = Node.new(nodes_params)
    if @node.save
      redirect_to @node
    else
      render :new
    end
  end

  def show
    @node = Node.find(nodes_params[:node])
  end

  def destroy
    node = Node.find(nodes_params[:node])

    unless node.children_nodes.any? 
      node.destroy
      redirect_to root_url
    else
      redirect_to :back, notice: "Node cannot be deleted because it has children."
    end
  end

  private

  def nodes_params
    params.require(:nodes).permit(:title, :content)
  end
end