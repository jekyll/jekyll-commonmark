# jekyll-cmark

*CommonMark Markdown converter for Jekyll*

[![Gem Version](https://img.shields.io/gem/v/jekyll-cmark.svg)](https://rubygems.org/gems/jekyll-cmark)
[![Build Status](https://img.shields.io/travis/pathawks/jekyll-cmark/master.svg)](https://travis-ci.org/pathawks/jekyll-cmark)
[![Dependency Status](https://img.shields.io/gemnasium/pathawks/jekyll-cmark.svg)](https://gemnasium.com/pathawks/jekyll-cmark)

Jekyll Markdown converter that uses [libcmark](https://github.com/jgm/CommonMark), the reference parser for CommonMark.

## Installation

Add the following to your `Gemfile`

```yaml
group :jekyll_plugins do
  gem 'jekyll-cmark', :github => 'pathawks/Jekyll-CMark'
end
```

and modify your `_config.yml` to use **CMark** as your Markdown converter

```yaml
markdown: CMark
```
