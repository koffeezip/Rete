# <img src="assets/rete.png" alt="drawing" width="21"/>ete, a basic URL checker.

## Usage
The basic usage to rete is `rete [arguments] [file/urls]`
there are a few flags you can use.
Example: `rete https://google.com https://fakeurl.bleb https://example.com`

### File flag
This flag allows you to check a list of urls in a txt file.
Example: `rete -f urls.txt`
#### Output flag
This flag lets you chose the name of the file outputted by the file flag.
Note: This flag but be used BEFORE the file flag is used
Example: `rete -o output.txt -f urls.txt`

### Timeout flag
This flag lets you chose how many seconds to wait for a connection until rete declares timeout.
Example: `rete -t 1 https://google.com https://fakeurl.bleb https://example.com`

## Compiling
Since this program was made with crystal, you need to install crystal and shards which is available in most package managers and windows.

### Installing dependencies
going into where the source code is and then run `shards install` which installs all of the dependencies.

### Creating the executable
To create the executable, run `shards build rete` where the binary will be in the bin directory.

## FAQ

### What is Rete?
Rete is a utility that can check if a URL/website is really up or not.

### Whats the point of having it when I can check my self?
Rete allows you to bulk check URLs which can be time saving.

### What about bot detection?
Rete uses that to our advantage by looking at the status code (eg, a websites returns 403)

### Why did you make this?
When making a list of games and proxies, I needed to test if the links really worked without having to test them all individually (I had over 6000 links to check!)