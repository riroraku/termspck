# termspck.sh - Run PHP easily and hassle-free!
A script that setups PHP environment for PHP development
It fetch all files available in the Spck Editor app.

This script solely made for Spck Editor as its code editor
to be run on any console apps (Termux in my case).
Since you can install various programming toolchain 
on termux, like the PHP for example, this scripts aids you
for that! Learning programming needs you to install a specific
IDE for that language.

This script targets devs that prefers CLI-based and/or people
prefers minimum effort and/or people wanted to setup their own
IDE and/or people that has termux installed on their devices!

## Dependency
* Termux [(F-Droid)](https://f-droid.org/en/packages/com.termux/) [(Google Play)](https://play.google.com/store/apps/details?id=com.termux) (or similar)
* Bash (should be!)
* PHP CLI
* cURL
* Spck Editor [(Google Play)](https://play.google.com/store/apps/details?id=io.spck)

You only need to install these major (2) in order to install all dependency
* Termux
  * Bash
  * PHP
  * cURL
* Spck Editor

### On Termux
First thing first install these packages:
To install `php` run these command:
```bash
pkg update && pkg upgrade -y && pkg install php -y
```
For the `bash` since termux uses `bash` run this 
to confirm:
```bash
bash --version
```
For `curl` it is installed by default on termux for others check using this command:
```bash
curl --version
```
If no `curl` installed please install it.

## termspck.sh - Setup
`termspck.sh` have (2) scripts, (1) is for file fetcher 
and the other (2) is for `php` server setup and watcher.
> NOTE: THESE (2) SCRIPTS SHOULD BE ON THE SAME DIRECTORY!
> UNLESS YOU KNOW WHAT YOURE DOING!!!
* `termspck.sh`
* `termspck-fetcher.sh`

### Installation via `git clone`
Clone this repo: 
```bash
git clone https://github.com/riroraku/termspck.git
```
Goto after cloning directory:
```bash
cd termspck
```
Add executable permission to scripts:
```bash
chmod 700 termspck.sh termspck-fetcher.sh
```

### Installation via `curl`
Make directory first and goto:
```bash
mkdir termspck && cd termspck
```
Fetch `termspck.sh` using this command:
```bash
curl 'https://raw.githubusercontent.com/riroraku/termspck/refs/heads/main/termspck.sh' -o termspck.sh
```
Fetch `termspck-fetcher.sh` using this command:
```bash
curl 'https://raw.githubusercontent.com/riroraku/termspck/refs/heads/main/termspck-fetcher.sh' -o termspck-fetcher.sh
``` 
Optional. Fetch license copy (XD)
```bash
curl 'https://raw.githubusercontent.com/riroraku/termspck/refs/heads/main/LICENSE' -o LICENSE
```
Add executable permission to scripts:
```bash
chmod 700 termspck.sh termspck-fetcher.sh
```

### Installation via Copy/Paste
Go to my repo `https://github.com/riroraku/termspck`:

Go on termux, make directory and goto:
```bash
mkdir termspck && cd termspck
```
Copy the file named `termspck.sh` then paste it using `cat`: 
```bash
cat > termspck.sh
```
Paste contents after the `cat`.

Do the same thing to other script `termspck-fetcher.sh`:
```bash
cat > termspck-fetcher.sh
```
Paste contents after the `cat`.

Add executable permission to scripts:
```bash
chmod 700 termspck.sh termspck-fetcher.sh
```

## termspck.sh - Running the script
The repo has (2) script but only one should be used. Although
the other script `termspck-fetcher.sh` is actually independent 
its a standalone script where the `termspck.sh` depends on.

But to effectively used it as intended, the `termspck.sh` should be
used instead of `termspck-fetcher.sh` - it fetches every 0.5s using
the `bash -c` with `sleep` and `curl` embedded on the script.

You can use `termspck-fetcher.sh` but only one-time unlike the 
`termspck.sh` which fetches files every 0.5s *you can actually modified its interval*

### Usage `termspck`
Displays help.
```bash
./termspck
```
```text
No arguments supplied!
Usage: ./termspck.sh [docroot] [port]
        [docroot]         PHP server docroot, also
                          the dir to store fetched files.
                          NOTE: Dont add additional '/'
                            [X] /sdcard/riro/
                            [/] /sdcard/riro
                          See PHP documentation.
        [port]            PHP server port. Use port
                          between 1024-49151.
                          See PHP documentation.

```
### Example
Before running the script open **Spck Editor** first
in order to initialize it localhost on port 7700.

```bash
mkdir php-dev-test
```
```bash
./termspck.sh php-dev-test 9999
```
Output after executing:
```text
~/git-testing/termspck $ ./termspck.sh php-dev-test 9999
CMD php -S ...  , PID: 18484
CMD bash -c ... , PID: 18485
To kill those processes, `kill -9 <PID>`, or
To check those processes, `kill -0 <PID>`
```
Confirm if all files are fetched:
```text
~/git-testing/termspck $ ls php-dev-test
LICENSE  README.MD  install.sh  termspck-fetcher.sh  termspck.sh
```
Confirm if `localhost:9999` is actually running, you can also view
php logs using this command:
```text
~/git-testing/termspck $ cat php-dev-test/.php.log
[Sun Nov  9 06:14:43 2025] PHP 8.4.2 Development Server (http://localhost:9999) started
[Sun Nov  9 06:19:52 2025] 127.0.0.1:43584 Accepted
[Sun Nov  9 06:19:52 2025] 127.0.0.1:43584 [404]: GET / - No such file or directory[Sun Nov  9 06:19:52 2025] 127.0.0.1:43584 Closing
[Sun Nov  9 06:19:52 2025] 127.0.0.1:43588 Accepted                                [Sun Nov  9 06:19:52 2025] 127.0.0.1:43588 [404]: GET /favicon.ico - No such file or directory
[Sun Nov  9 06:19:52 2025] 127.0.0.1:43588 Closing
```
Using `watch -n 1 'cat php-dev-test/.php.log'` will help you view log updates
every 1 second, use it on another tty window.

Checking [http://localhost:9999](http://localhost:9999) on browser if working:
![chrome screenshot working pho server](/.image/chrome-localhost-9999.jpg)

# Gotchas
The script fetches all files including sub-directories,
deleted files on Spck Editor doesnt reflect on CLI-side
but creating files would. Its advisable to remove that 
project directory of yours after session if you worry about
building up storage.

This script depends on Spck Editor's port 7700 if the devs of Spck Editor
Decided to change it you can modify these scripts if ever the devs change
its port.

Might not maintain this since its modifiable by most folks.

# LICENSE
MIT License

Copyright (c) 2025 riroraku

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

