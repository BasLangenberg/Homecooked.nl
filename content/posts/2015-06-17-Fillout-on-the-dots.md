---
date: 2015-06-17T19:02:32+02:00
title: fill out on the dots
---

It seems like holiday is almost over. When my daughter was born on the first of June, I took three weeks of for getting to know her and assist mom with the changes. Of course I needed to get myself in a different gear to. I am a new daddy again and I could not be more excited.

I forgot how much a new baby puts on you in the terms of spare time though, so I only was able to work on setting up my shell environment this morning. My wife had a rough night, so she and the baby slept latethis morning. I had to be at the car mechanic at 08:00 in the morning so I was up kinda early. Gave me a couple of hours when I got back to fiddle. :-)

I wanted to organize my dotfiles on GutHub. I [already did so](https://github.com/BasLangenberg/dotfiles), but this could be better. There was no portability in this, and I needed to do a bit of manual labor if I wanted to set it up on other servers. Also, my bash config was kinda vanilla. This should improve.

I did some reading and noticed that there are like a million different people doing dotfiles in a million different ways. I made up a complex scheme in my head about configuring Bash to make the most of it. It turned out I needed a week to sort out the configurations I wanted, put them together in a million files and set it up in a maintanable way. I do not have the time to do that. I need to get into projects and need to start studying for certificates soon.

I went over to the fantastic [GitHub Dotfiles](http://dotfiles.github.com) website and noticed that there was a project called bash-it. This is a framework for Bash configuration. I went ahead and installed it. Done. I can always improve this setup and issue a pull request to the project if I want something to change. Worst case I can fork the entire project for my own use. I love opensource!

I did version my bashrc and my vimrc on GitHub in my dotfiles repository. This is what I use to setup bash-it and vim itself. I also created an installer script, which is not yet finished. You can [have a look](https://github.com/BasLangenberg/dotfiles) if you like, but it is nothing special. I do try to contain this in a seperate directory, so symlinks are made from my home directory to it. I tried to version my entire home directory, but that didn't really work out as I wanted.

Next to the shell files, the install script installs Vundle + all of the Vim plugins I am using. At the moment this is only Vundle but when I start developing this will most likely be much, much more...

I hope to be able to build a [Vagrant](https://vagrantup.com) box with [Packer](https://packer.io/) and get my feet wet on [Docker](https://docker.com) before leaving for London on Friday, but I am not sure if I have the time. More on these projects in a future blogpost! 
