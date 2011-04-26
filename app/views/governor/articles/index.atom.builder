atom_feed do |feed|
  feed.title("#{mapping.humanize} feed")

  unless resources.empty?
    feed.updated(resources.first.updated_at)

    resources.each do |article|
      feed.entry(article) do |entry|

        entry.title article.title
        entry.summary(article.description) if article.description.present?
        entry.content truncate(strip_tags(Governor::Formatters.format_article(article)), :length => 100)

        entry.author do |author|
          author.name article.author.name
          author.uri article.author.website
        end
      end
    end
  end
end