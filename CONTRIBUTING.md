# Contributing

Great to have you here. Here are a few ways you can help make this project better!

## Before You Contribute

Please take a couple minutes to read through [code of conduct](CODE_OF_CONDUCT.md). By participating here, you are expected to folow and uphold this code. Please notify me of any unacceptable behavior.

## Developing and Testing the script

I used [Laravel Homestead](https://laravel.com/docs/5.5/homestead#per-project-installation) per project installation to develop the bash script, and I use `vagrant reload --provision` to test script tweaks.

I also recoomend setting up a root password on Homestead, so you can run the script as root like Forge does. Just ssh into Homestead and run `sudo passwd root` to setup a root password, the use the `su` command to become root.

## Bug Reports & Feature Requests

Before submitting bug reports and feature requests, please search through [open issues](https://github.com/dative/craft-do-forge-recipe/issues) to see if yours has already been filed.

If you do find a similar issue, upvote it by adding a :thumbsup: [reaction](https://github.com/blog/2119-add-reactions-to-pull-requests-issues-and-comments). Only leave a comment if you have relevant information to add.

If no one has filed the issue yet, [submit a new one](https://github.com/dative/craft-do-forge-recipe/issues/new). Please include a clear description of the issue, and as much relevant information as possible, including a code sample demonstrating the the issue.