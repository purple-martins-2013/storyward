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

  private

  def nodes_params
    return_params = params.require(:node).permit(:title, :content) 
    return_params[:parent_node] = params[:story_id]
    return_params 
  end
end
