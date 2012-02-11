# Kingpin

Kingpin is an open source platform as a service.

## Usage

    $ pin create awesome
    Creating application "awesome"... done.
    Added git remote "kingpin".

    $ git push kingpin master
    Counting objects: 69, done
    Delta compression using up to 4 theads.
    Compressing objects: 100% (52/52), done.
    Writing objects: 100% (69/69), 95.53 KiB, done.
    Total 69 (delta 5), reused 0 (delta 0)

    Deploying Ruby on Rails application to /srv/apps/awesome.

    Installing dependencies...
      $ bundle install --deployment
      > Fetching source index for http://rubygems.org/
      > Installing rake (0.8.7)
      > ...
      > Installing rails (3.1)

    Exporting processes to upstart...
      $ foreman export upstart /etc/init/awesome
      > [foreman export] writing: /etc/init/awesome.conf
      > [foreman export] writing: /etc/init/awesome-web.conf
      > [foreman export] writing: /etc/init/awesome-web-1.conf
      > [foreman export] writing: /etc/init/awesome-worker.conf
      > [foreman export] writing: /etc/init/awesome-worker-1.conf

    Deployment complete.

## Contribute

* Fork the repository.
* Do your thing.
* Open a pull request.
* Receive cake.

## Installation

Nuh-uh — it's not ready yet.
