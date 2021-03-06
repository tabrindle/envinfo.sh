<p align="center">
  <img src="https://raw.githubusercontent.com/tabrindle/envinfo.sh/master/logo.png" align="center"  width="700px"/>
  <h3 align="center">envinfo.sh generates a report of the common details needed when troubleshooting software issues, such as your operating system, binary versions, browsers, installed languages, and more</h3> 
  <hr/>
</p>

## The problem

-   It works on my computer
-   "command not found"
-   what version of "command" are you running?
-   what version of "different command" are you running?
-   do you have "insert obscure android sdk version"?
-   every github issue reporting template ever:

**Please mention other relevant information such as the browser version, Node.js version, Operating System and programming language.**

## This solution

-   Gather all of this information in one spot, quickly, and painlessly.

## Usage

-   In your terminal: `curl https://raw.githubusercontent.com/tabrindle/envinfo.sh/master/envinfo.sh | bash`
-   Or for short: `curl -L getenv.info | bash`

## Security

- Piping a script from the internet directly to your shell is generally frowned upon for many reasons, one being it could contain nefarious or incomplete code. 
- If this is a concern, you may want to download it directly from github via https (not through my convenient domain), inspect it for correctness and completeness, then only then run it.
- There is no need to run sudo with this script, so please don't.
- If there is any doubt, do not run this on any production system. 

## Alternatives

-   type `command -v` until you smash your computer
-   [envinfo](https://github.com/tabrindle/envinfo) - the original node based version of this project
-   [specs](https://github.com/mcandre/specs) - an excellent ruby gem that runs `command -v` for you on :all-the-things: Great for raw info.
-   [screenfetch](https://github.com/KittyKatt/screenFetch) - fetch system and terminal information, and display a pretty ascii logo
-   [Solidarity](https://github.com/infinitered/solidarity) - a project based environment checker
-   write your own

## License

MIT
