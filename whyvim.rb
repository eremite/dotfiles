# I've been using vim for about 5 years. I chose vi over emacs because it is
# installed by default on almost all Linux distros. Learning how to use it was
# a gradual process, but now that I have tasted it's power I tend to do almost
# all my text editing in vim.

# Modal editing is intimidating at first. Much like the command line. At first
# you feel lost and limited, but once you learn what you are doing the
# possibilities are endless.

class WhyVim

  def movement
    puts "hjkl, for starters"
    puts "wb, for words, also BW"
    puts "f and friends: F;tT"
    puts "by (sentence), [[section]], {paragraph}"
    puts "|^start_of_line end_of_line$"
    puts "arbitrary line number, start (gg) or end of file (G)"
    puts "and of course, /?search"
  end

  def actions
    delete
    yank, put
    change replace
    . repeat
  end
  # also visual mode

  def text_objects
    %w(word paragraph "quotes")
  end

  def completion
    really_long_gnarly_variable_name
    lines
    paths
    (dictionary words, speling suggestings, omni, etc.)
  end

  def plugins
    if matchit
      puts %Q(awesome)
    end
    surround 'quote'
    tComment
    supertab
    rails
    vimscripts.org!
  end

  def duh
    undo/redo
    spellcheck
    auto-indent
    syntax highlighting
    search and replace
    macros
  end

  def disadvantages
    complex # easy to get lost
    scripting
    file management (tabs, etc.) # may be my fault
  end

  def more_cool_stuff
    registers
    search by keyword *#
    ctrl-a ctrl-x 1
    marks #`. ``
    help (holy-grail)
  end

end
