#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require_relative 'lib/grabber'

grabber = Grabber.new(url: ARGV[0], save_dir: ARGV[1])
grabber.grab