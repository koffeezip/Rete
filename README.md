# <img src="assets/rete.png" alt="drawing" width="21"/>ete, a basic URL checker.

## What is Rete?
Rete is a utility that can check if a URL/website is really up or not.

## Whats the point of having it when I can check my self?
Rete allows you to bulk check URLs which can be time saving.

## What about bot detection?
Rete uses that to our advantage by looking at the status code (eg, a websites returns 403)

## Why did you make this?
When making a list of games and proxies, I needed to test if the links really worked without having to test them all individually (I had over 6000 links to check!)

## Creating an executable
First you must install all of the dependencies. You can install them quickly by running `pip install -r requirements.txt`. After that you can run pyinstaller, the python program that can create an executable from a python program. You can make the executable by running `pyinstaller main.py -F -n rete` This creates a single file executable named reta.