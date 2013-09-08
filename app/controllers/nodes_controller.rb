class NodesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]

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
    render json: create_json(@node)[0].to_json
  end

  def chain
    @node = Node.find(params[:id])
    render json: build_chain(@node).reverse.to_json
  end

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

  private

  def nodes_params
    return_params = params.require(:node).permit(:title, :content) 
    return_params[:parent_node] = params[:story_id]
    return_params 
  end
end
