class NodesController
  def index
    @all_nodes = Node.all 
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


  def destroy
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