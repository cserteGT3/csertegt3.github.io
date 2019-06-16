@def title = "Setup Jekyll on Windows"
@def hascode = true

This is a small guide for setting up Jekyll on Windows.
Mostly it's just a link collection.
I gathered it for myself, but it's not important by now, as I use [JuDoc.jl](https://github.com/tlienart/JuDoc.jl).

## Install Ruby

On Windows with [RubyInstaller](https://rubyinstaller.org/).
You need to download the **Ruby+Devkit** version.
After installing Ruby, install the necessary things from command line too.
Validate your install with `ruby -v` and `gem -v`

## Install Jekyll

[This](https://jekyllrb.com/docs/installation/windows/) is the official guide.
Install Jekyll and Bundler from command prompt: `gem install jekyll bundler`.
Validate with `jekyll -v`.

## Other things (on Windows)

Now Jekyll should be installed properly.
If you already have a GithubPage, then clone it, and run `jekyll serve`.
If it throws an error, these steps may help:

### Updates

It's possible that you need to update your softwares (but I'm not sure when):
```bash
gem update --system
```

### Neo-Hpstr-Theme dependencies

On it's [GitHub page](https://github.com/aron-bordin/neo-hpstr-jekyll-theme) you'll find a short list, how to install the needed gems. The only necessary thing should be: go into your cloned repository and run: `bundle install`. This installs the needed gems for this theme.

### Add tzinfo for Windows

[This](https://github.com/jekyll/jekyll/issues/5935) GitHub issue will help you.
In short:

* run `gem install tzinfo`
* run `gem install tzinfo-data`

Add the following lines in the `Gemfile`:
```
gem 'tzinfo', '2.0.0'
gem 'tzinfo-data', '1.2018.9'
```
The version numbers(?) should be as the installed ones.


With these `jekyll serve` should work properly.

## Create batch file

Create a `.bat` file:
```
cd "path_to_your_github_repo"

jekyll serve
```
