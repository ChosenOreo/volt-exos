Voltoid Exokernel Operating System
==================================
Downloads
---------
Kernel - Available soon!

What is Volt-ExOS
-----------------
The Voltoid Exokernel Operating System is designed to not implement
much of anything for itself. It's goal is to be as customizable and
modifiable as possible. This is possible by using a cross between an
[Exokernel](http://wiki.osdev.org/Exokernel) and a [Microkernel](http://wiki.osdev.org/Microkernel).

Functionality is implemented as services running in user-space. These
services (or libOSes) allow applications and drivers to execute in a
way not dictated by the kernel. The kernel's sole purpose is to
provide a slight abstraction on ports and memory. These abstractions
are only present to prevent security issues.

###Ports
Ports are assigned to specific services by the kernel using a map of
available ports. This allows specific services to act as a drivers to
applications and other services.

The ports assigned in the port map are not internet ports, but instead
I/O ports. Upon startup, a module is loaded into Ring 0 that detects
the ports of different hardware devices, and loads them into the port
map. This module is then unloaded.

###Memory
The only memory abstraction placed on services is the standard paging
abstraction. The memory allocator's job is to allocate pages for services
and applications. The memory allocator will pass the pages to a memory
manager based in Ring 3.

Documentation
-------------
Documentation for Volt-ExOS can be found in the ```/docs``` subdirectory of this
git repository.

Installation
------------
Since there is not currently a binary, and not enough code for a source
release, there are no installation instruction yet.
