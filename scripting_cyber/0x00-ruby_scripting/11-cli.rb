#!/usr/bin/env ruby

require 'optparse'

FILE = 'tasks.txt'

def load_tasks
  return [] unless File.exist?(FILE)
  File.readlines(FILE).map(&:strip)
end

def save_tasks(tasks)
  File.open(FILE, 'w') do |f|
    tasks.each { |t| f.puts(t) }
  end
end

def add_task(task)
  tasks = load_tasks
  tasks << task
  save_tasks(tasks)
  puts "Task '#{task}' added."
end

def list_tasks
  tasks = load_tasks

  puts "Tasks:"
  puts

  tasks.each do |task|
    puts task
  end
end

def remove_task(index)
  tasks = load_tasks
  removed = tasks.delete_at(index - 1)

  if removed
    save_tasks(tasks)
    puts "Task '#{removed}' removed."
  end
end

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: cli.rb [options]"

  opts.on("-aTASK", "--add TASK", "Add a new task") do |task|
    options[:add] = task
  end

  opts.on("-l", "--list", "List all tasks") do
    options[:list] = true
  end

  opts.on("-rINDEX", "--remove INDEX", Integer, "Remove a task by index") do |index|
    options[:remove] = index
  end

  opts.on("-h", "--help", "Show help") do
    puts opts
    exit
  end
end.parse!

if options[:add]
  add_task(options[:add])
elsif options[:list]
  list_tasks
elsif options[:remove]
  remove_task(options[:remove])
else
  puts "Usage: cli.rb [options]"
end
