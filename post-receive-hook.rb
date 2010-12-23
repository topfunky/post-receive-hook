#!/bin/env ruby

# Minimally mimic the GitHub post-receive hook for private repositories.
#
# AUTHOR:   Geoffrey Grosenbach
#           http://peepcode.com
# CREATED:  3 August 2009
# MODIFIED: 23 December 2010

require 'rubygems'
require 'rest_client'
require 'json'
require 'grit'
require 'yaml'
include Grit

def receive_hook rev_old, rev_new, ref
  repository = Repo.new(".")
  commits = []
  range_flag = false
  repository.commits.each do |commit|
    # Works better than the flip flop operator
    if commit.id == rev_new
      range_flag = true
    elsif commit.id == rev_old
      range_flag = false
    end
    commits << commit if range_flag
  end

  # Required fields:
  # repository.name
  # commits => author.email message id url

  payload = {
    :payload => {
      #     :before     => before,
      #     :after      => after,
      :ref        => ref,
      :commits    => commits.map {|commit|
        {
          :id        => commit.id,
          :message   => commit.message,
          :timestamp => commit.committed_date.xmlschema,
          :url       => commit.id, # HACK: There's no public URL.
          #         :added     => array_of_added_paths,
          #         :removed   => array_of_removed_paths,
          #         :modified  => array_of_modified_paths,
          :author    => {
            :name  => commit.author.name,
            :email => commit.author.email
          }
        }
      },
      :repository => {
        :name        => File.basename(repository.path.gsub(/\.git/, '')),
        #       :url         => repository_url,
        #       :pledgie     => repository.pledgie.id,
        #       :description => repository.description,
        #       :homepage    => repository.homepage,
        #       :watchers    => repository.watchers.size,
        #       :forks       => repository.forks.size,
        #       :private     => repository.private?,
        #       :owner => {
        #         :name  => repository.owner.login,
        #         :email => repository.owner.email
        #       }
      }
    }
  }
  
  post_receive_urls = YAML.load_file(File.expand_path('~/.git-post-receive-urls'))
  post_receive_urls_for_project = post_receive_urls[payload[:payload][:repository][:name]]
  
  post_receive_urls_for_project.each do |url|
    RestClient.post(url, { :payload => payload[:payload].to_json })
  end
  
end

while (input = STDIN.read) != ''
  rev_old, rev_new, ref = input.split(" ")
  if ref == "refs/heads/master"
    puts "Running GitHub-style post-receive hook..."
    receive_hook(rev_old, rev_new, ref)
    puts "   done."
  end
end

