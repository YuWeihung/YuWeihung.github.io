# Hugo
export BLOG_HOME="$HOME/Blog"
export POST_HOME="$BLOG_HOME/content/posts"

alias hs="cd $BLOG_HOME && hugo server -D"
alias hd="cd $BLOG_HOME && sh deploy.sh"
alias hb="cd $BLOG_HOME && rm -rf public/* && hugo"
alias ht="cd $BLOG_HOME && rm -rf themes/PaperMod && git submodule update --remote --merge"

hn() {
    cd $BLOG_HOME && hugo new posts/$(date +%Y)/$1/index.md
}
