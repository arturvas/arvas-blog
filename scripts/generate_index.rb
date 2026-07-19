#!/usr/bin/env ruby
# frozen_string_literal: true

require 'yaml'
require 'date'

CONTENT_DIR = 'content'
INDEX_FILE = "#{CONTENT_DIR}/_index.md"
FRONTMATTER_DELIMITER = '---'

def escape_markdown(text)
  text.to_s.gsub('[', '\\[').gsub(']', '\\]')
end

def extract_frontmatter(content)
  return nil unless content.start_with?("#{FRONTMATTER_DELIMITER}\n")

  end_index = content.index("\n#{FRONTMATTER_DELIMITER}\n", 4)
  return nil unless end_index

  yaml_content = content[4..end_index]
  YAML.safe_load(yaml_content, permitted_classes: [Date, Time])
end

def parse_post(path)
  content = File.read(path)
  frontmatter = extract_frontmatter(content)
  return nil unless frontmatter&.dig('title') && frontmatter&.dig('date')

  date = DateTime.parse(frontmatter['date'].to_s)
  base_path = path.sub(%r{/index\.md\z}, '')
  dir_url = base_path.delete_prefix("#{CONTENT_DIR}/") # e.g. posts/2026/07/18/hello

  { title: frontmatter['title'], url: "/#{dir_url}/", date: date }
rescue ArgumentError, Psych::SyntaxError => e
  warn "Error parsing #{path}: #{e.message}"
  nil
end

def collect_posts(include_future: false)
  now = DateTime.now
  Dir.glob("#{CONTENT_DIR}/posts/**/index.md")
     .filter_map { |path| parse_post(path) }
     .select { |post| include_future || post[:date] <= now }
end

def group_by_month(posts)
  posts
    .sort_by { |post| post[:date] }
    .reverse
    .group_by { |post| [post[:date].year, post[:date].month] }
end

PT_MONTHNAMES = [nil, 'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
                 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'].freeze

def render_months(grouped_posts)
  sorted_months = grouped_posts.keys.sort.reverse
  lines = []

  sorted_months.each do |(year, month)|
    lines << "## #{year} - #{PT_MONTHNAMES[month]}\n"

    grouped_posts[[year, month]].each do |post|
      lines << "- [#{escape_markdown(post[:title])}](#{post[:url]})"
    end

    lines << ''
  end

  lines
end

def generate_index(grouped_posts)
  lines = ["#{FRONTMATTER_DELIMITER}\ntitle: ArVas\n#{FRONTMATTER_DELIMITER}\n"]
  lines << 'Diário de um brasileiro estudando medicina na UNLP, La Plata, Argentina.'
  lines << ''
  if grouped_posts.empty?
    lines << '_Ainda sem posts. Em breve!_'
  else
    lines.concat(render_months(grouped_posts))
  end
  lines.join("\n")
end

include_future = ARGV.include?('--future')
posts = collect_posts(include_future: include_future)
grouped = group_by_month(posts)

File.write(INDEX_FILE, generate_index(grouped))
puts "Generated #{INDEX_FILE} with #{posts.size} posts.#{' (including future posts)' if include_future}"