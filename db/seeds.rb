# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: "First Guy", email: "test@test.com", password: "password", password_confirmation: "password")

@node = Node.create(title: "First Title", content: "First Content", parent_node: 0)

@node.stories << Story.create(title: @node.title, user: User.first)
@node.save

5.times do |n|
  new_node = Node.create(title: "Second Title #{n}", content: "Second Content #{n}", parent_node: @node.id)
  new_node.stories << Story.create(title: new_node.title, user: User.first)
  new_node.save
  @node.children_nodes << new_node.id
  @node.children_nodes_will_change!
  @node.save
end

@node.children_nodes.each do |child|
  5.times do |n|
    new_node = Node.create(title: "Third Title #{n} #{child}", content: "Third Content #{n} #{child}", parent_node: child)
    new_node.stories << Story.create(title: new_node.title, user: User.first)
    new_node.save
    child_node = Node.find(child)
    child_node.children_nodes << new_node.id
    child_node.children_nodes_will_change!
    child_node.save
  end
end

@node.children_nodes.each do |child|
  child_node = Node.find(child)
  child_node.children_nodes.each do |mini_child|
    5.times do |n|
      new_node = Node.create(title: "Fourth Title #{n} #{child} #{mini_child}", content: "Fourth Content #{n} #{child} #{mini_child}", parent_node: mini_child)
      new_node.stories << Story.create(title: new_node.title, user: User.first)
      new_node.save
      mini_node = Node.find(mini_child)
      mini_node.children_nodes << new_node.id
      mini_node.children_nodes_will_change!
      mini_node.save
    end
  end
end

@node.children_nodes.each do |child|
  child_node = Node.find(child)
  child_node.children_nodes.each do |mini_child|
    mini_child_node = Node.find(mini_child)
    mini_child_node.children_nodes.each do |tiny_child|
      5.times do |n|
        new_node = Node.create(title: "Fifth Title #{n} #{child} #{mini_child} #{tiny_child}", content: "Fifth Content #{n} #{child} #{mini_child} #{tiny_child}", parent_node: tiny_child)
        new_node.stories << Story.create(title: new_node.title, user: User.first)
        new_node.save
        tiny_node = Node.find(tiny_child)
        tiny_node.children_nodes << new_node.id
        tiny_node.children_nodes_will_change!
        tiny_node.save
      end
    end
  end
end
