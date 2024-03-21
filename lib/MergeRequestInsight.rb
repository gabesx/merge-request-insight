# frozen_string_literal: true

require_relative "MergeRequestInsight/version"

module MergeRequestInsight
  class Error < StandardError; end
  # frozen_string_literal: true

require 'httparty'
require 'date'

GITLAB_API_URL = 'https://gitlab.com/api/v4'
PROJECT_ID = ENV['GITLAB_PROJECT_ID']
ACCESS_TOKEN = ENV['GITLAB_ACCESS_TOKEN']

def fetch_merge_requests(project_id)
  headers = { 'PRIVATE-TOKEN': ACCESS_TOKEN }
  merge_requests = []
  page = 1

  loop do
    puts "Fetching merge requests, page: #{page}"
    response = HTTParty.get("#{GITLAB_API_URL}/projects/#{project_id}/merge_requests",
                            headers: headers,
                            query: { state: 'all', scope: 'all', per_page: 100, page: page })
    break unless response.success?

    merge_requests.concat(response.parsed_response)
    break if response.headers['x-next-page'].to_s.empty?

    page += 1
  end

  merge_requests
end

def fetch_merge_request_changes(project_id, merge_request_iid)
  headers = { 'PRIVATE-TOKEN': ACCESS_TOKEN }
  response = HTTParty.get("#{GITLAB_API_URL}/projects/#{project_id}/merge_requests/#{merge_request_iid}/changes",
                          headers: headers)
  return [] unless response.success?

  changes_response = response.parsed_response
  file_changes = []
  total_added = 0
  total_removed = 0

  # Process each change
  if changes_response['changes']
    changes_response['changes'].each do |change|
      added_lines = change['diff'].scan(/^\+/).count
      removed_lines = change['diff'].scan(/^-/).count
      total_added += added_lines
      total_removed += removed_lines

      file_change = {
        file_path: change['old_path'],
        added_lines: added_lines,
        removed_lines: removed_lines
      }
      file_changes << file_change
    end
  end

  { file_changes: file_changes, total_added: total_added, total_removed: total_removed }
end

def get_detailed_mr_info(project_id)
  merge_requests = fetch_merge_requests(project_id)
  merge_requests.map do |mr|
    puts "Processing MR IID: #{mr['iid']}"
    changes_data = fetch_merge_request_changes(project_id, mr['iid'])
    {
      author: mr['author']['username'],
      iid: mr['iid'],
      start_time: mr['created_at'],
      state: mr['state'],
      file_changes: changes_data[:file_changes],
      total_added: changes_data[:total_added],
      total_removed: changes_data[:total_removed],
      merged_time: mr['merged_at'],
      branch_name: mr['source_branch']
    }
  end
end

begin
  detailed_info = get_detailed_mr_info(PROJECT_ID)
  detailed_info.each do |info|
    puts "Merge Request Information"
    puts "-------------------------"
    puts "MR IID: #{info[:iid]}"
    puts "Branch: #{info[:branch_name]}"
    puts "Author: #{info[:author]}"
    puts "Start Time: #{info[:start_time]}"
    puts "State: #{info[:state]}"
    puts "Merged Time: #{info[:merged_time]}"
    puts "\nTotal Added Lines: #{info[:total_added]}"
    puts "Total Removed Lines: #{info[:total_removed]}"
    puts "\nFile Changes:"
    info[:file_changes].each do |change|
      puts "\tFile: #{change[:file_path]}"
      puts "\t\t+ Added Lines: #{change[:added_lines]}"
      puts "\t\t- Removed Lines: #{change[:removed_lines]}"
    end
    puts "\n-----------------------------------\n\n"
  end
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end

end
