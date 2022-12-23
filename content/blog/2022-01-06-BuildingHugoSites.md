+++
title = "Automatically deploy your Hugo website using Github actions"
date = 2022-01-06T06:00:00+00:00
tags = []
categories = []
+++

I've been dusting of this blog post in the last couple of weeks, and I thought it might be interesting to write about how I automatically deploy this website.

To achieve this, I'm using Github Actions as a CI/CD solution!

It essence, the actions works like this:

1. Github Actions watches my [repo](https://github.com/BasLangnberg/homecooked.nl) for new commit on the master branch
1. On commit, it spins up a worker running Ubuntu, which will clone this reposity
1. After the clone is done, the worker will update my theme of choice using a submodule
1. When this cloning is all done, Github Actions will setup Hugo in the build environment for me
1. Finally, it will build my site!
1. When the site is build, it is deployed to my VPS at DigitalOcean for you all to read

The setup uses some secrets. This is configured on the repository. I'm using a seperate user, which is only allowed to login over ssh with a public key, to deploy the website.

The yaml is in my Github repository, but I have included the yaml below for reference as well.

```yaml
name: CI
on:
  push:
    branches:
      - master
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Git checkout
        uses: actions/checkout@v2

      - name: Update theme
        run: git submodule update --init --recursive

      - name: Setup hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: "0.68.3"

      - name: Build
        # remove --minify tag if you do not need it
        # docs: https://gohugo.io/hugo-pipes/minification/
        run: hugo --minify

      - name: deploy website
        uses: appleboy/scp-action@master
        env:
          HOST: ${{ secrets.HOST }}
          USERNAME: ${{ secrets.USERNAME }}
          PORT: ${{ secrets.PORT }}
          KEY: ${{ secrets.KEY }}
        with:
          source: "public/*"
          target: "/home/gh-deploy/blog"
          strip_components: 1

```