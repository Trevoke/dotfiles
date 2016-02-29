
# This is gonna break something, I know it.
#Pry.config.editor = "emacsclient"
#Pry.config.editor = -> { |file, line| "emacsclient #{file} +#{line}" }
#Pry.config.prompt_name = Dir.getwd.split(File::SEPARATOR).last

# class Emacsable
#   def self.readline(prompt)
#     print prompt
#     (gets || "").chomp
#   end
# end
#
# Pry.config.input = Emacsable



if ENV["EMACS"]
  Pry.config.correct_indent = false
  Pry.config.pager = false
end
