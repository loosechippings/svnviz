require 'rexml/document'
require 'rubygems'
require 'json'

$tree=Hash.new

def create_node(name)
  node=Hash.new
  node[:name]=name
  node[:count]=0
  node
end

def get_node(array,name)
  array.each { |node| return node if node[:name]==name }
  nil
end

def put_in_tree(node,tokens)
  return if tokens.length==0

  node[:children]=Array.new if node[:children]==nil
  array_of_children=node[:children]

  next_node=get_node(array_of_children,tokens.first)
  if next_node==nil
    next_node=create_node(tokens.first)
    array_of_children<<next_node
  end

  next_node[:count]+=1

  put_in_tree(next_node,tokens.drop(1))
end

xml=REXML::Document.new(File.open("./foo","r:UTF-8"))

xml.elements.each("//path") { |c|
  tokens=c.text.split('/')
  tokens.drop(1)  #remove stuff before the first slash
  put_in_tree($tree,tokens)
}

json=JSON.dump($tree)

File.open("output.js","w:UTF-8") { |file| file.puts "var dataset=#{json};"}