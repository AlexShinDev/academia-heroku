require 'wikipedia'
class Article < ApplicationRecord

    belongs_to :user
    has_many :highlights

  def initialize(options_hash)
    super(options_hash)
    wiki_article = Wikipedia.find(name)
    wiki_content = wiki_article.sanitized_content.gsub(/(== ==|==)/, "<br />")
    update(
            url: wiki_article.fullurl,
            publisher: "Wikimedia Foundation, Inc",
            medium: "Web",
            content: wiki_content,
            image: wiki_article.main_image_url,
            summary: wiki_article.summary
            )
  end

  def generatebib
    sanitized_created_at = created_at.strftime("%d %B %Y")
    @biblio = "#{name}. 'Wikipedia: The Free Encyclopedia'. #{publisher}. #{medium}. #{sanitized_created_at}"
  end

  def self.rand_articles
    wiki_articles = []
    articles = []
    2.times do
      wiki_articles << Wikipedia.find_random
    end

    wiki_articles.each do |wiki_article|
      article = Article.new(
                            name: wiki_article.title,
                            url: wiki_article.fullurl,
                            image: wiki_article.main_image_url,
                            summary: wiki_article.summary
                            )
      articles << article
    end
    articles
  end


  def self.wiki_find(title)
    p title
    wiki_article = Wikipedia.find(title)

    wiki_content = wiki_article.sanitized_content.gsub(/(== ==|==)/, "<br />")
    article = Article.new(
                          name: wiki_article.title,
                          url: wiki_article.fullurl,
                          publisher: "Wikimedia Foundation, Inc",
                          medium: "Web",
                          content: wiki_content,
                          image: wiki_article.main_image_url,
                          summary: wiki_article.summary
                          )
    article
  end
end
