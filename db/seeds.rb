# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

6.times do |index|

  @user = User.create(name: "First Guy #{index}", email: "test#{index}@test.com", password: "password", password_confirmation: "password")

  @node = Node.create(title: "First #{index} Title", content: "First #{index} Content", parent_node: 0)

  @node.stories << Story.create(title: @node.title, user: @user)
  @node.save

  (rand(9) + 1).times do |n|
    new_node = Node.create(title: "Second #{index} Title #{n}", content: "Second #{index} Content #{n}", parent_node: @node.id)
    new_node.stories << Story.create(title: new_node.title, user: @user)
    new_node.save
    @node.children_nodes << new_node.id
    @node.children_nodes_will_change!
    @node.save
  end

  @node.children_nodes.each do |child|
    (rand(9) + 1).times do |n|
      new_node = Node.create(title: "Third #{index} Title #{n} #{child}", content: "Third #{index} Content #{n} #{child}", parent_node: child)
      new_node.stories << Story.create(title: new_node.title, user: @user)
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
      (rand(9) + 1).times do |n|
        new_node = Node.create(title: "Fourth #{index} Title #{n} #{child} #{mini_child}", content: "Fourth #{index} Content #{n} #{child} #{mini_child}", parent_node: mini_child)
        new_node.stories << Story.create(title: new_node.title, user: @user)
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
        (rand(9) + 1).times do |n|
          new_node = Node.create(title: "Fifth #{index} Title #{n} #{child} #{mini_child} #{tiny_child}", content: "Fifth #{index} Content #{n} #{child} #{mini_child} #{tiny_child}", parent_node: tiny_child)
          new_node.stories << Story.create(title: new_node.title, user: @user)
          new_node.save
          tiny_node = Node.find(tiny_child)
          tiny_node.children_nodes << new_node.id
          tiny_node.children_nodes_will_change!
          tiny_node.save
        end
      end
    end
  end

end
