#!/usr/bin/ruby

require 'rubygems'

require 'wirble'
Wirble.init :init_colors => true

alias x exit

require 'irb/ext/save-history'
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_PATH] = File::expand_path("~/.irb.history")
IRB.conf[:PROMPT_MODE] = :SIMPLE

# http://github.com/ryanb/dotfiles/blob/master/irbrc
load File.dirname(__FILE__) + '/.railsrc' if ($0 == 'irb' && ENV['RAILS_ENV']) || ($0 == 'script/rails' && Rails.env)
