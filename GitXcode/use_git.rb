#!/usr/bin/env ruby

PROJECT_TEMPLATE_PATH = "/Developer/Library/Xcode/Project Templates/"

project_template_directories = [
  "Application/",
  "Audio Units/",
  "Bundle/",
  "Command Line Utility/",
  "Dynamic Library/",
  "Framework/",
  "Kernel Extension/",
  "Standard Apple Plug-ins/",
  "Static Library/"
]

def create_git_files_in_path path
  gitignore_file_content = [
    "# xcode noise",
    "build/*",
    "*.pbxuser",
    "*.move1v3",
		"*.perspective",
		"*.perspectivev3",
    "",
    "# old skool",
    ".svn",
    "",
    "# osx noise",
    ".DS_Store",
    "profile",
		"*.swp",
		"*~.nib"
  ]

  gitignore = File.new(path + "/.gitignore", "w")
  gitignore.puts gitignore_file_content.join("\n")

  gitattributes = File.new(path + "/.gitattributes", "w")
  gitattributes.puts "*.pbxproj -crlf -diff -merge"
end

project_template_directories.each do |project_category_name|
  Dir.foreach(PROJECT_TEMPLATE_PATH + project_category_name) do |template_dir|
    create_git_files_in_path PROJECT_TEMPLATE_PATH + project_category_name + template_dir if !template_dir.include? "." # Skipping hidden directories 
  end
end


