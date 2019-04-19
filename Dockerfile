FROM github_homepage:v1

VOLUME ["/homepage"]

WORKDIR /homepage/qwer6019.github.io

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--livereload", "--host", "0.0.0.0"]
