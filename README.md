# Description

Do you have any Git repositories that you host on your own servers?
Would you like to ping services that require a GitHub hook?

Use this script as your post-receive script and you'll be able to.

# Usage

Given the quick-and-dirty nature of this script, it is recommended
that you use it only if you know what a post-receive hook is.

It looks for a file named `.git-post-receive-urls` in your home
directory. The file should be a YAML hash whose keys are the names of
repositories and whose values are arrays of URLs to post to.

    my-fancy-repo:
     - https://example.com/hooks?token=1234567890
     - https://example.com/other-hook

# License

The MIT License

Copyright (c) 2010 Geoffrey Grosenbach

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

