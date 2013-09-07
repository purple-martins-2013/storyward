class NodesController < ApplicationController

  def index
    @nodes = Node.all 
  end

  def new
    @node = Node.new #for form_for
  end

  def create
    @node = Node.new(nodes_params)
    if @node.save
      redirect_to story_node_path(params[:story_id], @node.id)
    else
      render :new
    end
  end

  def show
    @node = Node.find(params[:id])
  end

  def edit
    @node = Node.find(params[:id])
  end

  def update
    Node.find(params[:id])
    @node = Node.find(params[:id])
    unless @node.children_nodes.any?
      @node.update(nodes_params)
      @node.save
      redirect_to story_node_path(params[:story_id], @node.id)
    else
      redirect_to :back, notice: "Node cannot be edited because it has children."
    end
  end

  def destroy
    @node = Node.find(params[:id])
    unless @node.children_nodes.any? 
      @node.destroy
      redirect_to root_url
    else
      redirect_to :back, notice: "Node cannot be deleted because it has children."
    end
  end

  def query
    render json: Node.find(params[:id]).to_json
  end

  def details
    @node = Node.find(params[:id])
    render json: create_json(@node).to_json
  end

  def create_json(node)
    return { id: node.id } if node.children_nodes.length == 0
    child_nodes = []
    node.children_nodes.each do |child|
      child_nodes << Node.find(child)
    end
    return {id: node.id, size: node_size(node), children: child_nodes.map { |child_node| create_json(child_node) } }
  end

  def node_size(node)
    child_nodes_length = 0
    node.children_nodes.each do |child|
      child_nodes_length +=  Node.find(child).children_nodes.length
    end
    return node.children_nodes.length + child_nodes_length / 4
  end

  private

  def nodes_params
    return_params = params.require(:node).permit(:title, :content) 
    return_params[:parent_node] = params[:story_id]
    return_params 
  end
end
