Linux in an hour
================


## Overview

A lot of servers use Linux and we need to use a server to run a few specific programmes so let's get familiar with Linux.

First of all, to connect to the server we will use a SSH connection. The idea is that we log in to the *remote* server from our *local* computer, so when we are running anything on the server we are using its hardware and infrastructure and our local computer is being used to simply view what is happening remotely and to input commands. 

Here is a diagram:

![ssh](http://www.ibm.com/developerworks/aix/library/au-sshsecurity/SSH_Protocol1.gif)


## Getting connected

We will use a programme called [Putty](http://www.putty.org/) to allow us to interact with the remote server, and a programme called [WinSCP](http://winscp.net/) to transfer files between our local computer and the remote server.


## Glossary

Term | Explanation
---- | -----------
[Unix](http://en.wikipedia.org/wiki/Unix) | An operating system like Windows but better
[Linux](http://www.ubuntu.com/) | An operating system based on Unix
[Command line](http://en.wikipedia.org/wiki/Command-line_interface) | The means of interacting with a computer program where the user issues commands to the program in the form of successive lines of text
[Local computer](http://en.wikipedia.org/wiki/Remote_computer) | The computer that you are using directly
[Remote computer](http://en.wikipedia.org/wiki/Remote_computer) | The computer you are interfacing with through a network connection. Also known as "Remote Server" or the "Host"
[SSH](http://en.wikipedia.org/wiki/Secure_Shell) | Secure shell - an encrypted method of connecting to a remote computer
[Putty](http://www.putty.org/) | A programme that is used to connect from a local Windows computer to a remote Unix computer
SFTP client | A programme that is used for transferring files to and from a local Windows computer and a remote computer
[WinSCP](http://winscp.net/) | An example of an SFTP client
[Public / private key pair](http://security.stackexchange.com/questions/25741/how-can-i-explain-the-concept-of-public-and-private-keys-without-technical-jargo) | A pair of files that are used to authenticate a user and can be used to connect to a server instead of having to type in a password



### Transferring files

We can transfer files between the local and remote computers by using an "SFTP client" (e.g. [WinSCP](http://winscp.net/)). Open up WinSCP and then type in the IP address and username:

![Remote server details](images/Untitled5.png)

Next click on "Advanced" then the "Authentication" tab on the left hand side of the new window:

![Authentication](images/Untitled6.png)

Click the "..." button to load a private key. Your private key is called `pelotas.ppk` and you should be able to find it on your USB stick.

![Find the Private key](images/Untitled7.png)

Success! You should see a new screen open up that looks like this:

![You have logged in](images/Untitled8.png)

The left hand side is where you can view the files on the local computer, the right hand side is the remote computer. You can copy files to and from local and remote by clicking and dragging.

Notice that the directory structure on the remote Linux computer can be navigated in exactly the same way as one would do on a Windows computer - i.e. it is an heirarchical file structure.



### Logging into the server 

We will use "Putty" to open up a command line interface to the remote server so that we can issue commands and interact etc. To connect we need to tell "Putty" the remote server's address and our security credentials. Open up "Putty" and type in the IP address:

![Remote server details](images/Untitled.png)

Next click on "SSH" on the left panel and then "Auth":

![Authentication](images/Untitled2.png)

Click "Browse" and find the `pelotas.ppk` private key on the USB stick again.

![Find the Private key](images/Untitled4.png)

If you now click on "Session" again you can enter a name in the "Saved sessions" box and click "Save". This will make Putty remember your settings for next time. Now click "Open" and a black screen will appear. Type in your username when it prompts you and we should be granted access. You now have a command line interface into the remote server. Whatever you type in this window will be executed on the remote server. 



## Directory structure and navigation

The files and folders on Linux are organised in the same way as they are in Windows - in a heirarchical structure. At the very top of the structure is the **root** directory which is denoted by a single slash `/`. Everything else is a sub-directory (or sub-sub-directory or sub-sub-sub-directory etc) of the root directory. The Unix "root" directory is a bit like the "My Computer" folder in Windows.

As a user you have a home directory, *e.g.* the directory for user **pelotas1** is located at `/home/pelotas1`. Now that you have loogged in you can see the "path" to your home directory:

	pwd

This command tells you your present working directory, or where you are in the file system heirarchy at this moment.

We can see what files are in this directory using the `ls` command:

	ls

If we want to see details about the files we can pass a "flag" to the `ls` command:

	ls -l

This shows you the file permissions, the file owner, the user group, the file size in bytes, when it was last modified, and finally, the file name itself.

To navigate to a different directory we use the `cd` command. Let's navigate into the `pelotas_2015` directory and see what files are there:

	cd pelotas_2015
	ls -l



The command line always  We can move from one folder to another using the `cd` command. For example, to 


When the user **pelotas1** logs into the server they are automatically taken to their home directory


3. directory navigation

The Linux filesystem is a tree-like hierarchy hierarchy of directories and files. At the base of the filesystem is the “/” directory, otherwise known as the “root” (not to be confused with the root user). Unlike DOS or Windows filesystems that have multiple “roots”, one for each disk drive, the
Linux filesystem mounts all disks somewhere underneath the / filesystem. The following table
describes many of the most common Linux directories.


- viewing and editing files
- run scripts (cancelling something)
- running R
- data manipulation
- piping
- using scripts




less ~/




sleep 20
Press `ctrl` + `c` to stop the application from running





cd ../
ls -l ../../

cd ~/
cd -

echo ${HOME}

datadir="/pelotas_2015"
echo ${datadir}

ls -l ${datadir}

man grep

